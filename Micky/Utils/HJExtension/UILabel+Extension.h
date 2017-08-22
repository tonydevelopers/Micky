//
//  UILabel+Extension.h
//  ChatVDemo
//
//  Created by 胡健华 on 16/2/29.
//  Copyright (c) 2016年 Ithran. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UILabel (Extension)

+(UILabel *)createLabelWithFont:(UIFont *)font textColor:(UIColor *)color isNumberOfLine:(BOOL)isNumberOfLine;


//    UILabel *label = [[UILabel alloc] initWithFrame:CGRectZero];
//    label.backgroundColor = [UIColor clearColor];
//    label.font = [UIFont systemFontOfSize:20.0];
//    label.textColor = [UIColor blackColor]; // change this color
//    label.text = naviTitle;
+(UILabel *)createLabelWithText:(NSString *)text Font:(UIFont *)font textColor:(UIColor *)color backgroundColor:(UIColor *)backgroundColor;
@end
