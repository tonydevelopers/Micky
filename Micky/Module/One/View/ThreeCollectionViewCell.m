//
//  ThreeCollectionViewCell.m
//  MickyEasyCredit
//
//  Created by 张宁 on 2017/5/3.
//  Copyright © 2017年 apple. All rights reserved.
//

#import "ThreeCollectionViewCell.h"

@implementation ThreeCollectionViewCell
@synthesize BGView;
@synthesize showView;
@synthesize nameLabel;
-(instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        BGView = [[UIView alloc]init];
        BGView.frame = CGRectMake(0, 15, SCREEN_WIDTH, 40.5);
        BGView.backgroundColor = BASE_COLOR_LINE;
        [self.contentView addSubview:BGView];
        
        showView = [[UIView alloc]init];
        showView.frame = CGRectMake(0, 0, SCREEN_WIDTH, 40);
        showView.backgroundColor = [UIColor whiteColor];
        [BGView addSubview:showView];
        
        nameLabel = [[UILabel alloc]init];
        nameLabel.frame = CGRectMake(0, 0, SCREEN_WIDTH, 40);
        nameLabel.backgroundColor = [UIColor clearColor];
        nameLabel.text = @"借款相关";
        nameLabel.textColor = WORD_FONT_COLOR;
        nameLabel.font = [UIFont systemFontOfSize:15];
        nameLabel.textAlignment = NSTextAlignmentCenter;
        [showView addSubview:nameLabel];
        
    }
    return self;
}

@end
