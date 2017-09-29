//
//  UIFont+PCFont.m
//  Pincai
//
//  Created by pincai on 2017/9/19.
//  Copyright © 2017年 Pincai. All rights reserved.
//

#import "UIFont+PCFont.h"

@implementation UIFont (PCFont)

+ (UIFont *)lableTextFont {
    return [UIFont systemFontOfSize:14.0f];
}

+ (UIFont *)buttonTextFont {
    return [UIFont systemFontOfSize:14.0f];
}

+ (UIFont *)pixelToFontWith:(CGFloat)pixel {
    CGFloat fontfloat = pixel * kHeightScale; //((pixel * kHeightScale) / 96) * 72;
    return [UIFont systemFontOfSize:fontfloat];
}

@end
