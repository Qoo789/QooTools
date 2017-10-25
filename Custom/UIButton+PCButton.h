//
//  UIButton+PCButton.h
//  Pincai
//
//  Created by pincai on 2017/9/19.
//  Copyright © 2017年 Pincai. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef NS_ENUM(NSInteger, PCBtnImagePosition) {
    PCBtnImagePosition_Left = 0,              //图片在左，文字在右
    PCBtnImagePosition_Right = 1,             //图片在右，文字在左
    PCBtnImagePosition_Top = 2,               //图片在上，文字在下
    PCBtnImagePosition_Bottom = 3,            //图片在下，文字在上
};

@interface UIButton (PCButton)

+ (UIButton *)btnWithFrame:(CGRect)frame cornerRadius:(CGFloat)aCornerRadius borderColor:(UIColor*)color;

// 需要 button 先设置好 frame 和 font 之后再调用该方法, 否则方法无效. 返回值是加入间距后 button 的实际尺寸
- (CGSize)setImagePosition:(PCBtnImagePosition)postion andSpacing:(CGFloat)spacing;

@end
