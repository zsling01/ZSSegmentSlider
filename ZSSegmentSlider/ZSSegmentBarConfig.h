//
//  ZSSegmentBarConfig.h
//  ZSSegmentBar
//
//  Created by zsling on 17/9/2.
//  Copyright © 2017年 zsling. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface ZSSegmentBarConfig : NSObject

+ (instancetype)defaultConfig;

/**
 选项卡背景颜色
 */
@property (nonatomic, strong) UIColor *segmentBarBackgroundColor;

/**
 选项卡文字颜色
 */
@property (nonatomic, strong) UIColor *itemNormalColor;

/**
 选项卡选中文字颜色
 */
@property (nonatomic, strong) UIColor *itemSelectColor;

/**
 选项卡文字大小
 */
@property (nonatomic, strong) UIFont *itemFont;

/**
 跟踪条颜色
 */
@property (nonatomic, strong) UIColor *indicatorColor;

/**
 跟踪条高度
 */
@property (nonatomic, assign) CGFloat indicatorHeight;

/**
 跟踪条左右额外宽度
 */
@property (nonatomic, assign) CGFloat indicatorExtraW;

// 链式修改上述属性
- (ZSSegmentBarConfig *(^)(UIColor *color))c_bgColor;

- (ZSSegmentBarConfig *(^)(UIColor *color))c_itemNColor;

- (ZSSegmentBarConfig *(^)(UIColor *color))c_itemSColor;

- (ZSSegmentBarConfig *(^)(UIFont *font))c_itemF;

- (ZSSegmentBarConfig *(^)(UIColor *color))c_indicatorC;

- (ZSSegmentBarConfig *(^)(CGFloat height))c_indicatorH;

- (ZSSegmentBarConfig *(^)(CGFloat extraW))c_indicatorEW;

@end
