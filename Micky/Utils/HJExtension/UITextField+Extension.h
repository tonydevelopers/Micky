//
//  UITextField+Extension.h
//  youzhuan
//
//  Created by dev002 on 10/3/16.
//  Copyright © 2016年 dev001. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UITextField (Extension)

//UITextField *textField = [[UITextField alloc]initWithFrame:CGRectMake(0, 0, 0, 0)];
//textField.placeholder = @"请输入支付宝账号";
//textField.borderStyle = UITextBorderStyleNone;
//    textField.font
//    textField.clearButtonMode
//    textField.textAlignment

+(UITextField *)createTextFieldWithFont:(UIFont *)font placeholder:(NSString *)placeholder borderStyle:(UITextBorderStyle)borderStyle clearButtonMode:(UITextFieldViewMode)clearButtonMode;

@end
