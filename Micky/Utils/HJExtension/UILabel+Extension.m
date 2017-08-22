//
//  UILabel+Extension.m
//  ChatVDemo
//
//  Created by 胡健华 on 16/2/29.
//  Copyright (c) 2016年 Ithran. All rights reserved.
//

#import "UILabel+Extension.h"

@implementation UILabel (Extension)

+(UILabel *)createLabelWithFont:(UIFont *)font textColor:(UIColor *)color isNumberOfLine:(BOOL)isNumberOfLine
{
    UILabel *label = [[UILabel alloc]init];
    label.font = font;
    label.textColor = color;
    label.numberOfLines = !isNumberOfLine;
    label.textAlignment = NSTextAlignmentCenter;
    [label sizeToFit];
    return label;
}

//    UILabel *label = [[UILabel alloc] initWithFrame:CGRectZero];
//    label.backgroundColor = [UIColor clearColor];
//    label.font = [UIFont systemFontOfSize:20.0];
//    label.textAlignment = NSTextAlignmentCenter;
//    label.textColor = [UIColor blackColor]; // change this color
//    label.text = naviTitle;
//    [label sizeToFit];
+(UILabel *)createLabelWithText:(NSString *)text Font:(UIFont *)font textColor:(UIColor *)color backgroundColor:(UIColor *)backgroundColor
{
    UILabel *label = [[UILabel alloc]init];
    label.backgroundColor = backgroundColor;
    label.font = font;
    label.textAlignment = NSTextAlignmentCenter;
    label.textColor = color;
    label.text = text;
    [label sizeToFit];
    return label;
}
@end
