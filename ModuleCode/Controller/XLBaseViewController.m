//
//  XLBaseViewController.m
//  XLUIKit
//
//  Created by 薄宇 on 2022/3/24.
//

#import "XLBaseViewController.h"

@interface XLBaseViewController ()

@property (nonatomic, copy)  void(^leftBtnBlock) (void);
@property (nonatomic, copy)  void(^rightBtnBlock) (void);

@end

@implementation XLBaseViewController

-(void)dealloc{
    NSLog(@"-[%@ dealoc]",[self class]);
}

#pragma mark -
#pragma mark - loadView

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self showBackBtn];
}

#pragma mark -
#pragma mark - nav

- (void)setNavTitle:(NSString *)title {
    self.navigationItem.title = title;
}

- (void)setNavCenterView:(UIView *)view {
    self.navigationItem.titleView = view;
}

- (void)setNavLeftBtn:(UIButton *)button {
    if (!button) {
        self.navigationItem.leftBarButtonItem = nil;
    } else {
        UIBarButtonItem *item = [[UIBarButtonItem alloc] initWithCustomView:button];
        self.navigationItem.leftBarButtonItem = item;
    }
}

- (void)setNavRightBtn:(UIButton *)button {
    if (!button) {
        self.navigationItem.rightBarButtonItem = nil;
    } else {
        UIBarButtonItem *item = [[UIBarButtonItem alloc] initWithCustomView:button];
        self.navigationItem.rightBarButtonItem = item;
    }
}

- (void)setNavLeftBtnWithTarget:(id)target sel:(SEL)selector normalImage:(UIImage *)image {
    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    button.frame = CGRectMake(0, 0, 44, 44);
    button.imageEdgeInsets = UIEdgeInsetsMake(0, -10, 0, 10);
    [button setImage:image forState:UIControlStateNormal];
    [button addTarget:target action:selector forControlEvents:UIControlEventTouchUpInside];
    [self setNavLeftBtn:button];
}

- (void)setNavRightBtnWithTarget:(id)target sel:(SEL)selector normalImage:(UIImage *)image {
    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    button.frame = CGRectMake(0, 0, 44, 44);
    [button setImage:image forState:UIControlStateNormal];
    [button addTarget:target action:selector forControlEvents:UIControlEventTouchUpInside];
    button.imageEdgeInsets = UIEdgeInsetsMake(0, 10, 0, -10);
    [self setNavRightBtn:button];
}

- (void)setNavLeftBtn:(id)content click:(void (^)(void))clickBlock {
    [self setNavLeftOrRightBtnType:0 content:content click:clickBlock];
}

- (void)setNavRightBtn:(id)content click:(void (^)(void))clickBlock {
    [self setNavLeftOrRightBtnType:1 content:content click:clickBlock];
}

- (void)setNavLeftOrRightBtnType:(NSInteger)type content:(id)content click:(void (^)(void))clickBlock {
    UIColor *titleColor = [self getNavBtnColor];
    UIFont *btnFont = [self getNavFont];
    
    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    button.frame = CGRectMake(0, 0, 44, 44);
    
    [button setTitleColor:titleColor forState:UIControlStateNormal];
    button.tintColor = titleColor;
    button.titleLabel.font = btnFont;
    
    // left
    if (type == 0) {
        self.leftBtnBlock = clickBlock;
        
        button.imageEdgeInsets = UIEdgeInsetsMake(0, -10, 0, 10);
        [self.navigationItem setLeftBarButtonItem:[[UIBarButtonItem alloc] initWithCustomView:button] animated:NO];
        [button addTarget:self action:@selector(leftBtnClick:) forControlEvents:UIControlEventTouchUpInside];

    }
    else {
    // right
        self.rightBtnBlock = clickBlock;
        
        button.imageEdgeInsets = UIEdgeInsetsMake(0, 10, 0, -10);
        [self.navigationItem setRightBarButtonItem:[[UIBarButtonItem alloc] initWithCustomView:button] animated:NO];
        [button addTarget:self action:@selector(rightBtnClick:) forControlEvents:UIControlEventTouchUpInside];
    }

    
    if ([content isKindOfClass:[UIImage class]]) {
        [button setImage: [(UIImage *)content imageWithRenderingMode:UIImageRenderingModeAlwaysTemplate] forState:UIControlStateNormal];
    } else if ([content isKindOfClass:[NSString class]]){
        [button setTitle:content forState:UIControlStateNormal];
        
        [button sizeToFit];
    } else{
        NSLog(@"%s 不支持%@类型",__func__,[content class]);
    }
}

- (void)leftBtnClick:(UIButton *)button {
    if (self.leftBtnBlock) self.leftBtnBlock();
}

- (void)rightBtnClick:(UIButton *)button {
    if (self.rightBtnBlock) self.rightBtnBlock();
}

- (void)showBackBtn {
    if ((self.presentedViewController != nil || self.presentingViewController != nil)
        && [self.navigationController.viewControllers count] == 1) {
        [self setNavLeftBtnWithTarget:self sel:@selector(goBack:) normalImage:[self getBackBtnImage]];
    } else if ([self.navigationController.viewControllers count] > 1) {
        [self setNavLeftBtnWithTarget:self sel:@selector(goBack:) normalImage:[self getBackBtnImage]];
    }
}

- (void)goBack:(id)sender {
    if (self.navigationController) {
        [self.navigationController popViewControllerAnimated:YES];
        
        if (self == [self.navigationController.viewControllers objectAtIndex:0]) {
            [self.navigationController dismissViewControllerAnimated:YES completion:nil];
        }
    }
}

- (UIImage *)getBackBtnImage {
    return nil;
}

- (UIColor *)getNavBtnColor {
    return [UIColor whiteColor];
}

- (UIFont *)getNavFont {
    return [UIFont systemFontOfSize:16];
}


@end
