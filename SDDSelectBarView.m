//
//  SDDSelectBarView.m
//  选择器
//
//  Created by 孙号斌 on 16/12/12.
//  Copyright © 2016年 孙号斌. All rights reserved.
//

#import "SDDSelectBarView.h"

@interface SDDSelectBarView ()
@property (nonatomic, strong) UIView            *indicatorView;
@property (nonatomic, strong) NSMutableArray    *textWidthArray;
@property (nonatomic, strong) NSMutableArray<UIButton *>    *buttonArray;
@property (nonatomic, strong) SDDSelectBarConfig *config;

@property (nonatomic, strong) UIButton *lastButton;
@property (nonatomic, assign) CGFloat buttonsWidth;
@end


@implementation SDDSelectBarView
#pragma mark - 懒加载
- (SDDSelectBarConfig *)config
{
    if (!_config) {
        _config = [SDDSelectBarConfig defaultConfig];
    }
    return _config;
}
- (NSMutableArray<UIButton *> *)buttonArray
{
    if (!_buttonArray) {
        _buttonArray = [NSMutableArray array];
    }
    return _buttonArray;
}
- (NSMutableArray *)textWidthArray
{
    if (!_textWidthArray) {
        _textWidthArray = [NSMutableArray array];
    }
    return _textWidthArray;
}


#pragma mark - 初始化
- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self)
    {
        [self createUIWithFrame:frame];
    }
    return self;
}

- (void)createUIWithFrame:(CGRect)frame
{
    _selectedIndex = 0;
    
    /*************** 设置滚动视图 ***************/
    self.backgroundColor = self.config.background;
    self.showsHorizontalScrollIndicator = NO;
    
    /*************** 创建指示器视图 ***************/
    _indicatorView = [[UIView alloc]initWithFrame:CGRectZero];
    _indicatorView.backgroundColor = self.config.indicateColor;
    [self addSubview:_indicatorView];
}

- (void)updateViewWithConfig:(void (^)(SDDSelectBarConfig *))config
{
    if (config) {
        config(self.config);
    }
    
    self.backgroundColor = self.config.background;
    self.indicatorView.backgroundColor = self.config.indicateColor;
    self.indicatorView.layer.cornerRadius = self.config.indicateHeight/2;
    for (UIButton *button in self.buttonArray)
    {
        [button setTitleColor:self.config.itemNormalColor
                     forState:UIControlStateNormal];
        [button setTitleColor:self.config.itemSelectedColor
                     forState:UIControlStateSelected];
        button.titleLabel.font = self.config.itemFont;
    }
    
    
    [self setNeedsLayout];
    [self layoutIfNeeded];
    
}

#pragma mark - 重写Setter方法
- (void)setTextArray:(NSArray<NSString *> *)textArray
{
    _textArray = textArray;
    
    //删除
    [self.buttonArray makeObjectsPerformSelector:@selector(removeFromSuperview)];
    [self.buttonArray removeAllObjects];
    self.buttonArray = nil;
    
    [self.textWidthArray removeAllObjects];
    self.buttonsWidth = 0.0f;
    
    //添加
    for (NSString *item in textArray)
    {
        UIButton *btn = [[UIButton alloc]init];
        btn.tag = self.buttonArray.count;
        [btn addTarget:self
                action:@selector(buttonClickAction:)
      forControlEvents:UIControlEventTouchDown];
        [btn setTitleColor:self.config.itemNormalColor
                  forState:UIControlStateNormal];
        [btn setTitleColor:self.config.itemSelectedColor
                  forState:UIControlStateSelected];
        btn.titleLabel.font = self.config.itemFont;
        [btn setTitle:item forState:UIControlStateNormal];
        [self addSubview:btn];
        [self.buttonArray addObject:btn];
        
        CGFloat width = [SDDSelectBarView sizeOfString:item
                                             withWidth:SCREEN_WIDTH
                                                  font:self.config.itemFont].width;
        [self.textWidthArray addObject:[NSNumber numberWithFloat:width]];
        self.buttonsWidth += width;
    }
    
    //更新页面
    [self setNeedsLayout];
    [self layoutIfNeeded];
}

- (void)setSelectedIndex:(NSInteger)selectedIndex
{
    _selectedIndex = selectedIndex;
    
    if (self.textArray.count == 0 || selectedIndex < 0 || selectedIndex > self.textArray.count- 1)
    {
        return;
    }
        
    UIButton *btn = self.buttonArray[selectedIndex];
    [self buttonClickAction:btn];
}


#pragma mark - 按钮的点击事件
- (void)buttonClickAction:(UIButton *)button
{
    if ([self.myDelegate respondsToSelector:@selector(selectBarView:selectedIndex:)])
    {
        [self.myDelegate selectBarView:self selectedIndex:(button.tag)];
    }
    
    //设置选择的index
    _selectedIndex = button.tag;
    
    //设置Button颜色变化
    _lastButton.selected = NO;
    button.selected = YES;
    _lastButton = button;
    
    //设置指示器的动画
    [UIView animateWithDuration:0.1 animations:^{
        self.indicatorView.centerX = button.centerX;
    } completion:^(BOOL finished) {
        [self scrollRectToVisible:CGRectMake(button.left-(self.width-button.width)/2, 0, self.width, self.height) animated:YES];
    }];
}

#pragma mark - layout
- (void)layoutSubviews
{
    [super layoutSubviews];
    
    //求Button的间距
    CGFloat sumWidth = self.buttonsWidth + (self.textArray.count+1) * self.config.minInterval;
    
    CGFloat interval = 0;
    if (sumWidth > self.width || self.config.type == SDDSelectBarTypeLeft)
    {
        interval = self.config.minInterval;
        self.contentSize = CGSizeMake(sumWidth, self.height);
    }
    else
    {
        interval = (self.width - self.buttonsWidth)/(self.textArray.count+1);
        self.contentSize = CGSizeMake(self.width, self.height);
    }
    
    //设置Button的位置
    NSInteger i = 0;
    CGFloat textsWidth = 0;
    for (UIButton *button in self.buttonArray)
    {
        CGFloat btnWidth = [[self.textWidthArray objectAtIndex:i] floatValue] + interval;
        
        button.frame = CGRectMake(interval/2+textsWidth, 0, btnWidth, self.height-self.config.indicateHeight);
        
        if (i == self.selectedIndex)
        {
            self.indicatorView.frame = CGRectMake(0, 0, self.config.indicateWidth, self.config.indicateHeight);
            self.indicatorView.center = CGPointMake(button.centerX, self.height-self.config.indicateHeight/2);
        }
        
        textsWidth += btnWidth;
        i++;
    }
    
}


#pragma mark -
+ (CGSize)sizeOfString:(NSString *)text
             withWidth:(float)width
                  font:(UIFont *)font
{
    CGSize size = CGSizeMake(width, MAXFLOAT);
    
    if ([text respondsToSelector:@selector(boundingRectWithSize:options:attributes:context:)]) {
        NSDictionary *tdic = [NSDictionary dictionaryWithObjectsAndKeys:font, NSFontAttributeName, nil];
        size = [text boundingRectWithSize:size
                                  options:NSStringDrawingUsesLineFragmentOrigin | NSStringDrawingUsesFontLeading
                               attributes:tdic
                                  context:nil].size;
    } else {
#pragma clang diagnostic push
#pragma clang diagnostic ignored "-Wdeprecated-declarations"
        size = [text sizeWithFont:font constrainedToSize:size lineBreakMode:NSLineBreakByCharWrapping];
#pragma clang diagnostic pop
    }
    
    return size;
}


@end
