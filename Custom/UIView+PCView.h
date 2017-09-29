//
//  UIView+PCView.h
//  Pincai
//
//  Created by pincai on 2017/9/19.
//  Copyright © 2017年 Pincai. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MBProgressHUD.h"

/*
 * 这个 Category 里丢一些乱七八糟的扩展方法(包括 MB 之类的)
 * 相比较 UIView+PVPosition 里都是一些坐标扩展相关的
 */

@interface UIView (PCView)

// 截图方法
- (UIImage *)captureView:(UIView *)view;

@end
