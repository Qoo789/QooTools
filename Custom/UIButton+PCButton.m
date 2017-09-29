//
//  UIButton+PCButton.m
//  Pincai
//
//  Created by pincai on 2017/9/19.
//  Copyright © 2017年 Pincai. All rights reserved.
//

#import "UIButton+PCButton.h"

@implementation UIButton (PCButton)

+ (UIButton *)btnWithFrame:(CGRect)frame cornerRadius:(CGFloat)aCornerRadius borderColor:(UIColor*)color {
    UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
    btn.frame = frame;
    btn.layer.cornerRadius = aCornerRadius;
    btn.layer.masksToBounds = YES;
    btn.layer.borderColor = color.CGColor;
    btn.layer.borderWidth = 1;
    btn.titleLabel.font = [UIFont systemFontOfSize:14.0f];
    return btn;
}

@end
