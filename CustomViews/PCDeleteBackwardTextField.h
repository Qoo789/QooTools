//
//  PCDeleteBackwardTextField.h
//  Pincai
//
//  Created by pincai on 2017/10/26.
//  Copyright © 2017年 Pincai. All rights reserved.
//

#import <UIKit/UIKit.h>

@class PCDeleteBackwardTextField;

@protocol PCDeleteBackwardTextFieldDelegate <NSObject>

- (void)textFieldDeleteBackward:(PCDeleteBackwardTextField *)textField;

@end

@interface PCDeleteBackwardTextField : UITextField

@property (weak, nonatomic)id <PCDeleteBackwardTextFieldDelegate> customDelegate;

@end
