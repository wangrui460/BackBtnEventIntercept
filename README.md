# BackBtnEventIntercept
系统返回按钮事件拦截
[Swift 版本](https://github.com/wangrui460/BackBtnEventIntercept_swift)

- **主要实现原理**

<pre><code>
@implementation UINavigationController (ShouldPopOnBackBtn)

- (BOOL)navigationBar:(UINavigationBar *)navigationBar shouldPopItem:(UINavigationItem *)item
{
    BOOL shouldPop = YES;
    // 看一下当前控制器有没有实现代理方法 currentViewControllerShouldPop
    // 如果实现了，根据当前控制器的代理方法的返回值决定
    // 没过没有实现 shouldPop = YES
    UIViewController* currentVC = [self topViewController];
    if([currentVC respondsToSelector:@selector(currentViewControllerShouldPop)]) {
        shouldPop = [currentVC currentViewControllerShouldPop];
    }

    if(shouldPop)
    {
        dispatch_async(dispatch_get_main_queue(), ^{
            [self popViewControllerAnimated:YES];
        });
        // 这里要return, 否则这个方法将会被再次调用
        return YES;
    }
    else
    {
        // 让系统backIndicator 按钮透明度恢复为1
        for(UIView *subview in [navigationBar subviews]) {
            if(0. < subview.alpha && subview.alpha < 1.) {
                [UIView animateWithDuration:.25 animations:^{
                    subview.alpha = 1.;
                }];
            }
        }
        return NO;
    }
}

@end
</code></pre>

- **如何使用**

<pre><code>
// 第一步：导入分类头文件
#import "UIViewController+BackBtnEventIntercept.h"

// 第二步：实现代理方法，return NO 则拦截了系统的返回按钮事件
- (BOOL)currentViewControllerShouldPop
{
    return NO;
}
</code></pre>

- **如何禁用系统👉右滑返回手势**

<pre><code>
- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    // 为当前控制器禁用👉右滑返回手势
    if ([self.navigationController respondsToSelector:@selector(interactivePopGestureRecognizer)]) {
        self.navigationController.interactivePopGestureRecognizer.enabled = NO;
    }
}

- (void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    // 为其他控制器开启👉右滑返回手势
    if ([self.navigationController respondsToSelector:@selector(interactivePopGestureRecognizer)]) {
        self.navigationController.interactivePopGestureRecognizer.enabled = YES;
    }
}
</code></pre>


### 联系我
扫码回复1获取面试资料（持续更新）
![](https://user-images.githubusercontent.com/11909313/123933944-6a4abe00-d9c5-11eb-83ca-379313a2af7c.png)
