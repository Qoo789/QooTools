//
//  PCCurrentVCTool.h
//  Pincai
//
//  Created by pincai on 2017/9/29.
//  Copyright © 2017年 Pincai. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef enum {
    FingerprintVerifyTypeSetting = 1,
    FingerprintVerifyTypeVarify
}FingerprintVerifyType;

@interface PCCurrentVCTool : NSObject

// 当前控制器
+ (UIViewController *_Nullable)visibleController;

// 当前控制器主页面
+ (UIView *_Nullable)visibleControllerView;

// 额外的一个不知道该放哪儿的方法=。=  调用系统电话
+ (void)callPhone:(NSString *_Nullable)phoneNum;

// 指纹验证方法= = 也不知道该放到哪
+ (void)fingerprintVerifyWithType:(FingerprintVerifyType)type andReply:(void(^_Nullable)(BOOL success, NSError * __nullable error))reply;

@end
