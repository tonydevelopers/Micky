//
//  MenuPopover.m
//  Menu
//
//  Created by fcx on 15/7/31.
//  Copyright (c) 2015年 fcx. All rights reserved.
//

#import "AlertBox.h"
#import "Gobal.h"
@implementation AlertBox
{
    UIView *menuView;
}
- (instancetype)initWithMenuFrame:(CGRect)frame title:(NSString*)str alertBoxClickBlock:(AlertBoxClickBlock)alertBoxClickBlock {

    if (self = [super initWithFrame:[UIScreen mainScreen].bounds]) {
        
        self.backgroundColor = [UIColor colorWithWhite:0 alpha:.5];
        
        self.alertBoxClickBlock = alertBoxClickBlock;
        menuView = [[UIView alloc] initWithFrame:frame];
        menuView.backgroundColor = [UIColor whiteColor];
        menuView.userInteractionEnabled = YES;
        menuView.layer.anchorPoint = CGPointMake(0.5, 0.5);
        menuView.frame = frame;
        menuView.layer.cornerRadius = 5;
        menuView.layer.masksToBounds = YES;
        [self addSubview:menuView];
        
        UILabel *label0 = [[UILabel alloc]init];
        label0.text = @"温馨提示";
        label0.frame = CGRectMake(5, 0, menuView.frame.size.width-10, 30);
        label0.backgroundColor = [UIColor clearColor];
//        label0.textColor = [UIColor colorWithRed:105/255.0f green:124/255.0f blue:214/255.0f alpha:1.0f];
        label0.textColor = [UIColor colorWithRed:50/255.0 green:50/255.0 blue:50/255.0 alpha:1.0];
        label0.font = [UIFont systemFontOfSize:15];
        label0.textAlignment = NSTextAlignmentCenter;
        label0.numberOfLines = 1;
        [menuView addSubview:label0];
        
        
        UIView *line = [[UIView alloc]init];
        line.frame = CGRectMake(0, 30, menuView.frame.size.width , 1);
        line.backgroundColor = [UIColor colorWithRed:220/255.0 green:220/255.0 blue:220/255.0 alpha:1.0];
        [menuView addSubview:line];
        
        
        UILabel *label1 = [[UILabel alloc]init];
        label1.text = str;
        label1.frame = CGRectMake(5, 35, menuView.frame.size.width-10, 60);
        label1.backgroundColor = [UIColor clearColor];
        label1.textColor = [UIColor colorWithRed:51/255.0f green:51/255.0f blue:51/255.0f alpha:1.0f];
        label1.font = [UIFont systemFontOfSize:15];
        label1.textAlignment = NSTextAlignmentCenter;
        label1.numberOfLines = 0;
        [menuView addSubview:label1];

        
        UIButton *topButton = [UIButton buttonWithType:UIButtonTypeCustom];
        topButton.frame = CGRectMake(0, 100, 110, 40);
        topButton.tag = 0;
        [topButton setTitle:@"取消" forState:UIControlStateNormal];
        [topButton setTitleColor:[UIColor colorWithRed:50/255.0 green:50/255.0 blue:50/255.0 alpha:1.0] forState:UIControlStateNormal];
        [topButton setBackgroundImage:[Gobal imageWithColor:[UIColor clearColor] size:topButton.frame.size] forState:UIControlStateNormal];
        [topButton setBackgroundImage:[Gobal imageWithColor:[UIColor colorWithRed:230/255.0 green:230/255.0 blue:230/255.0 alpha:1.0] size:topButton.frame.size] forState:UIControlStateHighlighted];
        [topButton addTarget:self action:@selector(buttonAction:) forControlEvents:UIControlEventTouchUpInside];
        [menuView addSubview:topButton];
        
        UIButton *bottomButton = [UIButton buttonWithType:UIButtonTypeCustom];
        bottomButton.frame = CGRectMake(110, 100, 110, 40);
        bottomButton.tag = 1;
        [bottomButton setTitle:@"确定" forState:UIControlStateNormal];
        [bottomButton setTitleColor:[UIColor colorWithRed:50/255.0 green:50/255.0 blue:50/255.0 alpha:1.0] forState:UIControlStateNormal];
        [bottomButton setBackgroundImage:[Gobal imageWithColor:[UIColor clearColor] size:bottomButton.frame.size] forState:UIControlStateNormal];
        [bottomButton setBackgroundImage:[Gobal imageWithColor:[UIColor colorWithRed:230/255.0 green:230/255.0 blue:230/255.0 alpha:1.0] size:bottomButton.frame.size] forState:UIControlStateHighlighted];
        [bottomButton addTarget:self action:@selector(buttonAction:) forControlEvents:UIControlEventTouchUpInside];
        [menuView addSubview:bottomButton];
        
        
        UIView *line_1 = [[UIView alloc]init];
        line_1.frame = CGRectMake(0, 100, menuView.frame.size.width , 0.8);
        line_1.backgroundColor = [UIColor colorWithRed:220/255.0 green:220/255.0 blue:220/255.0 alpha:1.0];
        [menuView addSubview:line_1];

        UIView *line_2 = [[UIView alloc]init];
        line_2.frame = CGRectMake(109.5, 100, 1 , 40);
        line_2.backgroundColor = [UIColor colorWithRed:220/255.0 green:220/255.0 blue:220/255.0 alpha:1.0];
        [menuView addSubview:line_2];
        

        UITapGestureRecognizer *tapGesgure = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(dismiss)];
        [self addGestureRecognizer:tapGesgure];
        
    }
    return self;
}
- (void)buttonAction:(UIButton *)button {
    
    [self dismiss];
    if (self.alertBoxClickBlock) {
        self.alertBoxClickBlock(button.tag);
    }
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
