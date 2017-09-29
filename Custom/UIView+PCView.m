//
//  UIView+PCView.m
//  Pincai
//
//  Created by pincai on 2017/9/19.
//  Copyright © 2017年 Pincai. All rights reserved.
//

#import "UIView+PCView.h"

@implementation UIView (PCView)

- (UIImage *)captureView:(UIView *)view {
    
    UIImage *image = nil;
    UIScrollView *scrollView = nil;
    
    if ([view isKindOfClass:[UIScrollView class]]) {
        scrollView = (UIScrollView *)view;
        CGPoint savedContentOffset = scrollView.contentOffset;
        CGRect savedFrame = scrollView.frame;
        scrollView.contentOffset = CGPointZero;
        scrollView.frame = CGRectMake(0, 0, scrollView.contentSize.width, scrollView.contentSize.height);
        UIGraphicsBeginImageContextWithOptions(scrollView.contentSize, YES, [UIScreen mainScreen].scale);
        CGContextRef contexRef = UIGraphicsGetCurrentContext();
        [scrollView.layer renderInContext: contexRef];
        // 清除缓存,解决内存警告
//        scrollView.layer.contents = nil;
        image = UIGraphicsGetImageFromCurrentImageContext();
        UIGraphicsEndImageContext();
        scrollView.contentOffset = savedContentOffset;
        scrollView.frame = savedFrame;
    } else {
        UIGraphicsBeginImageContext(view.bounds.size);
        CGContextRef contexRef = UIGraphicsGetCurrentContext();
        [view.layer renderInContext: contexRef];
//        view.layer.contents = nil;
        image = UIGraphicsGetImageFromCurrentImageContext();
        UIGraphicsEndImageContext();
    }
    return image;
}

@end
