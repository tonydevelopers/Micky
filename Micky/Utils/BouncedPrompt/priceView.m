//
//  priceView.m
//  MickyEasyCredit
//
//  Created by 张宁 on 2017/3/27.
//  Copyright © 2017年 apple. All rights reserved.
//

#import "priceView.h"

@implementation priceView
@synthesize real_pay;
@synthesize original_price;


- (instancetype)initWithFrame:(CGRect)frame MoneyMark:(NSString *)mark realPay:(NSString *)R_money originalPrice:(NSString *)O_money {
    self = [super initWithFrame:frame];
    if (self) {
        CGFloat width = frame.size.width;
        CGFloat height = frame.size.height;
        CGFloat R;
        if (width>height) {
            R = width;
        }else{
            R = height;
        }
        self.backgroundColor = [UIColor redColor];
        self.layer.cornerRadius = R/2.0;
        self.clipsToBounds = YES;
        
        real_pay = [[UILabel alloc]init];
        real_pay.frame = CGRectMake(0, 10, R, 15);
        real_pay.backgroundColor = [UIColor clearColor];
        real_pay.text = [NSString stringWithFormat:@"%@%@",mark,R_money];
        real_pay.textColor = [UIColor whiteColor];
        real_pay.font = [UIFont systemFontOfSize:14];
        real_pay.textAlignment = NSTextAlignmentCenter;
        [self addSubview:real_pay];

        original_price = [[UILabel alloc]init];
        original_price.frame = CGRectMake(0, CGRectGetMaxY(real_pay.frame), R, 15);
        original_price.backgroundColor = [UIColor clearColor];
        original_price.textColor = [UIColor whiteColor];
        original_price.font = [UIFont systemFontOfSize:12];
        original_price.textAlignment = NSTextAlignmentCenter;
        [self addSubview:original_price];
        
        NSString *price_str = [NSString stringWithFormat:@"%@%@",mark,O_money];
        NSMutableAttributedString *str = [[NSMutableAttributedString alloc]initWithString:price_str];
        [str addAttribute:NSStrikethroughStyleAttributeName value:[NSNumber numberWithInteger:NSUnderlineStyleSingle] range:NSMakeRange(0, [price_str length])];
        original_price.attributedText = str;
        
    }
    return self;
}

@end
