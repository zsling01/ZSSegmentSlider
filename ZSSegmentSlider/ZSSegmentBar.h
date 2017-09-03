//
//  ZSSegmentBar.h
//  ZSSegmentBar
//
//  Created by zsling on 17/9/2.
//  Copyright © 2017年 zsling. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "UIView+Extension.h"
#import "ZSSegmentBarConfig.h"

@class ZSSegmentBar;

@protocol ZSSegmentBarDelegate <NSObject>

@optional
- (void)segmentBar:(ZSSegmentBar *)segmentBar didSelectIndex:(NSInteger)selectIndex fromIndex:(NSInteger)fromIndex;

@end

@interface ZSSegmentBar : UIView

+ (instancetype)segmentBarWithFrame:(CGRect)frame;

@property (nonatomic, weak) id<ZSSegmentBarDelegate> delegate;

/**
 标题数组
 */
@property (nonatomic, strong) NSArray<NSString *> *items;

/**
 当前选中的index
 */
@property (nonatomic, assign) NSInteger selectIndex;

/**
 更新segment配置

 @param configBlock 当前的config
 */
- (void)updateSegmentConfig:(void(^)(ZSSegmentBarConfig *segmentConfig))configBlock;

@end
