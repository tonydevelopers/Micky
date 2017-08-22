//
//  ZNCountdownView.h
//  Encapsulation
//
//  Created by 张宁 on 2017/3/24.
//  Copyright © 2017年 mosjoydev6. All rights reserved.
//

#import <UIKit/UIKit.h>

@class ZNCountdownView;

typedef void(^TimerStopBlock)();

@protocol ZNCountdownDelegate <NSObject>

- (void)countdownView:(ZNCountdownView *)countdownView hour:(NSString *)cd_hour minutes:(NSString *)cd_minutes seconds:(NSString *)cd_seconds;
- (void)countdownTimerStopView:(ZNCountdownView *)countdownView;

@end


@interface ZNCountdownView : UIView
@property(nonatomic,assign)id<ZNCountdownDelegate>delegate;
// 时间戳
@property (nonatomic,assign)NSInteger timeStamp;
// 背景图片
@property (nonatomic,copy)NSString *BGImageName;
// 时间停止后回调
@property (nonatomic,copy)TimerStopBlock timerStopBlock;

// 年
@property (nonatomic,strong)UILabel *yearLabel;
// 月
@property (nonatomic,strong)UILabel *monthLabel;
// 日
@property (nonatomic,strong)UILabel *dayLabel;
// 时
@property (nonatomic,strong)UILabel *hourLabel;
// 分
@property (nonatomic,strong)UILabel *minutesLabel;
// 秒
@property (nonatomic,strong)UILabel *secondsLabel;


// 年
@property (nonatomic,strong)NSString *year_str;
// 月
@property (nonatomic,strong)NSString *month_str;
// 日
@property (nonatomic,strong)NSString *day_str;
// 时
@property (nonatomic,strong)NSString *hour_str;
// 分
@property (nonatomic,strong)NSString *minutes_str;
// 秒
@property (nonatomic,strong)NSString *seconds_str;


// 单例对象
+ (instancetype)shareCountDown;
// 初始化对象
+ (instancetype)initCountDown;


@end
