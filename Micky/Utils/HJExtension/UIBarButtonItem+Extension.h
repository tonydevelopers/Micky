//
//  UIBarButtonItem+Extension.h
//  youzhuan
//
//  Created by dev002 on 4/3/16.
//  Copyright © 2016年 dev001. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIBarButtonItem (Extension)
+(UIBarButtonItem *)createBarButtonItemWithTitle:(NSString *)title font:(UIFont*)font image:(UIImage *)image;

-(void)setBarButtonItemTitle:(NSString *)title;

-(void)setBarButtonItemTitleColor:(UIColor*)color imageEdgeInsets:(UIEdgeInsets)edgeInset frame:(CGRect)frame;


-(void)setBarButtonItemTitleColor:(UIColor*)color frame:(CGRect)frame;


-(void)addBarButtonItemTarget:(id)target action:(SEL)action;

-(NSString *)barButtonItemTitle;

-(void)setBarButtonItemImage:(UIImage *)image;

-(UIImage *)barButtonItemImage;

@end
