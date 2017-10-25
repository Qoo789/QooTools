//
//  NSString+PCString.h
//  Pincai
//
//  Created by pincai on 2017/9/19.
//  Copyright © 2017年 Pincai. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface NSString (PCString)

// 根据字体获得字符size
- (CGSize) getStrSizeWithFont:(UIFont *)font size:(CGSize)aSize;

// 固定宽度, 获取字符高度
- (CGFloat) getStrHeightWithFont:(UIFont *)font fixedWidth:(CGFloat)width;

// 固定高度, 获取字符宽度
- (CGFloat) getStrWidthWithFont:(UIFont *)font fixedHeight:(CGFloat)height;

// 截取子字符串
- (NSArray *)componentsSeparatedFromString:(NSString *)fromString toString:(NSString *)toString;

// 对字符串进行 Base64 加密
- (NSString *)stringByBase64Encoding;

// 验证是否是正确位数的手机号码
- (BOOL)isMobileNumber;

// 检查密码 规则是6-16位数字字母组合
- (BOOL)checkPassWord;

// 检查验证码 规则是4位0-9数字
- (BOOL)checkAuthCode;

// 检查身份证号
- (BOOL)checkIdentityNumber;

// 保留小数点一定位数后不进位
- (NSString *)notRoundingAfterPoint:(int)position;

// 有千分符的数字方法
- (NSString *)thousandSeparatorNumber;

// 中间四位数字隐藏的手机号
- (NSString *)hideCenterPhoneNumber;

// 时间戳转时间(不带秒)
- (NSString *)timeStampToStringWithoutSecond;

// 时间戳转时间(带秒)
- (NSString *)timeStampToString;

@end
