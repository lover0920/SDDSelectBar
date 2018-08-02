/***************************************************************************
 *版权所有 ©2016 陕西深度网络科技有限公司
 *
 *文件名称： SDDSelectBarView
 *内容摘要：
 *其他说明： 改进点：1、滑动页面切换指示器
 *当前版本： 1.0.0
 *作   者： 孙号斌
 *完成日期： 2016年12月13日
 
 *修改记录1： <#修改历史记录#>
 *    修改日期： <##>
 *    版 本 号： <##>
 *    修 改 人： <##>
 *    修改内容： <#修改原因以及修改内容说明#>
 *修改记录2：...
 *
 ***************************************************************************/


#import <UIKit/UIKit.h>
#import "SDDSelectBarConfig.h"

@class SDDSelectBarView;
@protocol SDDSelectBarViewProtocol <NSObject>
- (void)selectBarView:(SDDSelectBarView *)barView selectedIndex:(NSInteger)index;
@end


@interface SDDSelectBarView : UIScrollView
- (instancetype)initWithFrame:(CGRect)frame;

/**
 代理
 */
@property (nonatomic, assign) id<SDDSelectBarViewProtocol> myDelegate;
/**
 选择的Index
 */
@property (nonatomic, assign) NSInteger selectedIndex;
/**
 数据
 */
@property (nonatomic, strong) NSArray<NSString *>   *textArray;


/**
 更新页面样式
 */
- (void)updateViewWithConfig:(void(^)(SDDSelectBarConfig *config))config;
@end
