//
//  ZSSegmentBarVC.m
//  ZSSegmentBar
//
//  Created by zsling on 17/9/2.
//  Copyright © 2017年 zsling. All rights reserved.
//

#import "ZSSegmentBarVC.h"

@interface ZSSegmentBarVC ()<UIScrollViewDelegate, ZSSegmentBarDelegate>

@property (nonatomic, strong) UIScrollView *contentView;

@end

@implementation ZSSegmentBarVC

- (void)viewDidLoad {
    [super viewDidLoad];
    self.automaticallyAdjustsScrollViewInsets = NO;
}


- (void)setUpItems:(NSArray<NSString *> *)items childVCs:(NSArray<UIViewController *> *)childVCs {
    self.segmentBar.items = items;
    
    [self.childViewControllers makeObjectsPerformSelector:@selector(removeFromParentViewController)];
    
    for (UIViewController *childVC in childVCs) {
        [self addChildViewController:childVC];
    }
    
    self.contentView.contentSize = CGSizeMake(items.count * self.view.width, 0);
    self.segmentBar.selectIndex = 0;
}


- (void)viewWillLayoutSubviews {
    [super viewWillLayoutSubviews];
    
    if (self.segmentBar.superview == self.view) {
        
        CGFloat contentY = CGRectGetMaxY(self.segmentBar.frame);
        self.contentView.frame = CGRectMake(0, contentY, self.view.width, self.view.height - contentY);
        self.contentView.contentSize = CGSizeMake(self.childViewControllers.count * self.view.width, 0);
        return;
    }
    
    self.contentView.frame = self.view.bounds;
    self.contentView.contentSize = CGSizeMake(self.childViewControllers.count * self.view.width, 0);
}

#pragma mark - <ZSSegmentBarDelegate>

- (void)segmentBar:(ZSSegmentBar *)segmentBar didSelectIndex:(NSInteger)selectIndex fromIndex:(NSInteger)fromIndex {
    
    if (self.childViewControllers.count == 0 || selectIndex < 0 || selectIndex > self.childViewControllers.count - 1) {
        return;
    }
    
    UIViewController *vc = self.childViewControllers[selectIndex];
    vc.view.frame = CGRectMake(selectIndex * self.view.width, 0, self.contentView.width, self.contentView.height);
    [self.contentView addSubview:vc.view];
    
    [self.contentView setContentOffset:CGPointMake(selectIndex * self.view.width, 0) animated:NO];
}


#pragma mark - <UIScrollViewDelegate>

- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView {
    CGFloat offset = scrollView.contentOffset.x;
    self.segmentBar.selectIndex = offset / self.view.width;
}


#pragma mark - lazy

- (UIScrollView *)contentView {
    if (_contentView == nil) {
        UIScrollView *scrollView = [[UIScrollView alloc] init];
        scrollView.pagingEnabled = YES;
        scrollView.showsVerticalScrollIndicator = NO;
        scrollView.showsHorizontalScrollIndicator = NO;
        scrollView.delegate = self;
        [self.view addSubview:scrollView];
        _contentView = scrollView;
    }
    return _contentView;
}


- (ZSSegmentBar *)segmentBar {
    if (!_segmentBar) {
        // 这里设置frame，否则会出现初始化首个按钮位置不对
        _segmentBar = [ZSSegmentBar segmentBarWithFrame:CGRectMake(0, 0, self.view.width, 40)];
        _segmentBar.delegate = self;
        [self.view addSubview:_segmentBar];
    }
    return _segmentBar;
}

@end
