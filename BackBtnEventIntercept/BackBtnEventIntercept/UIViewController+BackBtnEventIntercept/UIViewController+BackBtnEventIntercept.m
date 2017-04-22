//
//  UIViewController+BackBtnEventIntercept.m
//  BackBtnEventIntercept
//
//  Created by wangrui on 2017/4/22.
//  Copyright © 2017年 wangrui. All rights reserved.
//

#import "UIViewController+BackBtnEventIntercept.h"

@implementation UIViewController (BackBtnEventIntercept)

@end


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
