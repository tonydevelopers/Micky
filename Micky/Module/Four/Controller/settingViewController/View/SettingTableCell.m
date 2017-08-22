//
//  SettingTableCell.m
//  MickyEasyCredit
//
//  Created by 张宁 on 2017/4/6.
//  Copyright © 2017年 apple. All rights reserved.
//

#import "SettingTableCell.h"
#import "AppDelegate.h"


@implementation SettingTableCell
@synthesize BGView;
@synthesize showView;
@synthesize title_label;
@synthesize click;
@synthesize photo;
@synthesize nick_name;
@synthesize right_label;
@synthesize right_imgV;

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        
        CGFloat height = self.frame.size.height;
        
        BGView = [[UIView alloc]init];
        BGView.backgroundColor = RGBColor(220, 220, 220);
        BGView.frame = CGRectMake(0, 0, SCREEN_WIDTH, height);
        [self.contentView addSubview:BGView];
        
        showView = [[UIView alloc]init];
        showView.backgroundColor = RGBColor(255, 255, 255);
        showView.frame = CGRectMake(0, 0, SCREEN_WIDTH, height-0.5);
        [self.contentView addSubview:showView];
        
        click = [UIButton buttonWithType:UIButtonTypeCustom];
        click.frame = CGRectMake(0, 0, CGRectGetWidth(showView.frame), CGRectGetHeight(showView.frame));
        [click setBackgroundImage:[Gobal imageWithColor:[UIColor clearColor] size:click.frame.size] forState:UIControlStateNormal];
        [click setBackgroundImage:[Gobal imageWithColor:LINE_BORD_COLOR size:click.frame.size] forState:UIControlStateHighlighted];
        [click addTarget:self action:@selector(clickRow:) forControlEvents:UIControlEventTouchUpInside];
        [showView addSubview:click];
        click.hidden = YES;
        
        //我的奖金
        title_label = [[UILabel alloc]init];
        title_label.font = [UIFont systemFontOfSize:15];
        title_label.textColor = WORD_FONT_COLOR;
        title_label.textAlignment = NSTextAlignmentLeft;
        title_label.backgroundColor = [UIColor clearColor];
        title_label.frame = CGRectMake(10, 0, 120, CGRectGetHeight(showView.frame));
        [showView addSubview:title_label];
        
        photo = [[UIImageView alloc]init];
        photo.frame = CGRectMake(SCREEN_WIDTH-80, 5, 70, 70);
        photo.image = [UIImage imageNamed:@"header_photo"];
        photo.layer.cornerRadius = 5;
        photo.layer.masksToBounds = YES;
        [showView addSubview:photo];
        photo.hidden = YES;
        
        //我的信息
        right_label = [[UILabel alloc]init];
        right_label.font = [UIFont systemFontOfSize:15];
        right_label.text = @"--";
        right_label.textColor = WORD_FONT_COLOR;
        right_label.textAlignment = NSTextAlignmentRight;
        right_label.backgroundColor = [UIColor clearColor];
        right_label.frame = CGRectMake(150, 0, SCREEN_WIDTH-160, CGRectGetHeight(showView.frame));
        [showView addSubview:right_label];
        right_label.hidden = YES;

        nick_name = [[UITextField alloc]init];
        nick_name.placeholder = @"请设置您的昵称";
        nick_name.frame = CGRectMake(150, 0, SCREEN_WIDTH-160, CGRectGetHeight(showView.frame));
        nick_name.keyboardType = UIKeyboardTypeDefault;
        nick_name.backgroundColor = [UIColor clearColor];
        nick_name.textColor = WORD_FONT_COLOR;
        nick_name.textAlignment = NSTextAlignmentRight;
        nick_name.font = [UIFont systemFontOfSize:15];
        [showView addSubview:nick_name];
        nick_name.hidden = YES;
        
        right_imgV = [[UIImageView alloc]init];
        right_imgV.frame = CGRectMake(SCREEN_WIDTH-17, (CGRectGetHeight(showView.frame)-12)/2.0, 7, 12);
        right_imgV.image = [UIImage imageNamed:@"my_next"];
        [showView addSubview:right_imgV];
        right_imgV.hidden = YES;
        
    }
    return self;
}
- (void)setTitleLabel:(NSString *)title_str indexPathRow:(NSInteger)index_row {
    title_label.text = title_str;
    switch (index_row) {
        case 0:{
            click.tag = 0;
            click.hidden = NO;
            photo.hidden = NO;
            nick_name.hidden = YES;
            right_imgV.hidden = YES;
            right_label.hidden = YES;
        }
            break;
        case 1:{
            click.hidden = YES;
            photo.hidden = YES;
            nick_name.hidden = NO;
            right_imgV.hidden = YES;
            right_label.hidden = YES;
        }
            break;
        case 2:{
            click.hidden = YES;
            photo.hidden = YES;
            nick_name.hidden = YES;
            right_imgV.hidden = YES;
            right_label.hidden = NO;
        }
            break;
        case 3:{
            click.tag = 3;
            click.hidden = NO;
            photo.hidden = YES;
            nick_name.hidden = YES;
            right_imgV.hidden = NO;
            right_label.hidden = YES;
        }
            break;

        default:
            break;
    }
}
- (void)layoutSubviews {
    [super layoutSubviews];
    
    CGFloat height = self.contentView.frame.size.height;
    photo.frame = CGRectMake(SCREEN_WIDTH-80, 5, 70, 70);
    BGView.frame = CGRectMake(0, 0, SCREEN_WIDTH, height);
    showView.frame = CGRectMake(0, 0, SCREEN_WIDTH, height-0.5);
    title_label.frame = CGRectMake(10, 0, 120, CGRectGetHeight(showView.frame));
    nick_name.frame = CGRectMake(150, 0, SCREEN_WIDTH-160, CGRectGetHeight(showView.frame));
    right_label.frame = CGRectMake(150, 0, SCREEN_WIDTH-160, CGRectGetHeight(showView.frame));
    right_imgV.frame = CGRectMake(SCREEN_WIDTH-17, (CGRectGetHeight(showView.frame)-12)/2.0, 7, 12);
    click.frame = CGRectMake(0, 0, CGRectGetWidth(showView.frame), CGRectGetHeight(showView.frame));

}
- (void)clickRow:(UIButton *)index_Btn {
    if ([self.deleagte respondsToSelector:@selector(clickSelectChangePassword:)]) {
        [self.deleagte clickSelectChangePassword:index_Btn.tag];
    }
}
@end
