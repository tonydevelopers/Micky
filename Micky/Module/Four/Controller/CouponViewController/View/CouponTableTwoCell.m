//
//  CouponTableTwoCell.m
//  MickyEasyCredit
//
//  Created by 张宁 on 2017/5/11.
//  Copyright © 2017年 apple. All rights reserved.
//

#import "CouponTableTwoCell.h"
#import "AppDelegate.h"
#import "CouponModel.h"
@implementation CouponTableTwoCell

@synthesize BGView;
@synthesize leftView;
@synthesize right_imgV;
@synthesize label_1;
@synthesize label_2;
@synthesize label_3;
@synthesize label_4;
@synthesize label_5;

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        
        self.backgroundColor = BACKGROUND_COLOR;
        
        BGView = [[UIView alloc]init];
        BGView.frame = CGRectMake(10, 0, SCREEN_WIDTH-20, 80);
        BGView.backgroundColor = [UIColor whiteColor];
        BGView.layer.cornerRadius = 5;
        BGView.layer.masksToBounds = YES;
        [self.contentView addSubview:BGView];
        
        leftView = [[UIView alloc]init];
        leftView.frame = CGRectMake(0, 0, 80, 80);
        leftView.backgroundColor = RGBColor(220, 220, 220);
        [BGView addSubview:leftView];
        
        label_1 = [[UILabel alloc]init];
        label_1.text = @"免息";
        label_1.font = [UIFont boldSystemFontOfSize:30];
        label_1.textColor = [UIColor whiteColor];
        label_1.textAlignment = NSTextAlignmentCenter;
        label_1.backgroundColor = [UIColor clearColor];
        label_1.frame = CGRectMake(0, 0, 80, 50);
        [leftView addSubview:label_1];
        
        label_2 = [[UILabel alloc]init];
        label_2.text = @"优惠券";
        label_2.font = [UIFont systemFontOfSize:12];
        label_2.textColor = [UIColor whiteColor];
        label_2.textAlignment = NSTextAlignmentCenter;
        label_2.backgroundColor = [UIColor clearColor];
        label_2.frame = CGRectMake(0, CGRectGetMaxY(label_1.frame), 80, 20);
        [leftView addSubview:label_2];
        
        label_3 = [[UILabel alloc]init];
        label_3.text = @"免息优惠券";
        label_3.font = [UIFont systemFontOfSize:15];
        label_3.textColor = WORD_FONT_COLOR;
        label_3.textAlignment = NSTextAlignmentLeft;
        label_3.backgroundColor = [UIColor clearColor];
        label_3.frame = CGRectMake(CGRectGetMaxX(leftView.frame)+10, 5, 120, 20);
        [BGView addSubview:label_3];
        
        label_4 = [[UILabel alloc]init];
        label_4.text = @"开始时间：2017-04-14";
        label_4.font = [UIFont systemFontOfSize:12];
        label_4.textColor = TITLE_FONT_COLOR;
        label_4.textAlignment = NSTextAlignmentLeft;
        label_4.backgroundColor = [UIColor clearColor];
        label_4.frame = CGRectMake(CGRectGetMaxX(leftView.frame)+10, CGRectGetHeight(BGView.frame)-45, 150, 20);
        [BGView addSubview:label_4];
        
        label_5 = [[UILabel alloc]init];
        label_5.text = @"结束时间：2017-05-14";
        label_5.font = [UIFont systemFontOfSize:12];
        label_5.textColor = TITLE_FONT_COLOR;
        label_5.textAlignment = NSTextAlignmentLeft;
        label_5.backgroundColor = [UIColor clearColor];
        label_5.frame = CGRectMake(CGRectGetMaxX(leftView.frame)+10, CGRectGetHeight(BGView.frame)-25, 150, 20);
        [BGView addSubview:label_5];
     
        right_imgV = [[UIImageView alloc]init];
        right_imgV.frame = CGRectMake(CGRectGetWidth(BGView.frame)-70, (CGRectGetHeight(BGView.frame)-60)/2.0, 60, 60);
        right_imgV.image = [UIImage imageNamed:@"user_used"];
        [BGView addSubview:right_imgV];
        
    }
    return self;
}
- (void)setCouponCompletedModel:(CouponModel *)couponCompletedModel {
    
    label_3.text = [Gobal isEmptyString:couponCompletedModel.name]?@"--":couponCompletedModel.name;
    label_4.text = [Gobal isEmptyString:couponCompletedModel.startDate]?@"开始时间：--": [NSString stringWithFormat:@"开始时间：%@",couponCompletedModel.startDate];
    label_5.text = [Gobal isEmptyString:couponCompletedModel.endDate]?@"结束时间：--": [NSString stringWithFormat:@"结束时间：%@",couponCompletedModel.endDate];

}

@end
