//
//  ZSSegmentBarConfig.m
//  ZSSegmentBar
//
//  Created by zsling on 17/9/2.
//  Copyright © 2017年 zsling. All rights reserved.
//

#import "ZSSegmentBarConfig.h"

@implementation ZSSegmentBarConfig

+ (instancetype)defaultConfig {
    ZSSegmentBarConfig *config = [[ZSSegmentBarConfig alloc] init];
    config.segmentBarBackgroundColor = [UIColor clearColor];
    config.itemNormalColor = [UIColor lightGrayColor];
    config.itemSelectColor = [UIColor redColor];
    config.itemFont = [UIFont systemFontOfSize:14];
    
    config.indicatorColor = [UIColor redColor];
    config.indicatorHeight = 2;
    config.indicatorExtraW = 4;
    
    return config;
}


- (ZSSegmentBarConfig *(^)(UIColor *))c_bgColor {
    return ^(UIColor *color) {
        self.segmentBarBackgroundColor = color;
        return self;
    };
}


- (ZSSegmentBarConfig *(^)(UIColor *))c_itemNColor {
    return ^(UIColor *color) {
        self.itemNormalColor = color;
        return self;
    };
}


- (ZSSegmentBarConfig *(^)(UIColor *))c_itemSColor {
    return ^(UIColor *color) {
        self.itemSelectColor = color;
        return self;
    };
}


- (ZSSegmentBarConfig *(^)(UIFont *))c_itemF {
    return ^(UIFont *color) {
        self.itemFont = color;
        return self;
    };
}


- (ZSSegmentBarConfig *(^)(UIColor *))c_indicatorC {
    return ^(UIColor *color) {
        self.indicatorColor = color;
        return self;
    };
}


- (ZSSegmentBarConfig *(^)(CGFloat))c_indicatorH {
    return ^(CGFloat indicatorH) {
        self.indicatorHeight = indicatorH;
        return self;
    };
}


- (ZSSegmentBarConfig *(^)(CGFloat))c_indicatorEW {
    return ^(CGFloat indicatorEW) {
        self.indicatorExtraW = indicatorEW;
        return self;
    };
}

@end
