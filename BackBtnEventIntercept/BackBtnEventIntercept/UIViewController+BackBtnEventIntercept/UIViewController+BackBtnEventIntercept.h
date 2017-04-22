//
//  UIViewController+BackBtnEventIntercept.h
//  BackBtnEventIntercept
//
//  Created by wangrui on 2017/4/22.
//  Copyright © 2017年 wangrui. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol ShouldPopDelegate <NSObject>
@optional
- (BOOL)currentViewControllerShouldPop;
@end

@interface UIViewController (BackBtnEventIntercept) <ShouldPopDelegate>

@end
