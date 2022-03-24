//
//  XLNavViewController.m
//  XLUIKit
//
//  Created by 薄宇 on 2022/3/24.
//

#import "XLNavViewController.h"

@interface XLNavViewController ()

@end

@implementation XLNavViewController

- (void)viewDidLoad {
    [super viewDidLoad];
}

- (void)pushViewController:(UIViewController *)viewController animated:(BOOL)animated
{
    if (self.tabBarController == nil) {
        [super pushViewController:viewController animated:animated];
        return;
    }
    UIViewController *contrller = [self.viewControllers lastObject];
    contrller.hidesBottomBarWhenPushed = YES;
    [super pushViewController:viewController animated:animated];
    contrller.hidesBottomBarWhenPushed = [self.viewControllers count] > 2;
}

@end
