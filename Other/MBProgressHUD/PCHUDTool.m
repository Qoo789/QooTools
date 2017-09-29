//
//  PCHUDTool.m
//  Pincai
//
//  Created by pincai on 2017/9/20.
//  Copyright © 2017年 Pincai. All rights reserved.
//

#import "PCHUDTool.h"

@interface PCHUDTool()<MBProgressHUDDelegate>

@property (nonatomic, strong)MBProgressHUD *hud;

@end

@implementation PCHUDTool

static PCHUDTool *shareManager = nil;

+ (PCHUDTool *) shareInstance {
    
    @synchronized(self){
        if (shareManager == nil) {
            shareManager = [[self alloc] init] ;
        }
    }
    
    return shareManager;
}

- (instancetype)init {
    self = [super init];
    if (self) {
        self.hud = [[MBProgressHUD alloc] initWithView:[UIApplication sharedApplication].keyWindow];
        self.hud.delegate = self;
        self.hud.animationType = MBProgressHUDAnimationZoom;
        self.hud.removeFromSuperViewOnHide = YES;
        [[UIApplication sharedApplication].keyWindow addSubview:self.hud];
    }
    return self;
}

- (void)hide:(BOOL)hide afterDelay:(NSTimeInterval)delay {
    [self.hud hideAnimated:hide afterDelay:delay];
    shareManager = nil;
}

- (void)hide {
    [self.hud hideAnimated:YES];
    shareManager = nil;
}

- (void)show:(BOOL)show {
    self.hud.label.font = [UIFont systemFontOfSize:14.0f];
    if (!show) {
        self.hud.hidden = YES;
    }
    if (self.text && self.text.length != 0) {
        self.hud.label.text = self.text;
    }
    
    if (self.showTextOnly && self.text != nil && self.text.length != 0) {
        self.hud.mode = MBProgressHUDModeText;
    }
    
    if (self.customView) {
        self.hud.mode = MBProgressHUDModeCustomView;
        self.hud.customView = self.customView;
    }
    
    [self.hud showAnimated:show];
}

#pragma mark - HUD代理方法
- (void)hudWasHidden:(MBProgressHUD *)hud {
    [self.hud removeFromSuperview];
    self.hud = nil;
}

#pragma mark - 类方法
+ (void)showTextOnly:(NSString *)text duration:(NSTimeInterval)sec inView:(UIView *)view {
    PCHUDTool *hud = [PCHUDTool shareInstance];
    hud.text = text;
    hud.showTextOnly = YES;
    [hud show:YES];
    [hud hide:YES afterDelay:sec];
}

+ (void)showText:(NSString *)text duration:(NSTimeInterval)sec inView:(UIView *)view {
    PCHUDTool *hud = [PCHUDTool shareInstance];
    hud.text = text;
    [hud show:YES];
    [hud hide:YES afterDelay:sec];
}


+ (void)showCustomViewWithText:(NSString *)text type:(HUDCustomViewType)type inView:(UIView *)view {
    
    NSString *imgName = @"";
    if (type == Type_Success) {
        imgName = @"success";
    } else if (type == Type_Error){
        imgName = @"error";
    } else if (type == Type_Info){
        imgName = @"info";
    }
    
    UIImage *image = [UIImage imageNamed:imgName];
    PCHUDTool *hud = [PCHUDTool shareInstance];
    UIImageView *customView = [[UIImageView alloc] initWithImage:[image imageWithRenderingMode:UIImageRenderingModeAlwaysTemplate]];
    customView.tintColor = [UIColor whiteColor];
    hud.text = text;
    hud.customView = customView;
    [hud show:YES];
    [hud hide:YES afterDelay:1];
}

+ (void)show {
    PCHUDTool *hud = [PCHUDTool shareInstance];
    [hud show:YES];
}

+ (void)showHUDWithText:(NSString *)text {
    PCHUDTool *hud = [PCHUDTool shareInstance];
    hud.text = text;
    [hud show:YES];
}

+ (void)hiden {
    PCHUDTool *hud = [PCHUDTool shareInstance];
    [hud show:NO];
    [hud hide];
}

@end
