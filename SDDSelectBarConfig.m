//
//  SDDSelectBarConfig.m
//  LizhiRun
//
//  Created by 孙号斌 on 2018/4/3.
//  Copyright © 2018年 SX. All rights reserved.
//

#import "SDDSelectBarConfig.h"

@implementation SDDSelectBarConfig
+ (instancetype)defaultConfig
{
    SDDSelectBarConfig *config = [[SDDSelectBarConfig alloc] init];
    config.background = UIColorWhite;
    config.itemFont = UIFont(14);
    config.itemNormalColor = UIColorTitle3;
    config.itemSelectedColor = UIColorTheme;
    config.indicateColor = UIColorTheme;
    config.indicateHeight = 2.0f;
    config.indicateWidth = 28.0f;
    config.type = SDDSelectBarTypeNormal;
    config.minInterval = 44.0f;
    return config;
}

#pragma mark - getter方法
- (SDDSelectBarConfig *(^)(UIColor *))barBackgroundColor
{
    return ^(UIColor *color){
        self.background = color;
        return self;
    };
}

- (SDDSelectBarConfig *(^)(UIFont *))titleFont
{
    return ^(UIFont *font){
        self.itemFont = font;
        return self;
    };
}

- (SDDSelectBarConfig *(^)(UIColor *))titleNormalColor
{
    return ^(UIColor *color){
        self.itemNormalColor = color;
        return self;
    };
}
- (SDDSelectBarConfig *(^)(UIColor *))titleSelectColor
{
    return ^(UIColor *color){
        self.itemSelectedColor = color;
        return self;
    };
}

- (SDDSelectBarConfig *(^)(UIColor *))indicatorColor
{
    return ^(UIColor *color){
        self.indicateColor = color;
        return self;
    };
}
- (SDDSelectBarConfig *(^)(CGFloat))indicatorWidth
{
    return ^(CGFloat width){
        self.indicateWidth = width;
        return self;
    };
}
- (SDDSelectBarConfig *(^)(CGFloat))indicatorHeight
{
    return ^(CGFloat height){
        self.indicateHeight = height;
        return self;
    };
}

-(SDDSelectBarConfig *(^)(SDDSelectBarType))barType
{
    return ^(SDDSelectBarType type){
        self.type = type;
        return self;
    };
}

- (SDDSelectBarConfig *(^)(CGFloat))titleMinInterval
{
    return ^(CGFloat minInterval){
        self.minInterval = minInterval;
        return self;
    };
}
@end
