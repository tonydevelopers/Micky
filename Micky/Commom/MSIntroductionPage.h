//
//  MSIntroductionPage.h
//  MickyEasyCredit
//
//  Created by 张宁 on 2017/5/24.
//  Copyright © 2017年 apple. All rights reserved.
//
#import <UIKit/UIKit.h>
#import <Foundation/Foundation.h>

@interface MSIntroductionLabelStyle : NSObject {
    NSString *_text;
    UIFont *_font;
    UIColor *_textColor;
    NSUInteger _linesNumber;
    NSUInteger _offset;
}

@property (nonatomic, retain) NSString *text;
@property (nonatomic, retain) UIFont *font;
@property (nonatomic, retain) UIColor *textColor;
@property (nonatomic, assign) NSUInteger linesNumber;
@property (nonatomic, assign) NSUInteger offset;

// Init.
- (id)initWithText:(NSString *)text;
- (id)initWithText:(NSString *)text
              font:(UIFont *)font
         textColor:(UIColor *)color;
@end

@interface MSIntroductionPage : NSObject {
    MSIntroductionLabelStyle *_subTitle;
    MSIntroductionLabelStyle *_description;
    NSString *_pictureName;
}

@property (nonatomic, retain) MSIntroductionLabelStyle *subTitle;
@property (nonatomic, retain) MSIntroductionLabelStyle *description;
@property (nonatomic, retain) NSString *pictureName;

// Init.
- (id)initWithSubTitle:(NSString *)subTitle
           description:(NSString *)description
           pictureName:(NSString *)pictureName;

- (void)setSubTitleStyle:(MSIntroductionLabelStyle *)style;
- (void)setDescription:(MSIntroductionLabelStyle *)style;
@end
