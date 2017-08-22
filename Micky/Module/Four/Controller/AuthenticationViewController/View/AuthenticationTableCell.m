//
//  AuthenticationTableCell.m
//  MickyEasyCredit
//
//  Created by 张宁 on 2017/4/8.
//  Copyright © 2017年 apple. All rights reserved.
//

#import "AuthenticationTableCell.h"
#import "AuthenticationModel.h"

@implementation AuthenticationTableCell
@synthesize BGView;
@synthesize showView;
@synthesize title_label;
@synthesize left_imgV;
@synthesize state_label;
@synthesize right_imgv;
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
        
        left_imgV = [[UIImageView alloc]init];
        left_imgV.frame = CGRectMake(10, (height-16.5)/2.0, 16, 16);
        left_imgV.image = [UIImage imageNamed:@"my_info"];
        [showView addSubview:left_imgV];
        
        title_label = [[UILabel alloc]init];
        title_label.font = [UIFont systemFontOfSize:15];
        title_label.text = @"--";
        title_label.textColor = WORD_FONT_COLOR;
        title_label.textAlignment = NSTextAlignmentLeft;
        title_label.backgroundColor = [UIColor clearColor];
        title_label.frame = CGRectMake(36, 0, 120, CGRectGetHeight(showView.frame));//CGRectGetMaxX(left_imgV.frame)+10
        [showView addSubview:title_label];
        
        state_label = [[UILabel alloc]init];
        state_label.font = [UIFont systemFontOfSize:13];
        state_label.text = @"未完成";
        state_label.textColor = [UIColor whiteColor];
        state_label.textAlignment = NSTextAlignmentCenter;
        state_label.backgroundColor = RGBColor(210, 210, 210);
        state_label.frame = CGRectMake(SCREEN_WIDTH-85, (height-20.5)/2.0, 60, 20);
        state_label.layer.cornerRadius = 10;
        state_label.layer.masksToBounds = YES;
        [showView addSubview:state_label];
        
        right_imgv = [[UIImageView alloc]init];
        right_imgv.frame = CGRectMake(SCREEN_WIDTH-17, (CGRectGetHeight(showView.frame)-12)/2.0, 7, 12);
        right_imgv.image = [UIImage imageNamed:@"my_next"];
        [showView addSubview:right_imgv];
        
    }
    return self;
}
- (void)setTitleLabel:(NSString *)title_str indexPathRow:(NSInteger)index_row authenticationStr:(AuthenticationModel *)authenticateM {
    title_label.text = title_str;
    NSArray *arr = @[@"my_info_icon",@"my_education_icon",@"my_photo_icon",@"my_contact_icon",@"my_phone_icon",@"my_Internet_icon"];
    switch (index_row) {
        case 0:{//个人信息
            left_imgV.frame = CGRectMake(10, (44-16.5)/2.0, 16, 16);
            left_imgV.image = [UIImage imageNamed:arr[0]];
            if ([authenticateM.personalStatus isEqualToString:@"1"]) {
                state_label.text = @"已完成";
                state_label.backgroundColor = BUTTON_COLOR_NORMA;
            }else{
                state_label.text = @"未完成";
                state_label.backgroundColor = RGBColor(210, 210, 210);
            }
        }
            break;
        case 1:{//教育背景
            left_imgV.frame = CGRectMake(9, (44-16.5)/2.0, 18, 16);
            left_imgV.image = [UIImage imageNamed:arr[1]];
            if ([authenticateM.educationStatus isEqualToString:@"1"]) {
                state_label.text = @"已完成";
                state_label.backgroundColor = BUTTON_COLOR_NORMA;
            }else{
                state_label.text = @"未完成";
                state_label.backgroundColor = RGBColor(210, 210, 210);
            }
        }
            break;
        case 2:{//照片认证
            left_imgV.frame = CGRectMake(10, (44-14)/2.0, 16, 13);
            left_imgV.image = [UIImage imageNamed:arr[2]];
            if ([authenticateM.photoStatus isEqualToString:@"1"]) {
                state_label.text = @"已完成";
                state_label.backgroundColor = BUTTON_COLOR_NORMA;
            }else{
                state_label.text = @"未完成";
                state_label.backgroundColor = RGBColor(210, 210, 210);
            }
        }
            break;
        case 3:{//联系人信息
            left_imgV.frame = CGRectMake(8, (44-15)/2.0, 20, 14);
            left_imgV.image = [UIImage imageNamed:arr[3]];
            if ([authenticateM.contactStatus isEqualToString:@"1"]) {
                state_label.text = @"已完成";
                state_label.backgroundColor = BUTTON_COLOR_NORMA;
            }else{
                state_label.text = @"未完成";
                state_label.backgroundColor = RGBColor(210, 210, 210);
            }
        }
            break;
//        case 4:{//学信网认证
//            left_imgV.frame = CGRectMake(10, (44-16.5)/2.0, 16, 16);
//            left_imgV.image = [UIImage imageNamed:arr[4]];
//            if ([authenticateM.learnStatus isEqualToString:@"1"]) {
//                state_label.text = @"已完成";
//                state_label.backgroundColor = BUTTON_COLOR_NORMA;
//            }else{
//                state_label.text = @"未完成";
//                state_label.backgroundColor = RGBColor(210, 210, 210);
//            }
//        }
//            break;
        case 4:{//手机认证
            left_imgV.frame = CGRectMake(11, (44-17)/2.0, 14, 17);
            left_imgV.image = [UIImage imageNamed:arr[4]];
            if ([authenticateM.phoneStatus isEqualToString:@"1"]) {
                state_label.text = @"已完成";
                state_label.backgroundColor = BUTTON_COLOR_NORMA;
            }else{
                state_label.text = @"未完成";
                state_label.backgroundColor = RGBColor(210, 210, 210);
            }
        }
            break;
        case 5:{//互联网认证
            left_imgV.frame = CGRectMake(10.5, (44-15)/2.0, 15, 13);
            left_imgV.image = [UIImage imageNamed:arr[5]];
            if ([authenticateM.internetStatus isEqualToString:@"1"]) {
                state_label.text = @"已完成";
                state_label.backgroundColor = BUTTON_COLOR_NORMA;
            }else{
                state_label.text = @"未完成";
                state_label.backgroundColor = RGBColor(210, 210, 210);
            }
        }
            break;
        default:
            break;
    }
}

@end
