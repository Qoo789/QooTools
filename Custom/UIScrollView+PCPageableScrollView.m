//
//  UIScrollView+PCPageableScrollView.m
//  PaginationDemo
//
//  Created by pincai on 2017/11/14.
//  Copyright © 2017年 Pincai. All rights reserved.
//

#import "UIScrollView+PCPageableScrollView.h"

static const float kAnimationDuration = 0.25f;

static const char pc_originContentHeight;
static const char pc_secondScrollView;

@interface UIScrollView()

@property (nonatomic, assign) float originContentHeight;

@end

@implementation UIScrollView (PCPageableScrollView)

// originContentHeight - set
- (void)setOriginContentHeight:(float)originContentHeight {
    objc_setAssociatedObject(self, &pc_originContentHeight, @(originContentHeight), OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

// originContentHeight - get
- (float)originContentHeight {
    return [objc_getAssociatedObject(self, &pc_originContentHeight) floatValue];
}

// secondScrollView - set
- (void)setSecondScrollView:(UIScrollView *)secondScrollView {
    objc_setAssociatedObject(self, &pc_secondScrollView, secondScrollView, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    
    [self addFirstScrollViewFooter];
    
    secondScrollView.pc_top = self.contentSize.height + self.mj_footer.pc_height;
    
    [self addSubview:secondScrollView];
    [self addSecondScrollViewHeader];
}

// secondScrollView - get
- (UIScrollView *)secondScrollView {
    return objc_getAssociatedObject(self, &pc_secondScrollView);
}

// 设置第一个 scrollView 的 footer
- (void)addFirstScrollViewFooter {
    
    __weak __typeof(self) weakSelf = self;
    MJRefreshAutoNormalFooter *footer = [MJRefreshAutoNormalFooter footerWithRefreshingBlock:^{
        [weakSelf endFooterRefreshing];
    }];
    
//    footer.appearencePercentTriggerAutoRefresh = 2;
    footer.triggerAutomaticallyRefreshPercent = 2;
    [footer setTitle:@"向上滑动, 查看详情" forState:MJRefreshStateIdle];
    
    self.mj_footer = footer;
}

- (void)endFooterRefreshing {
    [self.mj_footer endRefreshing];
    self.mj_footer.hidden = YES;
    self.scrollEnabled = NO;
    
    self.secondScrollView.mj_header.hidden = NO;
    self.secondScrollView.scrollEnabled = YES;
    
    [UIView animateWithDuration:kAnimationDuration animations:^{
        self.contentInset = UIEdgeInsetsMake(- self.contentSize.height - self.mj_footer.frame.size.height, 0, 0, 0);
    }];
    
    self.originContentHeight = self.contentSize.height;
    self.contentSize = self.secondScrollView.contentSize;
}

// 设置第二个 scrollView 的 header
- (void)addSecondScrollViewHeader {
    __weak __typeof(self) weakSelf = self;
    MJRefreshNormalHeader *header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
        [weakSelf endHeaderRefreshing];
    }];
    header.lastUpdatedTimeLabel.hidden = YES;
    [header setTitle:@"下拉,返回产品页" forState:MJRefreshStateIdle];
    [header setTitle:@"释放,返回产品页" forState:MJRefreshStatePulling];
    
    self.secondScrollView.mj_header = header;
}

- (void)endHeaderRefreshing {
    [self.secondScrollView.mj_header endRefreshing];
    self.secondScrollView.mj_header.hidden = YES;
    self.secondScrollView.scrollEnabled = NO;
    
    self.scrollEnabled = YES;
    
    // 这里根据需求, 更改 self.contentInset 的 bottom, 自己认为应该是0比较好, 也有需要设置成 self.mj_footer.frame.size.height 的, 可以根据需要的效果做数值调整.
    [UIView animateWithDuration:kAnimationDuration animations:^{
        self.contentInset = UIEdgeInsetsMake(0, 0, 5, 0);
    }];
    
    self.contentSize = CGSizeMake(0, self.originContentHeight);
    
    [self setContentOffset:CGPointZero animated:YES];
    
    [self addFirstScrollViewFooter];
}

@end
