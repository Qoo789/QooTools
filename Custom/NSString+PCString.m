//
//  NSString+PCString.m
//  Pincai
//
//  Created by pincai on 2017/9/19.
//  Copyright © 2017年 Pincai. All rights reserved.
//

#import "NSString+PCString.h"

@implementation NSString (PCString)

- (CGSize) getStrSizeWithFont:(UIFont *)font size:(CGSize)aSize {
    CGRect rect = [self boundingRectWithSize:aSize options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName: font} context:nil];
    return rect.size;
}

- (CGFloat) getStrHeightWithFont:(UIFont *)font fixedWidth:(CGFloat)width {
    CGRect rect = [self boundingRectWithSize:CGSizeMake(width, MAXFLOAT) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName: font} context:nil];
    return rect.size.height;
}

- (CGFloat) getStrWidthWithFont:(UIFont *)font fixedHeight:(CGFloat)height {
    CGRect rect = [self boundingRectWithSize:CGSizeMake(MAXFLOAT, height) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName: font} context:nil];
    return rect.size.width;
}

- (NSArray *)componentsSeparatedFromString:(NSString *)fromString toString:(NSString *)toString {
    
    if (IsEmptyStr(fromString) || IsEmptyStr(toString)) {
        return nil;
    }
    NSMutableArray *subStringsArray = [[NSMutableArray alloc] init];
    NSString *tempString = self;
    NSRange range = [tempString rangeOfString:fromString];
    while (range.location != NSNotFound) {
        tempString = [tempString substringFromIndex:(range.location + range.length)];
        range = [tempString rangeOfString:toString];
        if (range.location != NSNotFound) {
            [subStringsArray addObject:[tempString substringToIndex:range.location]];
            range = [tempString rangeOfString:fromString];
        } else {
            break;
        }
    }
    return subStringsArray;
}

- (NSString *)stringByBase64Encoding {
    NSData *encodedData = [self dataUsingEncoding:NSUTF8StringEncoding];
    return [encodedData base64EncodedStringWithOptions:0];
}

- (BOOL)isMobileNumber {
    
    if (self.length != 11) {
        return NO;
    }
    
    /**
     * 手机号码:
     * 13[0-9], 14[5,7], 15[0, 1, 2, 3, 5, 6, 7, 8, 9], 17[0, 1, 6, 7, 8], 18[0-9]
     * 移动号段: 134,135,136,137,138,139,147,150,151,152,157,158,159,170,178,182,183,184,187,188
     * 联通号段: 130,131,132,145,155,156,170,171,175,176,185,186
     * 电信号段: 133,149,153,170,173,177,180,181,189
     */
    NSString *MOBILE = @"^1(3[0-9]|4[57]|5[0-35-9]|7[0135678]|8[0-9])\\d{8}$";
    /**
     * 中国移动：China Mobile
     * 134,135,136,137,138,139,147,150,151,152,157,158,159,170,178,182,183,184,187,188
     */
    NSString *CM = @"^1(3[4-9]|4[7]|5[0-27-9]|7[08]|8[2-478])\\d{8}$";
    /**
     * 中国联通：China Unicom
     * 130,131,132,145,155,156,170,171,175,176,185,186
     */
    NSString *CU = @"^1(3[0-2]|4[5]|5[56]|7[0156]|8[56])\\d{8}$";
    /**
     * 中国电信：China Telecom
     * 133,149,153,170,173,177,180,181,189
     */
    NSString *CT = @"^1(3[3]|4[9]|53|7[037]|8[019])\\d{8}$";
    
    
    NSPredicate *regextestmobile = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", MOBILE];
    NSPredicate *regextestcm = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", CM];
    NSPredicate *regextestcu = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", CU];
    NSPredicate *regextestct = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", CT];
    
    if (([regextestmobile evaluateWithObject:self] == YES)
        || ([regextestcm evaluateWithObject:self] == YES)
        || ([regextestct evaluateWithObject:self] == YES)
        || ([regextestcu evaluateWithObject:self] == YES))
    {
        return YES;
    } else {
        return NO;
    }
}

- (BOOL)checkPassWord {
    // 如果规则是6-16位数字和字母组成
    NSString *regex = @"^(?![0-9]+$)(?![a-zA-Z]+$)[0-9A-Za-z]{6,16}$";
    NSPredicate *pred = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", regex];
    return [pred evaluateWithObject: self];
}

- (BOOL)checkAuthCode {
    NSString *regex = @"^[0-9]{4}$";
    NSPredicate *pred = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", regex];
    return [pred evaluateWithObject:self];
}

- (BOOL)checkIdentityNumber {
    NSString *regex = @"^(d{14}|d{17})(d|[xX])$";
    NSPredicate *pred = [NSPredicate predicateWithFormat:@"SELF MATCHES %@",regex];
    return [pred evaluateWithObject:self];
}

- (NSString *)notRoundingAfterPoint:(int)position {
    
    double d = [self doubleValue];
    
    NSDecimalNumberHandler* roundingBehavior = [NSDecimalNumberHandler decimalNumberHandlerWithRoundingMode:NSRoundDown scale:position  raiseOnExactness:NO raiseOnOverflow:NO raiseOnUnderflow:NO raiseOnDivideByZero:NO];
    
    NSDecimalNumber *ouncesDecimal;
    NSDecimalNumber *roundedOunces;
    
    ouncesDecimal = [[NSDecimalNumber alloc] initWithDouble:d];
    roundedOunces = [ouncesDecimal decimalNumberByRoundingAccordingToBehavior:roundingBehavior];
    
    // 整数的不带小数点
    //    return [NSString stringWithFormat:@"%@",roundedOunces];
    
    NSString *string = [NSString stringWithFormat:@"%@", roundedOunces];
    if ([string rangeOfString:@"."].length == 0) {
        NSString *extra = @".";
        for(int i = 0; i < position; i++) {
            [extra stringByAppendingString:@"0"];
        }
        string = [string stringByAppendingString:extra];
    } else {
        // 先只考虑保留两位的情况
        NSRange range = [string rangeOfString:@"."];
        if (string.length - range.location - 1 == 1) {
            // 保留了一位
            string = [string stringByAppendingString:@"0"];
        }
    }
    return string; // 整数.00格式
}

- (NSString *)thousandSeparatorNumber {
    
    int amount = [self intValue];
    NSNumberFormatter *formatter = [[NSNumberFormatter alloc] init];
    formatter.numberStyle = NSNumberFormatterDecimalStyle;
    
    return [formatter stringFromNumber:[NSNumber numberWithInt:amount]];
}

- (NSString *)hideCenterPhoneNumber {
    if ([self isMobileNumber]) {
        NSString *fStr = [self substringToIndex:3];
        NSString *bStr = [self substringFromIndex:7];
        return [NSString stringWithFormat:@"%@****%@", fStr, bStr];
    } else {
        return self;
    }
}

- (NSString *)timeStampToStringWithoutSecond {
    
    double timeSta = [self doubleValue];
    NSDateFormatter *timeFormatter = [[NSDateFormatter alloc] init];
    timeFormatter.dateFormat = @"yyyy-MM-dd HH:mm";
    
    NSDate *date = [[NSDate alloc] initWithTimeIntervalSince1970:timeSta];
    return [timeFormatter stringFromDate:date];
}

- (NSString *)timeStampToString {
    
    double timeSta = [self doubleValue];
    NSDateFormatter *timeFormatter = [[NSDateFormatter alloc] init];
    timeFormatter.dateFormat = @"yyyy-MM-dd HH:mm:ss";
    
    NSDate *date = [[NSDate alloc] initWithTimeIntervalSince1970:timeSta];
    return  [timeFormatter stringFromDate:date];
}

@end
