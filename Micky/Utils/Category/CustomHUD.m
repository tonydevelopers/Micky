//
//  CustomHUD.m
//
//  Created by 张宁 on 16/5/10.
//  Copyright © 2016年 张宁. All rights reserved.
//

#import "CustomHUD.h"

#define WIDTH [UIScreen mainScreen].bounds.size.width
#define HEIGHT [UIScreen mainScreen].bounds.size.height
#define DF_nowheight(a) (a.frame.origin.y + a.frame.size.height)
#define DF_nowwidth(a) (a.frame.origin.x + a.frame.size.width)

@implementation CustomHUD

/**
 *  单例实例化
 *
 *  @return 返回实例化单例
 */
+(CustomHUD *)shareCustomHud
{
    static CustomHUD *hud = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        hud = [[CustomHUD alloc]init];
        hud.frame = CGRectMake(0, 0, WIDTH, HEIGHT);
        hud.backgroundColor = [UIColor clearColor];
        [hud createHudUI];
    });
    return hud;
}

/**
 *  创建UI--HUD
 */
-(void)createHudUI
{
    if (!_bgView) {
        _bgView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, WIDTH/4, WIDTH/4)];
    }
    _bgView.backgroundColor = [UIColor colorWithRed:0 green:0 blue:0 alpha:0.75];
    _bgView.layer.cornerRadius = 8.0;
    _bgView.center = self.center;
    [self addSubview:_bgView];
    
    if (!_activityView) {
        _activityView = [[UIActivityIndicatorView alloc]initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleWhiteLarge];
    }
    _activityView.frame = CGRectMake(0, 0, _bgView.frame.size.width/2, _bgView.frame.size.width/2);
    [_bgView addSubview:_activityView];
    
    if (!_contentlabel) {
        _contentlabel = [[UILabel alloc]initWithFrame:CGRectMake(5, DF_nowheight(_activityView)+5, _bgView.frame.size.width-10, _bgView.frame.size.width/2-10)];
    }
    _contentlabel.textAlignment = NSTextAlignmentCenter;
    _contentlabel.font = [UIFont systemFontOfSize:14.0];
    _contentlabel.textColor = [UIColor whiteColor];
    _contentlabel.numberOfLines = 0;
    _contentlabel.text = @"请稍后";
    [_bgView addSubview:_contentlabel];
}

/**
 *  设置显示内容以及等待时间
 *
 *  @param time    等待时间
 *  @param content 显示内容
 */
+(void)createHudCustomTime:(CGFloat)time showContent:(NSString *)content
{
    CustomHUD *weakSelf = [CustomHUD shareCustomHud];
    weakSelf.activityView.hidden = NO;
    CGSize size = [weakSelf labelText:content fondSize:14.0 width:WIDTH-60];
    CGFloat w = size.width < 50 ? 70:size.width;
    CGFloat w1 = w > WIDTH-40 ? WIDTH-40:w;
    weakSelf.bgView.frame = CGRectMake(0, 0, w1+20, size.height+80);
    weakSelf.bgView.center = [CustomHUD shareCustomHud].center;
    
    weakSelf.activityView.frame = CGRectMake(0, 0, 50, 50);
    weakSelf.activityView.center = CGPointMake(weakSelf.bgView.frame.size.width/2, 35);
    [weakSelf.activityView startAnimating];
    
    weakSelf.contentlabel.frame = CGRectMake(10, DF_nowheight(weakSelf.activityView)+10, w1, size.height);
    [CustomHUD shareCustomHud].contentlabel.text = content;
    [[CustomHUD shareCustomHud] addHUDWithSelf];

    [UIView animateWithDuration:time animations:^{
        weakSelf.alpha = 0.0;
    } completion:^(BOOL finished) {
        if (finished) {
            [weakSelf.activityView stopAnimating];
            [weakSelf removeFromSuperview];
            weakSelf.alpha = 1.0;
        }
    }];
}

/**
 *  设置显示内容
 *
 *  @param content 显示内容
 */
+(void)createHudCustomShowContent:(NSString *)content
{
    CustomHUD *weakSelf = [CustomHUD shareCustomHud];
    weakSelf.activityView.hidden = NO;
    CGSize size = [weakSelf labelText:content fondSize:14.0 width:WIDTH-60];
    CGFloat w = size.width < 50 ? 70:size.width;
    CGFloat w1 = w > WIDTH-40 ? WIDTH-40:w;
    weakSelf.bgView.frame = CGRectMake(0, 0, w1+20, size.height+80);
    weakSelf.bgView.center = weakSelf.center;
    
    weakSelf.activityView.center = CGPointMake(weakSelf.bgView.frame.size.width/2, 35);
    [weakSelf.activityView startAnimating];
    
    weakSelf.contentlabel.frame = CGRectMake(10, DF_nowheight(weakSelf.activityView)+10, w1, size.height);
    weakSelf.contentlabel.text = content;
    [weakSelf addHUDWithSelf];
}

/**
 *  仅显示提示语
 *
 *  @param content 提示语
 */
+(void)createShowContent:(NSString *)content hiddenTime:(CGFloat)time
{
    __block CustomHUD *weakSelf = [CustomHUD shareCustomHud];
    weakSelf.activityView.hidden = YES;

    CGSize size = [weakSelf labelText:content fondSize:14.0 width:WIDTH-60];
    CGFloat w = size.width < 50 ? 70:size.width+20;
    weakSelf.bgView.frame = CGRectMake(0, 0, w, size.height+20);
//    weakSelf.bgView.center = weakSelf.center;
    weakSelf.bgView.center = CGPointMake(weakSelf.frame.size.width/2.0, weakSelf.frame.size.height/2.0-30) ;
    weakSelf.contentlabel.frame = CGRectMake(10, 10, size.width, size.height);
    weakSelf.contentlabel.text = content;
    [weakSelf addHUDWithSelf];
    [UIView animateWithDuration:time animations:^{
        weakSelf.alpha = 0.0;
    } completion:^(BOOL finished) {
        if (finished) {
            [weakSelf.activityView stopAnimating];
            [weakSelf removeFromSuperview];
            weakSelf.alpha = 1.0;
        }
    }];
}

/**
 *  停止并隐藏
 */
+(void)stopHidden
{
    __block CustomHUD *weakSelf = [CustomHUD shareCustomHud];
    [UIView animateWithDuration:0.5 animations:^{
        weakSelf.alpha = 0.0;
    } completion:^(BOOL finished) {
        if (finished) {
            [weakSelf.activityView stopAnimating];
            [weakSelf removeFromSuperview];
            weakSelf.alpha = 1.0;
        }
    }];
}

/**
 *  HUD添加在window上
 */
-(void)addHUDWithSelf
{
    UIWindow *window = [UIApplication sharedApplication].keyWindow;
    [window addSubview:self];
}

/**
 *  计算字符串长度，UILabel自适应高度
 *
 *  @param text  需要计算的字符串
 *  @param size  字号大小
 *  @param width 最大宽度
 *
 *  @return 返回大小
 */
-(CGSize)labelText:(NSString *)text fondSize:(float)size width:(CGFloat)width
{
    NSDictionary *send = @{NSFontAttributeName: [UIFont systemFontOfSize:size]};
    CGSize textSize = [text boundingRectWithSize:CGSizeMake(width, 0)
                                         options:NSStringDrawingTruncatesLastVisibleLine |
                                                 NSStringDrawingUsesLineFragmentOrigin |
                                                 NSStringDrawingUsesFontLeading
                                      attributes:send context:nil].size;
    return textSize;
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
