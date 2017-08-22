//
//  NewsTableOneCell.m
//  MickyEasyCredit
//
//  Created by 张宁 on 2017/4/6.
//  Copyright © 2017年 apple. All rights reserved.
//

#import "NewsTableOneCell.h"
#import "AppDelegate.h"

@implementation NewsTableOneCell

@synthesize BGView;
@synthesize title_Label;
@synthesize content_Label;
@synthesize time_Label;
- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        
        self.contentView.backgroundColor = BACKGROUND_COLOR;
        
        BGView = [[UIView alloc]init];
        BGView.backgroundColor = [UIColor whiteColor];
        BGView.frame = CGRectMake(10, 10, SCREEN_WIDTH-20, 80);
        BGView.layer.cornerRadius = 5;
        BGView.layer.masksToBounds = YES;
        BGView.layer.borderWidth = 1;
        BGView.layer.borderColor = LINE_BORD_COLOR.CGColor;
        [self.contentView addSubview:BGView];
        
        title_Label = [[UILabel alloc]init];
        title_Label.frame = CGRectMake(10, 0, (CGRectGetWidth(BGView.frame)-20)/2.0, 30);
        title_Label.backgroundColor = [UIColor clearColor];
        title_Label.text = @"--";
        title_Label.textColor = WORD_FONT_COLOR;
        title_Label.font = [UIFont systemFontOfSize:16];
        title_Label.textAlignment = NSTextAlignmentLeft;
        [BGView addSubview:title_Label];

        UIView *line = [Gobal drawSolidLinePointX:10 PointY:CGRectGetMaxY(title_Label.frame) lineW:CGRectGetWidth(BGView.frame)-20 lineH:1.0 lineColor:@[@"220",@"220",@"220"] lineAlpha:1.0];
        [BGView addSubview:line];
        
        
        content_Label = [[UILabel alloc]init];
        content_Label.frame = CGRectMake(10, CGRectGetMaxY(title_Label.frame), CGRectGetWidth(BGView.frame)-20, CGRectGetHeight(BGView.frame)-40);
        content_Label.backgroundColor = [UIColor clearColor];
        content_Label.text = @"--";
        content_Label.numberOfLines = 0;
        content_Label.textColor = TITLE_FONT_COLOR;
        content_Label.font = [UIFont systemFontOfSize:15];
        content_Label.textAlignment = NSTextAlignmentLeft;
        [BGView addSubview:content_Label];
        
        time_Label = [[UILabel alloc]init];
        time_Label.frame = CGRectMake(CGRectGetWidth(BGView.frame)/2.0, 10, (CGRectGetWidth(BGView.frame)-20)/2.0, 25);
        time_Label.backgroundColor = [UIColor clearColor];
        time_Label.text = @"--";
        time_Label.textColor = TITLE_FONT_COLOR;
        time_Label.font = [UIFont systemFontOfSize:13];
        time_Label.textAlignment = NSTextAlignmentRight;
        [BGView addSubview:time_Label];

    }
    return self;
}

-(void)setNewsModel:(NewsModel *)newsModel {

    title_Label.text = newsModel.msgType;
    content_Label.text = newsModel.msgContent;
    time_Label.text = newsModel.createDate;

    CGFloat height = [Gobal heightWithText:newsModel.msgContent font:[UIFont systemFontOfSize:15] maxWidth:SCREEN_WIDTH-40];
    CGFloat H = (height>20?height:20);
    
    BGView.frame = CGRectMake(10, 10, SCREEN_WIDTH-20, 60+H);
    title_Label.frame = CGRectMake(10, 0, (CGRectGetWidth(BGView.frame)-20)/2.0, 35);
    time_Label.frame = CGRectMake(CGRectGetWidth(BGView.frame)/2.0, 5, (CGRectGetWidth(BGView.frame)-20)/2.0, 25);
    content_Label.frame = CGRectMake(10, CGRectGetMaxY(title_Label.frame), CGRectGetWidth(BGView.frame)-20, CGRectGetHeight(BGView.frame)-40);
}









@end
