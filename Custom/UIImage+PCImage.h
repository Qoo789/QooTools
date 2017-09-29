//
//  UIImage+PCImage.h
//  Pincai
//
//  Created by pincai on 2017/9/19.
//  Copyright © 2017年 Pincai. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIImage (PCImage)

// 直接从 NSBundle 中读取图片, 不缓存
+ (UIImage*)imagePathed:(NSString*)imageName;

// 使用颜色替换当前图片, 透明部分不会被替换
+ (UIImage *)colorizeImage:(UIImage *)baseImage withColor:(UIColor *)theColor;

// UIColor 转 UIImage
+ (UIImage *)imageWithColor:(UIColor *) color andSize:(CGSize)size;

@end
