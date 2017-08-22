//
//  PasswordView.m
//  MickyEasyCredit
//
//  Created by 张宁 on 2016/12/24.
//  Copyright © 2016年 apple. All rights reserved.
//

#import "PasswordView.h"
#import "Gobal.h"
#import "CustomHUD.h"
@implementation PasswordView
{
    UIView *menuView;
    UILabel *title_label;
    UITextField *field;
}
- (instancetype)initWithMenuFrame:(CGRect)frame menuClickBlock:(PasswordClickBlock)menuClickBlock {
    
    if (self = [super initWithFrame:[UIScreen mainScreen].bounds]) {
        
        self.backgroundColor = [UIColor colorWithWhite:0 alpha:.5];
        self.menuClickBlock = menuClickBlock;
        menuView = [[UIView alloc] initWithFrame:frame];
        menuView.backgroundColor = [UIColor whiteColor];
        menuView.userInteractionEnabled = YES;
        menuView.layer.anchorPoint = CGPointMake(0.5, 0.5);
        menuView.frame = frame;
        menuView.layer.cornerRadius = 5;
        menuView.layer.masksToBounds = YES;
        [self addSubview:menuView];
        
        UIView *show = [[UIView alloc]init];
        show.frame = CGRectMake(0, 0, CGRectGetWidth(menuView.frame), 45);
        show.backgroundColor = RGBAColor(239,194,188,1.0);
        [menuView addSubview:show];
        
        title_label = [[UILabel alloc]init];
        title_label.frame = CGRectMake(0, 0, CGRectGetWidth(menuView.frame), 35);
        title_label.backgroundColor = [UIColor clearColor];
        title_label.text = @"绿界科技OTP码";
        title_label.font = [UIFont systemFontOfSize:18];
        title_label.textAlignment = NSTextAlignmentCenter;
        title_label.textColor = [UIColor whiteColor];
        [show addSubview:title_label];
        
        UILabel *l = [[UILabel alloc]init];
        l.frame = CGRectMake(0, 25, CGRectGetWidth(menuView.frame), 20);
        l.backgroundColor = [UIColor clearColor];
        l.text = @"*请稍等绿界科技正在为您配送OTP码";
        l.font = [UIFont systemFontOfSize:10];
        l.textAlignment = NSTextAlignmentCenter;
        l.textColor = [UIColor redColor];
        [show addSubview:l];

    
        field = [[UITextField alloc]init];
        field.frame = CGRectMake(10, CGRectGetMaxY(title_label.frame)+22.5, CGRectGetWidth(menuView.frame)-20, 35);
        field.backgroundColor = [UIColor clearColor];
        field.textColor = TITLE_FONT_COLOR;
        field.layer.borderWidth = 1;
        field.layer.cornerRadius = 5;
        field.layer.masksToBounds = YES;
        field.layer.borderColor = TITLE_FONT_COLOR.CGColor;
        field.textAlignment = NSTextAlignmentCenter;
        field.keyboardType = UIKeyboardTypeNumberPad;
        field.clearButtonMode = UITextFieldViewModeAlways;
        field.placeholder = @"请输入OTP码";
        [menuView addSubview:field];

        [menuView addSubview:[Gobal drawSolidLinePointX:0 PointY:CGRectGetMaxY(field.frame)+12.5 lineW:CGRectGetWidth(menuView.frame) lineH:1 lineColor:@[@"146",@"146",@"146"] lineAlpha:1.0]];

        [menuView addSubview:[Gobal drawSolidLinePointX:CGRectGetWidth(menuView.frame)/2.0-1 PointY:CGRectGetMaxY(field.frame)+12.5 lineW:1 lineH:CGRectGetHeight(menuView.frame)-CGRectGetMaxY(field.frame)-12.5 lineColor:@[@"146",@"146",@"146"] lineAlpha:1.0]];

        UIButton *leftButton = [UIButton buttonWithType:UIButtonTypeCustom];
        leftButton.frame = CGRectMake(0, CGRectGetMaxY(field.frame)+13.5, CGRectGetWidth(menuView.frame)/2.0-1, CGRectGetHeight(menuView.frame)-CGRectGetMaxY(field.frame)-13.5);
        leftButton.tag = 1;
        [leftButton setTitle:@"取消" forState:UIControlStateNormal];
        [leftButton setTitleColor:RGBAColor(252.0,128.0,162.0,1.0) forState:UIControlStateNormal];
        [leftButton setTitleColor:[UIColor whiteColor] forState:UIControlStateHighlighted];
        [leftButton setBackgroundImage:[Gobal imageWithColor:[UIColor whiteColor] size:leftButton.frame.size] forState:UIControlStateNormal];
        [leftButton setBackgroundImage:[Gobal imageWithColor:RGBAColor(239,194,188,1.0) size:leftButton.frame.size] forState:UIControlStateHighlighted];
        [leftButton addTarget:self action:@selector(dismiss) forControlEvents:UIControlEventTouchUpInside];
        [menuView addSubview:leftButton];
        
        UIButton *bottomButton = [UIButton buttonWithType:UIButtonTypeCustom];
        bottomButton.frame = CGRectMake(CGRectGetWidth(menuView.frame)/2.0, CGRectGetMaxY(field.frame)+13.5, CGRectGetWidth(menuView.frame)/2.0, CGRectGetHeight(menuView.frame)-CGRectGetMaxY(field.frame)-13.5);
        bottomButton.tag = 1;
        [bottomButton setTitle:@"确认" forState:UIControlStateNormal];
        [bottomButton setTitleColor:RGBAColor(252.0,128.0,162.0,1.0) forState:UIControlStateNormal];
        [bottomButton setTitleColor:[UIColor whiteColor] forState:UIControlStateHighlighted];
        [bottomButton setBackgroundImage:[Gobal imageWithColor:[UIColor whiteColor] size:bottomButton.frame.size] forState:UIControlStateNormal];
        [bottomButton setBackgroundImage:[Gobal imageWithColor:RGBAColor(239,194,188,1.0) size:bottomButton.frame.size] forState:UIControlStateHighlighted];
        [bottomButton addTarget:self action:@selector(buttonAction:) forControlEvents:UIControlEventTouchUpInside];
        [menuView addSubview:bottomButton];
        
        UITapGestureRecognizer *tapGesgure = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(dismiss)];
        [self addGestureRecognizer:tapGesgure];
        
    }
    return self;
}
- (void)buttonAction:(UIButton *)button {
    [field resignFirstResponder];
    if (self.menuClickBlock) {
        self.menuClickBlock(field.text);
    }
    [self dismiss];
}
- (void)show {
    UIWindow* window = [UIApplication sharedApplication].keyWindow;
    [window addSubview:self];
    __weak UIView *weakView = menuView;
    menuView.transform = CGAffineTransformMakeScale(0.1f, 0.1f);
    [UIView animateWithDuration:.15 delay:0 options:UIViewAnimationOptionCurveEaseInOut animations:^{
        
        weakView.transform = CGAffineTransformIdentity;
        
    } completion:^(BOOL finished) {
    }];
}
- (void)dismiss {
    __weak __typeof(self)weakSelf = self;
    __weak UIView *weakView = menuView;
    
    [UIView animateWithDuration:.15 animations:^{
        
        weakView.transform = CGAffineTransformMakeScale(0.1f, 0.1f);
        
    } completion:^(BOOL finished) {
        [weakSelf removeFromSuperview];
    }];
}

@end
