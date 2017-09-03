//
//  ZSSegmentBarVC.h
//  ZSSegmentBar
//
//  Created by zsling on 17/9/2.
//  Copyright © 2017年 zsling. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ZSSegmentBar.h"

@interface ZSSegmentBarVC : UIViewController

@property (nonatomic, strong) ZSSegmentBar *segmentBar;

- (void)setUpItems:(NSArray<NSString *>*)items childVCs:(NSArray<UIViewController *> *)childVCs;

@end
