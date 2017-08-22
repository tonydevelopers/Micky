//
//  UIButton+Extension.m
//  youzhuan
//
//  Created by dev001 on 1/3/16.
//  Copyright © 2016年 dev001. All rights reserved.
//

#import "UIButton+Extension.h"

@implementation UIButton (Extension)

+(UIButton *)createBtnWithTitle:(NSString *)title font:(UIFont *)font image:(UIImage *)image
{
    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    [button setImage:image forState:UIControlStateNormal];
    [button setTitle:title forState:UIControlStateNormal];
    [button setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    button.titleLabel.font = font;
    return button;
}

+(UIButton *)createBtnWithTitle:(NSString *)title font:(UIFont *)font image:(UIImage *)image buttonType:(UIButtonType)buttonType
{
    UIButton *button = [UIButton buttonWithType:buttonType];
    [button setImage:image forState:UIControlStateNormal];
    [button setTitle:title forState:UIControlStateNormal];
    [button setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    button.titleLabel.font = font;
    return button;
}


-(void)setBtnTitle:(NSString *)title
{
    [self setTitle:title forState:UIControlStateNormal];
}

-(void)setBtnTitleColor:(UIColor *)color
{
    [self setTitleColor:color forState:UIControlStateNormal];
}

-(void)setBtnBackGroundColor:(UIColor *)color
{
    [self setBackgroundColor:color];
}

-(void)setBtnFrame:(CGRect)frame
{
    [self setFrame:frame];
}

-(void)setBtnImageEdgeInsets:(UIEdgeInsets)imageEdgeInsets
{
    [self setImageEdgeInsets:imageEdgeInsets];
}

-(void)btnAddTarget:(id)target action:(SEL)action
{
    [self addTarget:target action:action forControlEvents:UIControlEventTouchUpInside];
}

-(void)setBtnImage:(UIImage *)image
{
    [self setImage:image forState:UIControlStateNormal];
}

@end
