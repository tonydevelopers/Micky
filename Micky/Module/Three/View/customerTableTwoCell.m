//
//  customerTableTwoCell.m
//  MickyEasyCredit
//
//  Created by 张宁 on 2017/4/6.
//  Copyright © 2017年 apple. All rights reserved.
//

#import "customerTableTwoCell.h"
#import "AppDelegate.h"

@implementation customerTableTwoCell
@synthesize BGView;
@synthesize showView;
@synthesize title_label;
@synthesize left_imageV;
@synthesize right_imageV;

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        
        
        BGView = [Gobal drawSolidLinePointX:0 PointY:0 lineW:SCREEN_WIDTH lineH:45 lineColor:@[@"220",@"220",@"220"] lineAlpha:1.0];
        [self.contentView addSubview:BGView];
        
        showView = [Gobal drawSolidLinePointX:0 PointY:0 lineW:SCREEN_WIDTH lineH:44.5 lineColor:@[@"255",@"255",@"255"] lineAlpha:1.0];
        [self.contentView addSubview:showView];
        
        left_imageV = [[UIImageView alloc]init];
        left_imageV.frame = CGRectMake(10, 7, 30, 30);
        left_imageV.image = [UIImage imageNamed:@"header_photo"];
        left_imageV.backgroundColor = [UIColor clearColor];
        [showView addSubview:left_imageV];
        
        title_label = [[UILabel alloc]init];
        title_label.frame = CGRectMake(CGRectGetMaxX(left_imageV.frame)+10, 0, SCREEN_WIDTH-50, CGRectGetHeight(showView.frame));
        title_label.backgroundColor = [UIColor clearColor];
        title_label.text = @"--";
        title_label.textColor = WORD_FONT_COLOR;
        title_label.font = [UIFont systemFontOfSize:15];
        title_label.textAlignment = NSTextAlignmentLeft;
        [showView addSubview:title_label];
        
        right_imageV = [[UIImageView alloc]init];
        right_imageV.frame = CGRectMake(SCREEN_WIDTH-17, 16, 7, 12);
        right_imageV.image = [UIImage imageNamed:@"my_next"];
        right_imageV.backgroundColor = [UIColor clearColor];
        [showView addSubview:right_imageV];
        
    }
    return self;
}
- (void)setTitleLabel:(NSString *)titleStr iconImage:(NSString *)img indexPathRow:(NSInteger)index_row{
    left_imageV.image = [UIImage imageNamed:img];

    switch (index_row) {
        case 0:{
            NSMutableAttributedString *attributedStr = [[NSMutableAttributedString alloc]initWithString:titleStr];
            [attributedStr addAttribute:NSForegroundColorAttributeName value:RGBColor(60, 164, 244) range:NSMakeRange(5,  [titleStr length]-5)];
            [attributedStr addAttribute:NSUnderlineStyleAttributeName value:[NSNumber numberWithInteger:NSUnderlineStyleSingle] range:NSMakeRange(5,  [titleStr length]-5)];
            title_label.attributedText = attributedStr;
        }
            break;
        case 1:{
            NSMutableAttributedString *attributedStr = [[NSMutableAttributedString alloc]initWithString:titleStr];
            [attributedStr addAttribute:NSForegroundColorAttributeName value:RGBColor(60, 164, 244) range:NSMakeRange(3,  [titleStr length]-3)];
            [attributedStr addAttribute:NSUnderlineStyleAttributeName value:[NSNumber numberWithInteger:NSUnderlineStyleSingle] range:NSMakeRange(3,  [titleStr length]-3)];
            title_label.attributedText = attributedStr;
        }
            break;
        case 2:{
            NSMutableAttributedString *attributedStr = [[NSMutableAttributedString alloc]initWithString:titleStr];
            [attributedStr addAttribute:NSForegroundColorAttributeName value:RGBColor(60, 164, 244) range:NSMakeRange(3,  [titleStr length]-3)];
            [attributedStr addAttribute:NSUnderlineStyleAttributeName value:[NSNumber numberWithInteger:NSUnderlineStyleSingle] range:NSMakeRange(3,  [titleStr length]-3)];
            title_label.attributedText = attributedStr;
        }
            break;
        case 3:{
//            NSMutableAttributedString *attributedStr = [[NSMutableAttributedString alloc]initWithString:titleStr];
//            [attributedStr addAttribute:NSForegroundColorAttributeName value:RGBColor(60, 164, 244) range:NSMakeRange(3,  [titleStr length]-3)];
//            [attributedStr addAttribute:NSUnderlineStyleAttributeName value:[NSNumber numberWithInteger:NSUnderlineStyleSingle] range:NSMakeRange(3,  [titleStr length]-3)];
            title_label.text = titleStr;
        }
            break;
        default:
            break;
    }

}


@end
