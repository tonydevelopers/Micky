//
//  MSIntroductionPage.m
//  MickyEasyCredit
//
//  Created by 张宁 on 2017/5/24.
//  Copyright © 2017年 apple. All rights reserved.
//

#import "MSIntroductionPage.h"
@implementation MSIntroductionLabelStyle
@synthesize font = _font;
@synthesize text = _text;
@synthesize textColor = _textColor;
@synthesize linesNumber = _linesNumber;
@synthesize offset = _offset;

// Init.
- (id)initWithText:(NSString *)text
{
    self = [super init];
    if (self){
        _text = text;
    }
    return self;
}

- (id)initWithText:(NSString *)text
              font:(UIFont *)font
         textColor:(UIColor *)color
{
    self = [self initWithText:text];
    if (self){
        _font = font;
        _textColor = color;
    }
    return self;
}

@end

@implementation MSIntroductionPage
@synthesize subTitle = _subTitle;
@synthesize description = _description;
@synthesize pictureName = _pictureName;

// Init.
- (id)initWithSubTitle:(NSString *)subTitle
           description:(NSString *)description
           pictureName:(NSString *)pictureName{
    self = [super init];
    if (self){
        _subTitle = [[MSIntroductionLabelStyle alloc] initWithText:subTitle];
        _description = [[MSIntroductionLabelStyle alloc] initWithText:description];
        _pictureName = pictureName;
    }
    return self;
}

- (void)setSubTitleStyle:(MSIntroductionLabelStyle *)style{
    [_subTitle setFont:style.font];
    [_subTitle setTextColor:style.textColor];
}

- (void)setDescription:(MSIntroductionLabelStyle *)style{
    [_description setFont:style.font];
    [_description setTextColor:style.textColor];
}

@end
