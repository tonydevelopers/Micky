//
//  OneCollectionViewCell.m
//  MickyEasyCredit
//
//  Created by 张宁 on 2017/5/3.
//  Copyright © 2017年 apple. All rights reserved.
//

#import "OneCollectionViewCell.h"
#import "SXMarquee.h"

@implementation OneCollectionViewCell
@synthesize BGView;
@synthesize showView;
@synthesize nameLabel;
@synthesize ADImg;
@synthesize marqueeBar;
-(instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        BGView = [[UIView alloc]init];
        BGView.frame = CGRectMake(0, 0, SCREEN_WIDTH, 40.5);
        BGView.backgroundColor = BASE_COLOR_LINE;
        [self.contentView addSubview:BGView];
        
        showView = [[UIView alloc]init];
        showView.frame = CGRectMake(0, 0, SCREEN_WIDTH, 40);
        showView.backgroundColor = [UIColor whiteColor];
        [BGView addSubview:showView];

//        nameLabel = [[UILabel alloc]init];
//        nameLabel.frame = CGRectMake(0, 0, SCREEN_WIDTH, 40);
//        nameLabel.backgroundColor = [UIColor clearColor];
//        nameLabel.text = @"无抵押 无担保 纯信用贷款";
//        nameLabel.textColor = WORD_FONT_COLOR;
//        nameLabel.font = [UIFont systemFontOfSize:15];
//        nameLabel.textAlignment = NSTextAlignmentCenter;
//        [showView addSubview:nameLabel];
     
        ADImg = [[UIImageView alloc]init];
        ADImg.image = [UIImage imageNamed:@"ad_Img"];
        ADImg.frame = CGRectMake(10, 12, 20, 20);
        [showView addSubview:ADImg];

        marqueeBar = [[SXMarquee alloc]initWithFrame:CGRectMake(30, 2, SCREEN_WIDTH-40, 38) speed:5 Msg:@"仟易贷不存在任何的线下代理和工作人员，没有任何前期费用，请勿上当受骗！" bgColor:[UIColor clearColor] txtColor:BUTTON_COLOR_NORMA];
        [marqueeBar changeMarqueeLabelFont:[UIFont systemFontOfSize:15]];
        [marqueeBar changeTapMarqueeAction:^{
            
        }];
        [marqueeBar start];
        [showView addSubview:self.marqueeBar];
        
    }
    return self;
}

@end
