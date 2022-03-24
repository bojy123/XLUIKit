//
//  XLHudManager.m
//  XLUIKit
//
//  Created by 薄宇 on 2022/3/24.
//

#import "XLHudManager.h"
#import "MBProgressHUD.h"

#define dispatch_main_async_safe(block)\
if ([NSThread isMainThread]) {\
block();\
} else {\
dispatch_async(dispatch_get_main_queue(), block);\
}

@interface XLHudManager () <MBProgressHUDDelegate>

@property (nonatomic, strong) MBProgressHUD *progressHUD;
@property (nonatomic, strong) MBProgressHUD *progressHUDOnce;

@end

@implementation XLHudManager

+ (instancetype)sharedInstance {
    static dispatch_once_t once;
    static id obj = nil;
    dispatch_once(&once, ^{obj = [self new];});
    return obj;
}

// 创建loading加载框
- (MBProgressHUD *)creatLoadingViewWithInView:(UIView *)view {

    MBProgressHUD *progressHUD = [[MBProgressHUD alloc] initWithView:view];
    
    // 使用外界自定义弹窗
    if (self.progressHUDBlock) {
        self.progressHUDBlock(progressHUD);
        return progressHUD;
    }
    
    progressHUD.removeFromSuperViewOnHide = NO;
    progressHUD.label.numberOfLines = 0;
    progressHUD.mode = MBProgressHUDModeCustomView;
    progressHUD.bezelView.style = MBProgressHUDBackgroundStyleSolidColor;
    progressHUD.bezelView.backgroundColor = [[UIColor blackColor] colorWithAlphaComponent:0.6];
    progressHUD.label.textColor = [UIColor whiteColor];
//    progressHUD.customView = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"icon_toast_loading"]];
//    [self addAnimationRotateWithView:progressHUD.customView];
    return progressHUD;
}

// 创建弹窗
- (MBProgressHUD *)creatOnceViewWithInView:(UIView *)view {
    
    MBProgressHUD *progressHUDOnce = [[MBProgressHUD alloc] initWithView:view];
    
    // 使用外界自定义弹窗
    if (self.progressHUDOnceBlock) {
        self.progressHUDOnceBlock(progressHUDOnce);
        return progressHUDOnce;
    }
    
    progressHUDOnce.removeFromSuperViewOnHide = NO;
    progressHUDOnce.mode = MBProgressHUDModeCustomView;
    progressHUDOnce.bezelView.style = MBProgressHUDBackgroundStyleSolidColor;
    progressHUDOnce.bezelView.backgroundColor = [[UIColor blackColor] colorWithAlphaComponent:0.6];
    progressHUDOnce.label.numberOfLines = 0;
    return progressHUDOnce;
}

// 初始化loading加载框
- (void)initLoadingViewInView:(UIView *)view withInfo:(NSString *)info canTouch:(BOOL)canTouch {
    dispatch_main_async_safe(^{
        if (!self.progressHUD) {
            self.progressHUD = [self creatLoadingViewWithInView:view];
            self.progressHUD.delegate = self;
            [view addSubview:self.progressHUD];
        }
        
        if (info) {
            self.progressHUD.label.text = info;
        } else {
            self.progressHUD.label.text = @"加载中...";
        }
        
        self.progressHUD.userInteractionEnabled = !canTouch;
        [self.progressHUD showAnimated:YES];
    });
}

// 初始化弹窗
- (void)initViewWithImage:(UIImage *)image withInfo:(NSString *)info dalayTime:(NSTimeInterval)delayTime view:(UIView *)view canTouch:(BOOL)canTouch {
    dispatch_main_async_safe(^{
        if (!self.progressHUDOnce) {
            self.progressHUDOnce = [self creatOnceViewWithInView:view];
            self.progressHUDOnce.delegate = self;
            self.progressHUDOnce.userInteractionEnabled = !canTouch;
            [view addSubview:self.progressHUDOnce];
        }
        
        self.progressHUDOnce.customView = [[UIImageView alloc]initWithImage:image];
        self.progressHUDOnce.label.text = info;
        self.progressHUDOnce.label.textColor = [UIColor whiteColor];
        
        [self.progressHUDOnce showAnimated:YES];
        [self.progressHUDOnce hideAnimated:YES afterDelay:delayTime];
    });
}

#pragma mark - MBProgressHUD Delegate

- (void)hudWasHidden:(MBProgressHUD *)hud {
    dispatch_main_async_safe(^{
        if (hud == self.progressHUD) {
            [self.progressHUD removeFromSuperview];
            self.progressHUD = nil;
            
        } else if (hud == self.progressHUDOnce) {
            [self.progressHUDOnce removeFromSuperview];
            self.progressHUDOnce = nil;
        }
    });
}

#pragma mark - 辅助方法
- (UIImage *)successImage {
    return [UIImage imageNamed:@"icon_toast_right"];
}

- (UIImage *)errorImage {
    return [UIImage imageNamed:@"icon_toast_error"];
}

- (CGFloat)getDelayTimeWithInfo:(NSString *)info {
    return [self displayDurationForString:info];
}

- (CGFloat)displayDurationForString:(NSString*)string {
    CGFloat minimum = MAX((CGFloat)string.length * 0.10 + 0.5, 1.0);
    return MIN(minimum, 5.0);
}

// 旋转动画
- (void)addAnimationRotateWithView:(UIView *)view {
    NSString *animationKey = @"kAnimationPSHudAlertViewServiceRotate";
    
    CABasicAnimation *animation =  [CABasicAnimation animationWithKeyPath:@"transform.rotation.z"];
    animation.toValue =  [NSNumber numberWithFloat: M_PI *2];
    animation.duration  = 1;
    animation.repeatCount = MAXFLOAT;
    animation.removedOnCompletion = NO;
    [view.layer addAnimation:animation forKey:animationKey];
}

#pragma mark --

// 加载框
+ (void)showLoadingView {
    [[XLHudManager sharedInstance] initLoadingViewInView:[UIApplication sharedApplication].keyWindow withInfo:nil canTouch:NO];
}

+ (void)showLoadingViewWithInfo:(NSString *)info {
    [[XLHudManager sharedInstance] initLoadingViewInView:[UIApplication sharedApplication].keyWindow withInfo:info canTouch:NO];
}

+ (void)showLoadingViewInView:(UIView *)view {
    [[XLHudManager sharedInstance] initLoadingViewInView:view withInfo:nil canTouch:NO];
}

+ (void)showLoadingViewInView:(UIView *)view withInfo:(NSString *)info {
    [[XLHudManager sharedInstance] initLoadingViewInView:view withInfo:info canTouch:NO];
}

+ (void)hideLoadingView {
    dispatch_main_async_safe(^{
        [[XLHudManager sharedInstance].progressHUD hideAnimated:NO];
        [[XLHudManager sharedInstance].progressHUD removeFromSuperview];
        [XLHudManager sharedInstance].progressHUD = nil;
    });
}

// 提示框
+ (void)showViewWithSuccessed:(NSString *)success {
    [self showViewWithImage:[XLHudManager sharedInstance].successImage withInfo:success];
}

+ (void)showViewWithFailed:(NSString *)error {
    [self showViewWithImage:[XLHudManager sharedInstance].errorImage withInfo:error];
}

+ (void)showViewWithInfo:(NSString *)info {
    [self showViewWithImage:nil withInfo:info];
}

+ (void)showViewWithImage:(UIImage *)image withInfo:(NSString *)info {
    CGFloat delayTime = [[XLHudManager sharedInstance] getDelayTimeWithInfo:info];
    [self showViewWithImage:image withInfo:info dalayTime:delayTime];
}

+ (void)showViewWithInfo:(NSString *)info dalayTime:(NSTimeInterval)delayTime {
    [self showViewWithImage:nil withInfo:info dalayTime:delayTime];
}

+ (void)showViewWithImage:(UIImage *)image withInfo:(NSString *)info dalayTime:(NSTimeInterval)delayTime {
    [[XLHudManager sharedInstance] initViewWithImage:image withInfo:info dalayTime:delayTime view:[UIApplication sharedApplication].keyWindow canTouch:YES];
}

@end
