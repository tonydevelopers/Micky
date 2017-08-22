//
//  UIBarButtonItem+Extension.m
//  youzhuan
//
//  Created by dev002 on 4/3/16.
//  Copyright © 2016年 dev001. All rights reserved.
//

#import "UIBarButtonItem+Extension.h"
#import "UIButton+Extension.h"
@implementation UIBarButtonItem (Extension)

+(UIBarButtonItem *)createBarButtonItemWithTitle:(NSString *)title font:(UIFont *)font image:(UIImage *)image
{
    UIButton *btn = [UIButton createBtnWithTitle:title font:font image:image];
//    [btn setBackgroundColor:[UIColor whiteColor]];
    UIBarButtonItem *btnItem = [[UIBarButtonItem alloc]initWithCustomView:btn];
    return btnItem;
}

-(void)setBarButtonItemTitle:(NSString *)title
{
    UIButton *selfBtn = [self customView];
    [selfBtn setBtnTitle:title];
}

-(void)addBarButtonItemTarget:(id)target action:(SEL)action
{
    UIButton *selfBtn = [self customView];
    [selfBtn btnAddTarget:target action:action];
}

-(void)setBarButtonItemTitleColor:(UIColor *)color imageEdgeInsets:(UIEdgeInsets)edgeInset frame:(CGRect)frame
{
    UIButton *selfBtn = [self customView];
    [selfBtn setBtnTitleColor:color];
    [selfBtn setBtnImageEdgeInsets:edgeInset];
    [selfBtn setBtnFrame:frame];
}

-(void)setBarButtonItemTitleColor:(UIColor*)color frame:(CGRect)frame
{
    UIButton *selfBtn = [self customView];
    [selfBtn setBtnTitleColor:color];
//    [selfBtn setBackgroundColor:[UIColor orangeColor]];
    [selfBtn setBtnFrame:frame];
}

-(NSString *)barButtonItemTitle
{
    UIButton *selfBtn = [self customView];
    return selfBtn.titleLabel.text;
}

-(void)setBarButtonItemImage:(UIImage *)image
{
    UIButton *selfBtn = [self customView];
    [selfBtn setBtnImage:image];
}

-(UIImage *)barButtonItemImage
{
    UIButton *selfBtn = [self customView];
    return selfBtn.imageView.image;
}

@end
