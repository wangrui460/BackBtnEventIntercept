//
//  ViewController.m
//  BackBtnEventIntercept
//
//  Created by wangrui on 2017/4/22.
//  Copyright © 2017年 wangrui. All rights reserved.
//

#import "ViewController.h"

// 第一步：导入分类头文件
#import "UIViewController+BackBtnEventIntercept.h"

@interface ViewController () <UIGestureRecognizerDelegate>

@end

@implementation ViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
}

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

// 第二步：实现代理方法，return NO 则拦截了系统的返回按钮事件
- (BOOL)currentViewControllerShouldPop
{
    return NO;
}

@end
