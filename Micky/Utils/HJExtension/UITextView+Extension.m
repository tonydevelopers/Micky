//
//  UITextView+Extension.m
//  youzhuan
//
//  Created by dev001 on 1/3/16.
//  Copyright © 2016年 dev001. All rights reserved.
//
#define FONT [UIFont systemFontOfSize:14]

#import "UITextView+Extension.h"

@implementation UITextView (Extension)

+(UITextView *)createTextView
{
    UITextView *textView = [[UITextView alloc]init];
    
    textView.scrollEnabled = YES;
    textView.font = FONT;
    return textView;
}

@end
