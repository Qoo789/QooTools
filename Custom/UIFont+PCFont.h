//
//  UIFont+PCFont.h
//  Pincai
//
//  Created by pincai on 2017/9/19.
//  Copyright © 2017年 Pincai. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIFont (PCFont)

+ (UIFont *)lableTextFont; // 常规 label 字号

+ (UIFont *)buttonTextFont; // 常规 button 字号

+ (UIFont *)pixelToFontWith:(CGFloat)pixel; // 像素点转font

@end
