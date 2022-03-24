//
//  XLBaseViewController.h
//  XLUIKit
//
//  Created by 薄宇 on 2022/3/24.
//

#import <UIKit/UIKit.h>

@class MBProgressHUD;
@interface XLBaseViewController : UIViewController

@property (nonatomic, strong) MBProgressHUD *progressHUD;
@property (nonatomic, strong) MBProgressHUD *progressHUDOnce;

#pragma mark - nav

- (void)setNavTitle:(NSString *)title; // 设置nav标题
- (void)setNavCenterView:(UIView *)view; // 设置nav view控件

- (void)setNavLeftBtn:(UIButton *)button; // 设置导航左按钮
- (void)setNavRightBtn:(UIButton *)button; // 设置导航右按钮

- (void)setNavLeftBtnWithTarget:(id)target sel:(SEL)selector normalImage:(UIImage *)image;
- (void)setNavRightBtnWithTarget:(id)target sel:(SEL)selector normalImage:(UIImage *)image;

- (void)setNavLeftBtn:(id)content click:(void (^)(void))clickBlock; //@param content 支持类型：NSString,UIImage
- (void)setNavRightBtn:(id)content click:(void (^)(void))clickBlock;

#pragma mark - 子类重写

- (void)goBack:(id)sender; // 重写返回事件
- (UIImage *)getBackBtnImage; // 重写返回按钮图片样式
- (UIColor *)getNavBtnColor; // 导航按钮颜色
- (UIFont *)getNavFont; // 修改导航字体大小

@end

