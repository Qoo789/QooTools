//
//  PCIconTextView.m
//  Pincai
//
//  Created by pincai on 2017/9/25.
//  Copyright © 2017年 Pincai. All rights reserved.
//

#import "PCIconTextView.h"

@implementation PCIconTextView

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

- (id)initWithFrame:(CGRect)frame iconName:(NSString *)iconName placeholder:(NSString *)aPlaceholder keyboardType:(UIKeyboardType)type showBottomLine:(BOOL)show {
    self = [super initWithFrame:frame];
    if (self) {
        UIImage *iconImg = PCGetImagePath(iconName);
        UIImageView *iconView = [[UIImageView alloc] initWithFrame:CGRectMake(26 * kWidthScale, (self.pc_height - iconImg.size.height)/2, iconImg.size.width, iconImg.size.height)];
        iconView.image = iconImg;
        [self addSubview:iconView];
        
        UITextField *textView = [[UITextField alloc] initWithFrame:CGRectMake(iconView.pc_right + 26 * kWidthScale, 0, self.pc_width - iconView.pc_right - 26 * kWidthScale, self.pc_height)];
        textView.placeholder = aPlaceholder;
        textView.keyboardType = type;
        textView.font = PCFont(16.0f);
        [self addSubview:textView];
        self.textField = textView;
        if (show) {
            UIView *line = [[UIView alloc] initWithFrame:CGRectMake(0, self.pc_height - 0.5, self.pc_width, 0.5)];
            line.backgroundColor = HEXCOLOR(0xdfdfdf); //COLOR_WITH_HEX(0xdfdfdf);//PCGrayBackColor;
            [self addSubview:line];
        }
    }
    return self;
}

@end
