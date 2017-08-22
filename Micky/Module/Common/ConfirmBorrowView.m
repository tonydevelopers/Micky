//
//  ConfirmBorrowView.m
//  MickyEasyCredit
//
//  Created by 张宁 on 2017/4/10.
//  Copyright © 2017年 apple. All rights reserved.
//

#import "ConfirmBorrowView.h"
#import "AppDelegate.h"

#define  width  [UIScreen mainScreen].bounds.size.width
#define  height [UIScreen mainScreen].bounds.size.height

@interface ConfirmBorrowView()
{
    UIView *w_line;
    UIView *h_line;
    UILabel *left_label;
}
@end

@implementation ConfirmBorrowView
@synthesize show_view;
@synthesize text_label;
@synthesize confirm_Btn;
@synthesize cancle_Btn;
@synthesize jk_label;
@synthesize qx_label;
@synthesize fy_label;
@synthesize je_label;

- (instancetype)initWithBorrow:(NSString *)b_price timeLimit:(NSString *)t_limit serviceFee:(NSString *)s_fee repaymentAmount:(NSString *)r_amount {
    self = [super init];
    if (self) {
        
        self.backgroundColor = [UIColor colorWithWhite:0 alpha:0.5];
        self.frame = CGRectMake(0, 0, width, height);
        self.hidden = YES;
        self.alpha = 0;
        
        show_view = [[UIView alloc]init];
        show_view.backgroundColor = [UIColor whiteColor];
        show_view.frame = CGRectMake((width-240)/2.0, 1000+(height-300)/2.0-30, 240, 280);
        show_view.layer.cornerRadius = 5;
        show_view.layer.masksToBounds = YES;
        [self addSubview:show_view];
        
        text_label = [[UILabel alloc]init];
        text_label.backgroundColor = BUTTON_COLOR_NORMA;
        text_label.frame = CGRectMake(0, 0, CGRectGetWidth(show_view.frame), 35);
        text_label.text = @"确认借款";
        text_label.textAlignment = NSTextAlignmentCenter;
        text_label.font = [UIFont systemFontOfSize:15];
        text_label.textColor = [UIColor whiteColor];
        [show_view addSubview:text_label];

        CGFloat  line_width = CGRectGetWidth(show_view.frame)-30;
        CGFloat line_height = 181;
        NSArray *arr = @[@"借款金额(元)",@"借款期限(天)",@"服务费用(元)",@"应还金额(元)"];
        
        for (int i = 0; i<5; i++) {
            w_line = [Gobal drawSolidLinePointX:15 PointY:CGRectGetMaxY(text_label.frame)+10+45*i lineW:line_width lineH:1 lineColor:@[@"220",@"220",@"220"] lineAlpha:1.0];
            [show_view addSubview:w_line];
            
            if (i<4) {
                left_label = [[UILabel alloc]init];
                left_label.backgroundColor = [UIColor clearColor];
                left_label.frame = CGRectMake(15, CGRectGetMaxY(text_label.frame)+10+45*i, line_width/2.0, 45);
                left_label.text = arr[i];
                left_label.textAlignment = NSTextAlignmentCenter;
                left_label.font = [UIFont systemFontOfSize:13];
                left_label.textColor = TITLE_FONT_COLOR;
                [show_view addSubview:left_label];
            }
        }
        for (int i = 0; i<3; i++) {
            h_line = [Gobal drawSolidLinePointX:15+(i*line_width/2.0) PointY:CGRectGetMaxY(text_label.frame)+10 lineW:1 lineH:line_height lineColor:@[@"220",@"220",@"220"] lineAlpha:1.0];
            [show_view addSubview:h_line];
        }
        
        
        jk_label = [[UILabel alloc]init];
        jk_label.frame = CGRectMake(16+line_width/2.0, CGRectGetMaxY(text_label.frame)+10+45*0, line_width/2.0, 45);
        jk_label.text = [NSString stringWithFormat:@"%@元",[Gobal isEmptyString:b_price]?@"--":b_price];
        jk_label.textAlignment = NSTextAlignmentCenter;
        jk_label.font = [UIFont systemFontOfSize:13];
        jk_label.textColor = TITLE_FONT_COLOR;
        [show_view addSubview:jk_label];
        
        qx_label = [[UILabel alloc]init];
        qx_label.frame = CGRectMake(16+line_width/2.0, CGRectGetMaxY(text_label.frame)+10+45*1, line_width/2.0, 45);
        qx_label.text = [NSString stringWithFormat:@"%@天",[Gobal isEmptyString:t_limit]?@"--":t_limit];
        qx_label.textAlignment = NSTextAlignmentCenter;
        qx_label.font = [UIFont systemFontOfSize:13];
        qx_label.textColor = TITLE_FONT_COLOR;
        [show_view addSubview:qx_label];
        
        fy_label = [[UILabel alloc]init];
        fy_label.frame = CGRectMake(16+line_width/2.0, CGRectGetMaxY(text_label.frame)+10+45*2, line_width/2.0, 45);
        fy_label.text = [NSString stringWithFormat:@"%@元",[Gobal isEmptyString:s_fee]?@"--":s_fee];
        fy_label.textAlignment = NSTextAlignmentCenter;
        fy_label.font = [UIFont systemFontOfSize:13];
        fy_label.textColor = TITLE_FONT_COLOR;
        [show_view addSubview:fy_label];
        
        je_label = [[UILabel alloc]init];
        je_label.frame = CGRectMake(16+line_width/2.0, CGRectGetMaxY(text_label.frame)+10+45*3, line_width/2.0, 45);
        je_label.text = [NSString stringWithFormat:@"%@元",[Gobal isEmptyString:r_amount]?@"--":r_amount];
        je_label.textAlignment = NSTextAlignmentCenter;
        je_label.font = [UIFont systemFontOfSize:13];
        je_label.textColor = TITLE_FONT_COLOR;
        [show_view addSubview:je_label];
        
        
    
        confirm_Btn = [UIButton buttonWithType:UIButtonTypeCustom];
        confirm_Btn.frame = CGRectMake(CGRectGetWidth(show_view.frame)-90, CGRectGetHeight(show_view.frame)-45, 75, 30);
        [confirm_Btn setTitle:@"确认" forState:UIControlStateNormal];
        [confirm_Btn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        [confirm_Btn setBackgroundImage:[Gobal imageWithColor:BUTTON_COLOR_NORMA size:confirm_Btn.frame.size] forState:UIControlStateNormal];
        [confirm_Btn setBackgroundImage:[Gobal imageWithColor:BUTTON_COLOR_HIGHT size:confirm_Btn.frame.size] forState:UIControlStateHighlighted];
        [confirm_Btn addTarget:self action:@selector(confirmBtnAction) forControlEvents:UIControlEventTouchUpInside];
        confirm_Btn.titleLabel.font = [UIFont systemFontOfSize:15];
        confirm_Btn.layer.cornerRadius = 5;
        confirm_Btn.layer.masksToBounds = YES;
        [show_view addSubview:confirm_Btn];

        cancle_Btn = [UIButton buttonWithType:UIButtonTypeCustom];
        cancle_Btn.frame = CGRectMake(15, CGRectGetHeight(show_view.frame)-45, 75, 30);
        [cancle_Btn setTitle:@"取消" forState:UIControlStateNormal];
        [cancle_Btn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        [cancle_Btn setBackgroundImage:[Gobal imageWithColor:BUTTON_COLOR_NORMA size:cancle_Btn.frame.size] forState:UIControlStateNormal];
        [cancle_Btn setBackgroundImage:[Gobal imageWithColor:BUTTON_COLOR_HIGHT size:cancle_Btn.frame.size] forState:UIControlStateHighlighted];
        [cancle_Btn addTarget:self action:@selector(cancleBtnAction) forControlEvents:UIControlEventTouchUpInside];
        cancle_Btn.titleLabel.font = [UIFont systemFontOfSize:15];
        cancle_Btn.layer.cornerRadius = 5;
        cancle_Btn.layer.masksToBounds = YES;
        [show_view addSubview:cancle_Btn];
        
    }
    return self;
}
- (void)confirmBtnAction {
    
    if ( [self.delegate respondsToSelector:@selector(confirmBorrow)]) {
        [self.delegate confirmBorrow];
    }
}
- (void)cancleBtnAction {
    [self dismiss];
}
- (void)show {
    __block ConfirmBorrowView *weakSelf = self;
    [UIView animateWithDuration:0.8 animations:^{
        
        self.hidden = NO;
        self.alpha = 1;
        show_view.frame = CGRectMake((width-240)/2.0, (height-300)/2.0-30, 240, 280);
        [[AppDelegate getInstance].window addSubview:weakSelf];
        
    } completion:^(BOOL finished) {
        
    }];
}
- (void)dismiss {

    __block ConfirmBorrowView *weakSelf = self;
    [UIView animateWithDuration:0.8 animations:^{
        
        self.alpha = 0;
        show_view.frame = CGRectMake((width-240)/2.0, 1000+(height-300)/2.0-30, 240, 280);
        [[AppDelegate getInstance].window addSubview:weakSelf];
        
    } completion:^(BOOL finished) {
        self.hidden = YES;
        [weakSelf removeFromSuperview];
    }];
}






@end
