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

- (CGSize)setImagePosition:(PCBtnImagePosition)postion andSpacing:(CGFloat)spacing {
    
    CGFloat imageWith = self.imageView.image.size.width;
    CGFloat imageHeight = self.imageView.image.size.height;
    
    CGFloat labelWidth = [self.titleLabel.text sizeWithAttributes:@{NSFontAttributeName: self.titleLabel.font}].width;
    CGFloat labelHeight = [self.titleLabel.text sizeWithAttributes:@{NSFontAttributeName: self.titleLabel.font}].height;
    
    // image中心移动的 x 距离
    CGFloat imageOffsetX = (imageWith + labelWidth) / 2 - imageWith / 2;
    // image中心移动的 y 距离
    CGFloat imageOffsetY = imageHeight / 2 + spacing / 2;
    // label中心移动的 x 距离
    CGFloat labelOffsetX = (imageWith + labelWidth / 2) - (imageWith + labelWidth) / 2;
    // label中心移动的 y 距离
    CGFloat labelOffsetY = labelHeight / 2 + spacing / 2;
    
    CGFloat realWidth = self.pc_width;
    CGFloat realHeight = self.pc_height;
    
    switch (postion) {
        case PCBtnImagePosition_Left:
            self.imageEdgeInsets = UIEdgeInsetsMake(0, -spacing/2, 0, spacing/2);
            self.titleEdgeInsets = UIEdgeInsetsMake(0, spacing/2, 0, -spacing/2);
            realWidth = self.imageView.pc_width + self.titleLabel.pc_width + spacing;
            break;
            
        case PCBtnImagePosition_Right:
            self.imageEdgeInsets = UIEdgeInsetsMake(0, labelWidth + spacing/2, 0, -(labelWidth + spacing/2));
            self.titleEdgeInsets = UIEdgeInsetsMake(0, -(imageHeight + spacing/2), 0, imageHeight + spacing/2);
            realWidth = self.imageView.pc_width + self.titleLabel.pc_width + spacing;
            break;
            
        case PCBtnImagePosition_Top:
            self.imageEdgeInsets = UIEdgeInsetsMake(-imageOffsetY, imageOffsetX, imageOffsetY, -imageOffsetX);
            self.titleEdgeInsets = UIEdgeInsetsMake(labelOffsetY, -labelOffsetX, -labelOffsetY, labelOffsetX);
            realHeight = self.imageView.pc_height + self.titleLabel.pc_height + spacing;
            break;
            
        case PCBtnImagePosition_Bottom:
            self.imageEdgeInsets = UIEdgeInsetsMake(imageOffsetY, imageOffsetX, -imageOffsetY, -imageOffsetX);
            self.titleEdgeInsets = UIEdgeInsetsMake(-labelOffsetY, -labelOffsetX, labelOffsetY, labelOffsetX);
            realHeight = self.imageView.pc_height + self.titleLabel.pc_height + spacing;
            break;
            
        default:
            break;
    }
    
    return CGSizeMake(realWidth, realHeight);
}

@end
