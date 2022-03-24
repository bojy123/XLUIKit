//
//  XLHudManager.h
//  XLUIKit
//
//  Created by 薄宇 on 2022/3/24.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@class MBProgressHUD;

@interface XLHudManager : NSObject


+ (instancetype)sharedInstance;

#pragma mark -
#pragma mark - 加载框设置

@property (nonatomic, copy) void (^progressHUDBlock)(MBProgressHUD *progressHUD); // 加载框
@property (nonatomic, copy) void (^progressHUDOnceBlock)(MBProgressHUD *progressHUDOnce); // 提示框

@property (nonatomic, strong, readonly) UIImage *successImage;
@property (nonatomic, strong, readonly) UIImage *errorImage;

+ (void)showLoadingView;
+ (void)showLoadingViewWithInfo:(NSString *)info;
+ (void)showLoadingViewInView:(UIView *)view;
+ (void)showLoadingViewInView:(UIView *)view withInfo:(NSString *)info;

+ (void)hideLoadingView;

+ (void)showViewWithSuccessed:(NSString *)success;
+ (void)showViewWithFailed:(NSString *)error;
+ (void)showViewWithInfo:(NSString *)info;
+ (void)showViewWithInfo:(NSString *)info dalayTime:(NSTimeInterval)delayTime;
+ (void)showViewWithImage:(UIImage *)image withInfo:(NSString *)info dalayTime:(NSTimeInterval)delayTime;

#pragma mark --

/** 创建loading加载框 */
- (MBProgressHUD *)creatLoadingViewWithInView:(UIView *)view;

/** 创建弹窗 */
- (MBProgressHUD *)creatOnceViewWithInView:(UIView *)view;

/** 获取提示框展示时间 */
- (CGFloat)getDelayTimeWithInfo:(NSString *)info;


@end
