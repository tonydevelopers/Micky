//
//  UITextField+Extension.m
//  youzhuan
//
//  Created by dev002 on 10/3/16.
//  Copyright © 2016年 dev001. All rights reserved.
//

#import "UITextField+Extension.h"

@implementation UITextField (Extension)

+(UITextField *)createTextFieldWithFont:(UIFont *)font placeholder:(NSString *)placeholder borderStyle:(UITextBorderStyle)borderStyle clearButtonMode:(UITextFieldViewMode)clearButtonMode
{
    UITextField *textField = [[UITextField alloc]initWithFrame:CGRectMake(0, 0, 0, 0)];
    textField.placeholder = placeholder;
    textField.borderStyle = borderStyle;
    textField.font = font;
    textField.clearButtonMode = clearButtonMode;
    textField.textAlignment = NSTextAlignmentCenter;
    
    return textField;
}

@end
