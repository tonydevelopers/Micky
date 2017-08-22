//
//  ZNCountdownView.m
//  Encapsulation
//
//  Created by 张宁 on 2017/3/24.
//  Copyright © 2017年 mosjoydev6. All rights reserved.
//

#import "ZNCountdownView.h"

#define labelCount 4
#define separatorCount 3
@interface ZNCountdownView (){
    NSTimer *timer; // 定时器
}
@property (nonatomic,strong)NSMutableArray *timeLabel_A;
@property (nonatomic,strong)NSMutableArray *separatorLabel_A;

@end
@implementation ZNCountdownView

+ (instancetype)shareCountDown{
    static id instance = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        instance = [[ZNCountdownView alloc] init];
    });
    return instance;
}

+ (instancetype)initCountDown{
    return [[self alloc] init];
}
- (instancetype)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
        [self addSubview:self.dayLabel];
        [self addSubview:self.hourLabel];
        [self addSubview:self.minutesLabel];
        [self addSubview:self.secondsLabel];
        
        for (NSInteger index = 0; index < separatorCount; index ++) {
            UILabel *separateLabel = [[UILabel alloc] init];
            separateLabel.text = @":";
            separateLabel.textAlignment = NSTextAlignmentCenter;
            [self addSubview:separateLabel];
            [self.separatorLabel_A addObject:separateLabel];
        }
    }
    return self;
}

- (void)setBGImageName:(NSString *)BGImageName {
    _BGImageName = BGImageName;
    UIImageView *imageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:BGImageName]];
    imageView.frame = self.bounds;
    [self addSubview:imageView];
}
- (void)setTimeStamp:(NSInteger)timeStamp {
    _timeStamp = timeStamp;
    if (_timeStamp != 0) {
        timer =[NSTimer scheduledTimerWithTimeInterval:1 target:self selector:@selector(timer:) userInfo:nil repeats:YES];
    }
}
-(void)timer:(NSTimer*)timerr{
    _timeStamp--;
    [self getDetailTimeWithTimestamp:_timeStamp];
    if (_timeStamp == 0) {
        [timer invalidate];
        timer = nil;
        [self.delegate countdownTimerStopView:self];
//         执行block回调
//        self.timerStopBlock();
    }
}

- (void)getDetailTimeWithTimestamp:(NSInteger)timestamp{
    NSInteger ms = timestamp;
    NSInteger ss = 1;
    NSInteger mi = ss * 60;
    NSInteger hh = mi * 60;
    NSInteger dd = hh * 24;
    NSInteger mm = dd * 30;
    NSInteger yy = dd * 365;
    // 剩余的
    NSInteger year = ms / yy;
    NSInteger month = ms / mm;
    NSInteger day = ms / dd;// 天
    NSInteger hour = (ms - day * dd) / hh;// 时
    NSInteger minute = (ms - day * dd - hour * hh) / mi;// 分
    NSInteger second = (ms - day * dd - hour * hh - minute * mi) / ss;// 秒
//    NSLog(@"%zd日:%zd时:%zd分:%zd秒",day,hour,minute,second);
    
    self.dayLabel.text = [NSString stringWithFormat:@"%zd天",day];
    self.hourLabel.text = [NSString stringWithFormat:@"%zd时",hour];
    self.minutesLabel.text = [NSString stringWithFormat:@"%zd分",minute];
    self.secondsLabel.text = [NSString stringWithFormat:@"%zd秒",second];
    self.yearLabel.text = [NSString stringWithFormat:@"%zd年",year];
    self.monthLabel.text = [NSString stringWithFormat:@"%zd月",month];
    
    // 年
    self.year_str = [NSString stringWithFormat:@"%.4zd",year];
    // 月
    self.month_str = [NSString stringWithFormat:@"%.2zd",month];
    // 日
    self.day_str = [NSString stringWithFormat:@"%.2zd",day];
    // 时
    self.hour_str = [NSString stringWithFormat:@"%.2zd",hour];
    // 分
    self.minutes_str = [NSString stringWithFormat:@"%.2zd",minute];
    // 秒
    self.seconds_str = [NSString stringWithFormat:@"%.2zd",second];
    
    [self.delegate countdownView:self hour:self.hour_str minutes:self.minutes_str seconds:self.seconds_str];
//    NSLog(@"%@,%@,%@",_hour_str,_minutes_str,_seconds_str);

}

- (void)layoutSubviews{
    [super layoutSubviews];
    // 获得view的宽、高
    CGFloat viewW = self.frame.size.width;
    CGFloat viewH = self.frame.size.height;
    // 单个label的宽高
    CGFloat labelW = viewW / labelCount;
    CGFloat labelH = viewH;
    self.dayLabel.frame = CGRectMake(0, 0, labelW, labelH);
    self.hourLabel.frame = CGRectMake(labelW, 0, labelW, labelH);
    self.minutesLabel.frame = CGRectMake(2 * labelW , 0, labelW, labelH);
    self.secondsLabel.frame = CGRectMake(3 * labelW, 0, labelW, labelH);
    
    for (NSInteger index = 0; index < self.separatorLabel_A.count ; index ++) {
        UILabel *separateLabel = self.separatorLabel_A[index];
        separateLabel.frame = CGRectMake((labelW - 1) * (index + 1), 0, 5, labelH);
    }
}

- (NSMutableArray *)timeLabel_A{
    if (_timeLabel_A == nil) {
        _timeLabel_A = [NSMutableArray new];
    }
    return _timeLabel_A;
}
- (NSMutableArray *)separatorLabel_A {
    if (_separatorLabel_A == nil) {
        _separatorLabel_A = [NSMutableArray new];
    }
    return _separatorLabel_A;
}
- (UILabel *)yearLabel {
    if (_yearLabel == nil) {
        _yearLabel = [[UILabel alloc] init];
        _yearLabel.textAlignment = NSTextAlignmentCenter;
//        _yearLabel.backgroundColor = [UIColor grayColor];
    }
    return _yearLabel;
}
- (UILabel *)monthLabel {
    if (_monthLabel == nil) {
        _monthLabel = [[UILabel alloc] init];
        _monthLabel.textAlignment = NSTextAlignmentCenter;
//        _monthLabel.backgroundColor = [UIColor grayColor];
    }
    return _monthLabel;
}
-(UILabel *)dayLabel {
    if (_dayLabel == nil) {
        _dayLabel = [[UILabel alloc] init];
        _dayLabel.textAlignment = NSTextAlignmentCenter;
//        _dayLabel.backgroundColor = [UIColor purpleColor];
    }
    return _dayLabel;
}
- (UILabel *)hourLabel {
    if (_hourLabel == nil) {
        _hourLabel = [[UILabel alloc]init];
        _hourLabel.textAlignment = NSTextAlignmentCenter;
//        _hourLabel.backgroundColor = [UIColor redColor];
    }
    return _hourLabel;
}
- (UILabel *)minutesLabel {
    if (_minutesLabel == nil) {
        _minutesLabel = [[UILabel alloc]init];
        _minutesLabel.textAlignment = NSTextAlignmentCenter;
//        _minutesLabel.backgroundColor = [UIColor orangeColor];
    }
    return _minutesLabel;
}
- (UILabel *)secondsLabel {
    if (_secondsLabel == nil) {
        _secondsLabel = [[UILabel alloc]init];
        _secondsLabel.textAlignment = NSTextAlignmentCenter;
//        _secondsLabel.backgroundColor = [UIColor yellowColor];
    }
    return _secondsLabel;
}

@end
