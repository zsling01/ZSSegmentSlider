//
//  ZSSegmentBar.m
//  ZSSegmentBar
//
//  Created by zsling on 17/9/2.
//  Copyright © 2017年 zsling. All rights reserved.
//

#import "ZSSegmentBar.h"

#define kMinMargin 30

@interface ZSSegmentBar ()
{
    UIButton *_selectBtn;
}
    
@property (nonatomic, strong) UIScrollView *contentView;

@property (nonatomic, strong) UIView *indicatorView;

@property (nonatomic, strong) NSMutableArray<UIButton *> *itemBtns;

@property (nonatomic, strong) ZSSegmentBarConfig *segmentConfig;
    
@end

@implementation ZSSegmentBar

+ (instancetype)segmentBarWithFrame:(CGRect)frame {
    ZSSegmentBar *segmentBar = [[ZSSegmentBar alloc] initWithFrame:frame];
    return segmentBar;
}


- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        self.backgroundColor = self.segmentConfig.segmentBarBackgroundColor;
    }
    return self;
}


- (void)setItems:(NSArray<NSString *> *)items {
    _items = items;
    
    [self.itemBtns makeObjectsPerformSelector:@selector(removeFromSuperview)];
    self.itemBtns = nil;
    
    for (NSString *title in items) {
        UIButton *btn = [[UIButton alloc] initWithFrame:CGRectZero];
        btn.tag = self.itemBtns.count;
        [btn addTarget:self action:@selector(btnClick:) forControlEvents:UIControlEventTouchUpInside];
        btn.titleLabel.font = self.segmentConfig.itemFont;
        [btn setTitle:title forState:UIControlStateNormal];
        [btn setTitleColor:self.segmentConfig.itemNormalColor forState:UIControlStateNormal];
        [btn setTitleColor:self.segmentConfig.itemSelectColor forState:UIControlStateSelected];
        [self.contentView addSubview:btn];
        [self.itemBtns addObject:btn];
    }
    
    [self setNeedsLayout];
    [self layoutIfNeeded];
}


- (void)setSelectIndex:(NSInteger)selectIndex {
    if (self.itemBtns.count == 0 || selectIndex < 0 || selectIndex > self.itemBtns.count - 1) {
        return;
    }
    
    _selectIndex = selectIndex;
    
    UIButton *selBtn = self.itemBtns[selectIndex];
    [self btnClick:selBtn];
}


- (void)updateSegmentConfig:(void (^)(ZSSegmentBarConfig *))configBlock {
    if (configBlock) {
        configBlock(self.segmentConfig);
    }
    
    self.backgroundColor = self.segmentConfig.segmentBarBackgroundColor;
    
    for (UIButton *btn in self.itemBtns) {
        [btn setTitleColor:self.segmentConfig.itemNormalColor forState:UIControlStateNormal];
        [btn setTitleColor:self.segmentConfig.itemSelectColor forState:UIControlStateSelected];
        btn.titleLabel.font = self.segmentConfig.itemFont;
    }
    
    self.indicatorView.backgroundColor = self.segmentConfig.indicatorColor;
    
    [self setNeedsLayout];
    [self layoutIfNeeded];
}


- (void)btnClick:(UIButton *)btn {
    
    if ([self.delegate respondsToSelector:@selector(segmentBar:didSelectIndex:fromIndex:)]) {
        [self.delegate segmentBar:self didSelectIndex:btn.tag fromIndex:_selectIndex];
    }
    
    _selectBtn.selected = NO;
    btn.selected = YES;
    _selectBtn = btn;
    _selectIndex = btn.tag;
    
    [UIView animateWithDuration:0.1 animations:^{
        self.indicatorView.width = btn.width + self.segmentConfig.indicatorExtraW * 2;
        self.indicatorView.height = self.segmentConfig.indicatorHeight;
        self.indicatorView.centerX = btn.centerX;
        self.indicatorView.y = self.height - self.segmentConfig.indicatorHeight;
    }];
    
    // btn 滑动居中
    CGFloat offset = btn.centerX - self.contentView.width * 0.5;
    if (offset < 0) {
        offset = 0;
    } else if (offset > self.contentView.contentSize.width - self.contentView.width) {
        offset = self.contentView.contentSize.width - self.contentView.width;
    }
    [self.contentView setContentOffset:CGPointMake(offset, 0) animated:YES];
}


- (void)layoutSubviews {
    [super layoutSubviews];
    self.contentView.frame = self.bounds;
    
    CGFloat totalWidth = 0;
    for (UIButton *btn in self.itemBtns) {
        [btn sizeToFit];
        totalWidth += btn.width;
    }
    
    CGFloat margin = (self.width - totalWidth) / (self.itemBtns.count + 1);
    if (margin < kMinMargin) {
        margin = kMinMargin;
    }
    
    CGFloat lastX = margin;
    for (UIButton *btn in self.itemBtns) {
        [btn sizeToFit];
        btn.x = lastX;
        btn.y = 0;
        lastX += btn.width + margin;
    }
    
    self.contentView.contentSize = CGSizeMake(lastX, 0);
    
    self.indicatorView.width = _selectBtn.width + self.segmentConfig.indicatorExtraW * 2;
    self.indicatorView.height = self.segmentConfig.indicatorHeight;
    self.indicatorView.centerX = _selectBtn.centerX;
    self.indicatorView.y = self.height - self.segmentConfig.indicatorHeight;
}


#pragma mark - lazy
    
- (UIScrollView *)contentView {
    if (_contentView == nil) {
        UIScrollView *scrollView = [[UIScrollView alloc] init];
        scrollView.showsHorizontalScrollIndicator = NO;
        [self addSubview:scrollView];
        _contentView = scrollView;
    }
    return _contentView;
}


- (UIView *)indicatorView {
    if (_indicatorView == nil) {
        UIView *indicator = [[UIView alloc] initWithFrame:CGRectZero];
        indicator.backgroundColor = self.segmentConfig.indicatorColor;
        
        [self.contentView addSubview:indicator];
        _indicatorView = indicator;
    }
    return _indicatorView;

}

    
- (NSMutableArray<UIButton *> *)itemBtns {
    if (_itemBtns == nil) {
        _itemBtns = [NSMutableArray array];
    }
    return _itemBtns;
}


- (ZSSegmentBarConfig *)segmentConfig {
    if (_segmentConfig == nil) {
        _segmentConfig = [ZSSegmentBarConfig defaultConfig];
    }
    return _segmentConfig;
}

@end
