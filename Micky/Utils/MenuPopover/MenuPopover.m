//
//  MenuPopover.m
//  Menu
//
//  Created by fcx on 15/7/31.
//  Copyright (c) 2015年 fcx. All rights reserved.
//

#import "MenuPopover.h"

@implementation MenuPopover
{
    UIView *menuView;
}
- (instancetype)initWithMenuFrame:(CGRect)frame menuClickBlock:(MenuClickBlock)menuClickBlock {
    
    if (self = [super initWithFrame:[UIScreen mainScreen].bounds]) {
        
        self.backgroundColor = [UIColor colorWithWhite:0 alpha:.5];
        
        self.menuClickBlock = menuClickBlock;
        menuView = [[UIView alloc] initWithFrame:frame];
        menuView.backgroundColor = [UIColor whiteColor];
        menuView.userInteractionEnabled = YES;
        menuView.layer.anchorPoint = CGPointMake(0, 0);
        menuView.frame = frame;
        menuView.layer.cornerRadius = 5;
        menuView.layer.masksToBounds = YES;
        [self addSubview:menuView];
        
        UIButton *topButton = [UIButton buttonWithType:UIButtonTypeCustom];
        topButton.frame = CGRectMake(0, 8.5, frame.size.width, 43.5);
        topButton.tag = 0;
        topButton.backgroundColor = [UIColor clearColor];
        [topButton setTitle:@"中国港澳" forState:UIControlStateNormal];
        topButton.titleLabel.font = [UIFont systemFontOfSize:15];
        [topButton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        [topButton addTarget:self action:@selector(buttonAction:) forControlEvents:UIControlEventTouchUpInside];
        [menuView addSubview:topButton];
        
        UIButton *bottomButton = [UIButton buttonWithType:UIButtonTypeCustom];
        bottomButton.frame = CGRectMake(0, 8.5 + 43.5, frame.size.width, 43.5);
        bottomButton.tag = 1;
        bottomButton.backgroundColor = [UIColor clearColor];
        [bottomButton setTitle:@"臺灣地區" forState:UIControlStateNormal];
        bottomButton.titleLabel.font = [UIFont systemFontOfSize:15];
        [bottomButton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        [bottomButton addTarget:self action:@selector(buttonAction:) forControlEvents:UIControlEventTouchUpInside];
        [menuView addSubview:bottomButton];
        
        UITapGestureRecognizer *tapGesgure = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(dismiss)];
        [self addGestureRecognizer:tapGesgure];
        
    }
    return self;
}
- (void)buttonAction:(UIButton *)button {
    
    [self dismiss];
    if (self.menuClickBlock) {
        self.menuClickBlock(button.tag);
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
