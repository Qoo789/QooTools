//
//  PCDeleteBackwardTextField.m
//  Pincai
//
//  Created by pincai on 2017/10/26.
//  Copyright © 2017年 Pincai. All rights reserved.
//

#import "PCDeleteBackwardTextField.h"

@implementation PCDeleteBackwardTextField

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

- (void)deleteBackward {
    [super deleteBackward];
    
    if (self.customDelegate && [self.customDelegate respondsToSelector:@selector(textFieldDeleteBackward:)]) {
        [self.customDelegate textFieldDeleteBackward:self];
    }
}

@end
