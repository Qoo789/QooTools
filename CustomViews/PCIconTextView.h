//
//  PCIconTextView.h
//  Pincai
//
//  Created by pincai on 2017/9/25.
//  Copyright © 2017年 Pincai. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface PCIconTextView : UIView

@property (nonatomic, strong)UITextField *textField;

- (id)initWithFrame:(CGRect)frame iconName:(NSString *)iconName placeholder:(NSString *)aPlaceholder keyboardType:(UIKeyboardType)type showBottomLine:(BOOL)show;

@end
