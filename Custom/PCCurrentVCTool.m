//
//  PCCurrentVCTool.m
//  Pincai
//
//  Created by pincai on 2017/9/29.
//  Copyright © 2017年 Pincai. All rights reserved.
//

#import "PCCurrentVCTool.h"

@implementation PCCurrentVCTool

+ (UIViewController *)visibleController {
    
    UIViewController *vc = [UIApplication sharedApplication].keyWindow.rootViewController;
    NSAssert(vc != nil, @"没有获取到程序的根控制器");
    return [self getVisibleController:vc];
}

+ (UIViewController *)getVisibleController:(UIViewController *)vc {
    if ([vc isKindOfClass:[UITabBarController class]]) {
        vc = ((UITabBarController *)vc).selectedViewController;
        NSAssert(vc != nil, @"根控制器是tabbarController, 但没有获取到tabbar的子控制器");
        return [self getVisibleController:vc];
    }
    
    if ([vc isKindOfClass:[UINavigationController class]]) {
        vc = ((UINavigationController *)vc).visibleViewController;
        NSAssert(vc != nil, @"没有获取到navigationController的子控制器");
        return [self getVisibleController:vc];
    }
    
    NSAssert(vc != nil, @"没有获取到当前控制器");
    return vc;
}

+ (UIView *)visibleControllerView {
    return [self visibleController].view;
}

+ (void)callPhone:(NSString *)phoneNum {
    NSString *str = [[NSString alloc] initWithFormat:@"tel:%@", phoneNum];
    UIWebView *callWebview = [[UIWebView alloc] init];
    [callWebview loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:str]]];
    [[self visibleControllerView] addSubview:callWebview];
}

+ (void)fingerprintVerifyWithType:(FingerprintVerifyType)type andReply:(void(^_Nullable)(BOOL success, NSError * __nullable error))reply {
    BOOL isVarify = type == FingerprintVerifyTypeVarify;
    BOOL fingerprintVerifyInUserDefaults = [[NSUserDefaults standardUserDefaults] boolForKey:kFingerprintVerifyKey];
    
    // 判断是否开启指纹
    if (isVarify ? fingerprintVerifyInUserDefaults : !fingerprintVerifyInUserDefaults) {
        
//        // 不推荐这样的判断系统版本的方式, 还是用原生自带的 API
//        if (isLateriOS8) {
        
        if (@available(iOS 8.0, *)) { // 系统版本高于8.0, iOS 8之后才可以开启
            
            LAContext *context = [[LAContext alloc] init];
            // localizedFallbackTitle：验证TouchID时弹出Alert的输入密码按钮的标题
            // localizedCancelTitle可以设置验证TouchID时弹出Alert的取消按钮的标题(iOS10才有)
            context.maxBiometryFailures = @(3);
            context.localizedFallbackTitle = @"";
            context.localizedCancelTitle = @"取消";
            
            // 调用系统 API 检查 Touch ID 是否可用
            NSError *requestError;
            NSInteger policy;
            if (isBeforeiOS9) { // 8之后, 9之前
                policy = LAPolicyDeviceOwnerAuthenticationWithBiometrics;
            } else {
                policy = LAPolicyDeviceOwnerAuthentication;
            }
            
            if ([context canEvaluatePolicy:policy error:&requestError]) { // 系统方法验证, 设备支持
                
                NSLog(@"Touch ID可以使用, 开始验证");
                // policy 这里 传 LAPolicyDeviceOwnerAuthentication 代表多次验证失败之后会自动跳转输入系统解锁密码的页面, 通过输入系统密码来解锁
                // 传 LAPolicyDeviceOwnerAuthenticationWithBiometrics 代表多次验证失败之后的事件由我们自己来做, 所以一般框架就会第一遍先传 LAPolicyDeviceOwnerAuthenticationWithBiometrics, 多次验证失败之后传 LAPolicyDeviceOwnerAuthentication 再调用一次, 这样就是一开始三次验证失败之后弹框提醒, 再次验证失败就需要输入系统密码.
                // 所以 policy 这里直接传 LAPolicyDeviceOwnerAuthenticationWithBiometrics
                [context evaluatePolicy:LAPolicyDeviceOwnerAuthenticationWithBiometrics localizedReason:@"请验证已有指纹" reply:^(BOOL success, NSError * _Nullable error) {
                    if (success) {
                        dispatch_async(dispatch_get_main_queue(), ^{
                            reply(success, nil);
                        });
                    } else {
                        dispatch_async(dispatch_get_main_queue(), ^{
                            switch (error.code) {
//                                case LAErrorUserCancel:
//                                    // 用户点击取消按钮
//                                    NSLog(@"用户取消指纹验证");
//                                    break;
//                                case LAErrorUserFallback:
//                                    // 用户点击输入密码按钮, 这里不需要
//                                    NSLog(@"用户点击输入密码按钮");
//                                    break;
                                case LAErrorPasscodeNotSet:
                                    // 没有在设备上设置密码
                                    NSLog(@"没有在设备上设置 Touch ID");
                                    SHOWERRORHUD(@"设备上没有设置 Touch ID!");
                                    break;
                                case LAErrorTouchIDNotAvailable:
                                    // 设备不支持TouchID
                                    NSLog(@"设备不支持 Touch ID");
                                    SHOWERRORHUD(@"当前设备不支持 Touch ID");
                                    break;
                                case LAErrorTouchIDNotEnrolled:
                                    // 设备没有注册TouchID
                                    NSLog(@"当前设备没有注册 Touch ID");
                                    SHOWERRORHUD(@"当前设备没有注册 Touch ID");
                                    break;
                                case LAErrorTouchIDLockout:
                                    // 多次指纹验证不成功, Touch ID 被锁定
                                    NSLog(@"Touch ID 被锁定");
                                    // 这里我们并不需要调用系统密码输入, 所以这里不再再次调用
//                                    [context evaluatePolicy:LAPolicyDeviceOwnerAuthentication localizedReason:@"请验证已有指纹" reply:^(BOOL success, NSError * _Nullable error) {}];
                                    break;
                                default:
                                    break;
                            }
                            reply(success, error);
                        });
                    }
                }];
            } else { // 系统方法验证, 设备是不支持 TouchID 的
                NSLog(@"模拟器, 不能使用 Touch ID");
            }
        } else { // 系统版本低于8.0
            // 弹框提示由于系统版本原因不能开启
            NSLog(@"系统版本低于8.0, 不能使用 Touch ID");
        }
    } else {
        isVarify ? NSLog(@"用户没有开启指纹验证") : NSLog(@"不可能发生的情况= =");
    }
}

@end
