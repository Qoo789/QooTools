//
//  PCCustomTextField.m
//  Pincai
//
//  Created by pincai on 2017/10/17.
//  Copyright © 2017年 Pincai. All rights reserved.
//

#import "PCCustomTextField.h"

@implementation PCCustomTextField

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

- (CGRect)placeholderRectForBounds:(CGRect)bounds {
    return CGRectMake(20 * kWidthScale, 0, bounds.size.width, bounds.size.height);
}

- (CGRect)textRectForBounds:(CGRect)bounds {
    return CGRectMake(20 * kWidthScale, 0, bounds.size.width, bounds.size.height);
}

- (CGRect)editingRectForBounds:(CGRect)bounds {
    return CGRectMake(20 * kWidthScale, 0, bounds.size.width, bounds.size.height);
}

@end
