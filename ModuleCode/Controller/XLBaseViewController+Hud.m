//
//  XLBaseViewController+Hud.m
//  XLUIKit
//
//  Created by 薄宇 on 2022/3/24.
//

#import "XLBaseViewController+Hud.h"

#import <objc/runtime.h>
#import "XLHudManager.h"
#import "MBProgressHUD.h"

#define dispatch_main_async_safe(block)\
if ([NSThread isMainThread]) {\
block();\
} else {\
dispatch_async(dispatch_get_main_queue(), block);\
}

@interface XLBaseViewController () <MBProgressHUDDelegate>

@end

@implementation XLBaseViewController (Hud)

@end
