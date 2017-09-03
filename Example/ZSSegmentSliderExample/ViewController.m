//
//  ViewController.m
//  ZSSegmentSliderExample
//
//  Created by zsling on 17/9/3.
//  Copyright © 2017年 zsling. All rights reserved.
//

#import "ViewController.h"
#import "ZSSegmentBarVC.h"

#define MCRandomColor       [UIColor colorWithRed:(arc4random_uniform(256)) / 255.0 green:(arc4random_uniform(256)) / 255.0 \
blue:(arc4random_uniform(256)) / 255.0 alpha:(1.0)]

@interface ViewController ()

@property (nonatomic, strong) ZSSegmentBarVC *segmentBarVC;

@end

@implementation ViewController


- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.automaticallyAdjustsScrollViewInsets = NO;
    
    // 做为titleView
    //    self.segmentBarVC.segmentBar.frame = CGRectMake(0, 0, self.view.width, 60);
    //    self.navigationItem.titleView = (UIView *)self.segmentBarVC.segmentBar;
    
    self.segmentBarVC.view.frame = CGRectMake(0, 64, self.view.width, self.view.height - 64);
    [self.view addSubview:self.segmentBarVC.view];
    
    NSArray *items = @[@"标题1", @"标题2", @"标题3", @"标题4", @"标题5", @"标题6"];
    
    NSMutableArray *childVCs = [NSMutableArray arrayWithCapacity:items.count];
    
    [items enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        UIViewController *vc = [[UIViewController alloc] init];
        vc.view.backgroundColor = MCRandomColor;
        [childVCs addObject:vc];
        
    }];
    
    //修改segmentBar的frame
    //self.segmentBarVC.segmentBar.frame = CGRectMake(0, 0, self.view.width, 60);
    [self.segmentBarVC setUpItems:items childVCs:childVCs];
}


- (IBAction)changeSegmentStyle:(UIBarButtonItem *)sender {
    [self.segmentBarVC.segmentBar updateSegmentConfig:^(ZSSegmentBarConfig *segmentConfig) {
        segmentConfig.c_itemNColor([UIColor greenColor]).c_itemSColor([UIColor purpleColor]).c_indicatorEW(10).c_indicatorH(4).c_indicatorC([UIColor purpleColor]);
    }];
}


#pragma mark - lazy

- (ZSSegmentBarVC *)segmentBarVC {
    if (_segmentBarVC == nil) {
        _segmentBarVC = [[ZSSegmentBarVC alloc] init];
        [self addChildViewController:_segmentBarVC];
    }
    return _segmentBarVC;
}


@end
