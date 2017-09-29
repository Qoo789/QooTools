//
//  UINavigationBar+PCNavBar.h
//  Pincai
//
//  Created by pincai on 2017/9/19.
//  Copyright © 2017年 Pincai. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UINavigationBar (PCNavBar)

// 给导航栏设置颜色
- (void)pc_setBackgroundColor:(UIColor *)backgroundColor;

// 设置导航栏位置
- (void)pc_setTranslationY:(CGFloat)translationY;

// 还原导航栏位置
- (void)pc_setTransformIdentity;

// 设置导航栏上子控件的透明度
- (void)pc_setElementsAlpha:(CGFloat)alpha;

// 重置导航栏
- (void)pc_reset;

@end
