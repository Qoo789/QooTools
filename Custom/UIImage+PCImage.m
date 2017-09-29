//
//  UIImage+PCImage.m
//  Pincai
//
//  Created by pincai on 2017/9/19.
//  Copyright © 2017年 Pincai. All rights reserved.
//

#import "UIImage+PCImage.h"

@implementation UIImage (PCImage)

+ (UIImage*)imagePathed:(NSString*)imageName {
    // 获取文件名
    NSString *realName = [imageName stringByDeletingPathExtension];
    // 获取后缀名
    NSString *extention = [imageName pathExtension];
    // 获取文件路径
    NSString *imagePath = nil;
    UIImage *returnImage = nil;
    
    /* 当有命名规则时使用
     //判断是否为iphone
     if (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPhone)
     {
     //[UIScreen mainScreen].scale普通屏为1.0，高清为2.0
     //iphone5
     if (([UIScreen mainScreen].bounds.size.height * [UIScreen mainScreen].scale) >=1136)
     {
     realName = [realName stringByAppendingFormat:@"-568h@2x"];
     }
     }
     */
    
    imagePath = [[NSBundle mainBundle] pathForResource:[realName stringByAppendingString:@"@2x"] ofType:extention];
    returnImage = [UIImage imageWithContentsOfFile:imagePath];
    // 取不到的时候, 尝试以缓存形式取
    if (!returnImage) {
        returnImage = [UIImage imageNamed:realName];
//        NSLog(@"by imageNamed");
    }
    return returnImage;
}


+ (UIImage *)colorizeImage:(UIImage *)baseImage withColor:(UIColor *)theColor {
    
    UIGraphicsBeginImageContext(baseImage.size);
    
    CGContextRef ctx = UIGraphicsGetCurrentContext();
    CGRect area = CGRectMake(0, 0, baseImage.size.width, baseImage.size.height);
    
    CGContextScaleCTM(ctx, 1, -1);
    CGContextTranslateCTM(ctx, 0, -area.size.height);
    
    CGContextSaveGState(ctx);
    CGContextClipToMask(ctx, area, baseImage.CGImage);
    
    [theColor set];
    CGContextFillRect(ctx, area);
    
    CGContextRestoreGState(ctx);
    
    CGContextSetBlendMode(ctx, kCGBlendModeMultiply);
    
    CGContextDrawImage(ctx, area, baseImage.CGImage);
    
    UIImage *newImage = UIGraphicsGetImageFromCurrentImageContext();
    
    UIGraphicsEndImageContext();
    
    return newImage;
}


+ (UIImage *)imageWithColor:(UIColor *)color andSize:(CGSize)size {
    
    CGRect rect = CGRectMake(0, 0, size.width, size.height);
    UIGraphicsBeginImageContext(rect.size);
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextSetFillColorWithColor(context, [color CGColor]);
    CGContextFillRect(context, rect);
    
    UIImage *theImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return theImage;
}

@end
