//
//  UIButton+Extension.h
//  youzhuan
//
//  Created by dev001 on 1/3/16.
//  Copyright © 2016年 dev001. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIButton (Extension)

+(UIButton *)createBtnWithTitle:(NSString *)title font:(UIFont*)font image:(UIImage *)image;

+(UIButton *)createBtnWithTitle:(NSString *)title font:(UIFont *)font image:(UIImage *)image buttonType:(UIButtonType)buttonType;

-(void)setBtnTitleColor:(UIColor *)color;

-(void)setBtnBackGroundColor:(UIColor *)color;

-(void)setBtnTitle:(NSString *)title;

-(void)setBtnImageEdgeInsets:(UIEdgeInsets)imageEdgeInsets;

-(void)setBtnFrame:(CGRect)frame;

-(void)btnAddTarget:(id)target action:(SEL)action;

-(void)setBtnImage:(UIImage *)image;

@end
