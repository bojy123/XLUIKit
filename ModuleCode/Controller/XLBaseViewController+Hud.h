//
//  XLBaseViewController+Hud.h
//  XLUIKit
//
//  Created by 薄宇 on 2022/3/24.
//

#import "XLBaseViewController.h"

@interface XLBaseViewController (Hud)

@property (nonatomic, assign) CGFloat loadingViewProgress; // 进度(0-1)

// 加载框
- (void)showLoadingView;
- (void)showLoadingViewInfo:(NSString *)info;
- (void)showLoadingViewInView:(UIView *)view;
- (void)showLoadingViewInView:(UIView *)view info:(NSString *)info;

// 进度条加载框
- (void)showLoadingProgressView;
- (void)showLoadingProgressViewInfo:(NSString *)info;
- (void)showLoadingProgressViewInView:(UIView *)view;
- (void)showLoadingProgressViewInView:(UIView *)view info:(NSString *)info;

// 去掉加载框
- (void)hideLoadingView;

// 提示框
- (void)showViewSuccessed:(NSString *)success;
- (void)showViewFailed:(NSString *)error;
- (void)showViewInfo:(NSString *)info;
- (void)showViewInfo:(NSString *)info dalayTime:(NSTimeInterval)delayTime;
- (void)showViewImage:(UIImage *)image info:(NSString *)info dalayTime:(NSTimeInterval)delayTime;

@end
