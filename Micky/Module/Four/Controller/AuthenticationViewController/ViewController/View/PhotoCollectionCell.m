//
//  PhotoCollectionCell.m
//  MickyEasyCredit
//
//  Created by 张宁 on 2017/4/8.
//  Copyright © 2017年 apple. All rights reserved.
//

#import "PhotoCollectionCell.h"
#import "AppDelegate.h"



@implementation PhotoCollectionCell
@synthesize ID_imgV;
@synthesize text_label;
- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
       
        CGFloat width = frame.size.width;
        CGFloat height = frame.size.height;

        ID_imgV = [[UIImageView alloc]init];
        ID_imgV.frame = CGRectMake(10, 15, width-20, width-20);
        ID_imgV.image = [UIImage imageNamed:@"add_photo"];
        [self.contentView addSubview:ID_imgV];
        
        [Gobal drawDottedBorder:ID_imgV borderColor:LINE_BORD_COLOR lineWidth:1.f lineDashInterval:@[@5,@3]];
        
        
        text_label = [[UILabel alloc]init];
        text_label.font = [UIFont systemFontOfSize:12];
        text_label.text = @"--";
        text_label.textColor = TITLE_FONT_COLOR;
        text_label.textAlignment = NSTextAlignmentCenter;
        text_label.backgroundColor = [UIColor clearColor];
        text_label.frame = CGRectMake(10, height-30, width-20, 20);
        [self.contentView addSubview:text_label];
    
    }
    return self;
}
@end
