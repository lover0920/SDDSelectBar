//
//  SDDSelectBarConfig.h
//  LizhiRun
//
//  Created by 孙号斌 on 2018/4/3.
//  Copyright © 2018年 SX. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef NS_ENUM(NSInteger, SDDSelectBarType) {
    SDDSelectBarTypeNormal,
    SDDSelectBarTypeLeft
};

@interface SDDSelectBarConfig : NSObject
+ (instancetype)defaultConfig;

@property (nonatomic, strong) UIColor *background;
@property (nonatomic, strong) UIColor *itemNormalColor;
@property (nonatomic, strong) UIColor *itemSelectedColor;
@property (nonatomic, strong) UIFont  *itemFont;
@property (nonatomic, strong) UIColor *indicateColor;
@property (nonatomic, assign) CGFloat indicateHeight;
@property (nonatomic, assign) CGFloat indicateWidth;
@property (nonatomic, assign) SDDSelectBarType type;
@property (nonatomic, assign) CGFloat minInterval;

/**背景颜色*/
@property (nonatomic, copy, readonly) SDDSelectBarConfig *(^barBackgroundColor)(UIColor *color);


/**默认颜色*/
@property (nonatomic, copy, readonly) SDDSelectBarConfig *(^titleNormalColor)(UIColor *color);
/**选中颜色*/
@property (nonatomic, copy, readonly) SDDSelectBarConfig *(^titleSelectColor)(UIColor *color);
/**文字字体大小*/
@property (nonatomic, copy, readonly) SDDSelectBarConfig *(^titleFont)(UIFont *font);


/**指示器颜色*/
@property (nonatomic, copy, readonly) SDDSelectBarConfig *(^indicatorColor)(UIColor *color);
/**指示器高度*/
@property (nonatomic, copy, readonly) SDDSelectBarConfig *(^indicatorHeight)(CGFloat h);
/**指示器宽度*/
@property (nonatomic, copy, readonly) SDDSelectBarConfig *(^indicatorWidth)(CGFloat w);


@property (nonatomic, copy, readonly) SDDSelectBarConfig *(^barType)(SDDSelectBarType type);
@property (nonatomic, copy, readonly) SDDSelectBarConfig *(^titleMinInterval)(CGFloat interval);


@end
