//
//  BankTableCell.m
//  MickyEasyCredit
//
//  Created by 张宁 on 2017/5/9.
//  Copyright © 2017年 apple. All rights reserved.
//

#import "BankTableCell.h"
#import "AppDelegate.h"
#import "BankListModel.h"

#import "UIImageView+WebCache.h"

@implementation BankTableCell

@synthesize BGView;
@synthesize point_1;
@synthesize point_2;
@synthesize point_3;
@synthesize point_4;

@synthesize point_5;
@synthesize point_6;
@synthesize point_7;
@synthesize point_8;

@synthesize point_9;
@synthesize point_10;
@synthesize point_11;
@synthesize point_12;

@synthesize point_BG;
@synthesize bank_imgv;
@synthesize bank_label;
@synthesize bank_phone;
@synthesize bank_style;
@synthesize bank_number;

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        
        self.contentView.backgroundColor = BACKGROUND_COLOR;
        CGFloat h = (145/355.0)*(SCREEN_WIDTH-20);
        CGFloat b_h = (20/375.0)*SCREEN_WIDTH;
        
        
        BGView = [[UIImageView alloc]init];
        BGView.frame = CGRectMake(10, 10, SCREEN_WIDTH-20, h-10);
        BGView.backgroundColor = [UIColor colorWithRed:50/255.0 green:56/255.0 blue:108/255.0 alpha:1.0];
        BGView.layer.cornerRadius = 5;
        BGView.layer.masksToBounds = YES;
        [self.contentView addSubview:BGView];
        
        bank_imgv = [[UIImageView alloc]init];
        bank_imgv.frame = CGRectMake(b_h, b_h, 50, 50);
        bank_imgv.backgroundColor = [UIColor whiteColor];
        bank_imgv.image = [UIImage imageNamed:@"header_photo"];
        bank_imgv.layer.cornerRadius = 25;
        bank_imgv.layer.masksToBounds = YES;
        [BGView addSubview:bank_imgv];
        
        bank_label = [[UILabel alloc]init];
        bank_label.backgroundColor = [UIColor clearColor];
        bank_label.text = @"--";
        bank_label.textColor = [UIColor whiteColor];
        bank_label.font = [UIFont systemFontOfSize:18];
        bank_label.textAlignment = NSTextAlignmentLeft;
        [BGView addSubview:bank_label];
        [bank_label mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(bank_imgv.mas_top).offset(5);
            make.left.equalTo(bank_imgv.mas_right).offset(10);
            make.height.equalTo(@20);
            make.width.equalTo(@150);
        }];
        
        bank_phone = [[UILabel alloc]init];
        bank_phone.backgroundColor = [UIColor clearColor];
        bank_phone.text = @"手机尾号:--";
        bank_phone.textColor = [UIColor whiteColor];
        bank_phone.font = [UIFont systemFontOfSize:15];
        bank_phone.textAlignment = NSTextAlignmentLeft;
        [BGView addSubview:bank_phone];
        [bank_phone mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(bank_label.mas_bottom).offset(5);
            make.left.equalTo(bank_label.mas_left).offset(0);
            make.height.equalTo(@20);
            make.width.equalTo(@150);
        }];

        bank_style = [[UILabel alloc]init];
        bank_style.backgroundColor = [UIColor clearColor];
        bank_style.frame = CGRectMake(SCREEN_WIDTH-95, b_h+5, 55, 20);
        bank_style.text = @"借记卡";
        bank_style.textColor = [UIColor whiteColor];
        bank_style.font = [UIFont systemFontOfSize:15];
        bank_style.textAlignment = NSTextAlignmentRight;
        [BGView addSubview:bank_style];
        
        CGFloat w_p = SCREEN_WIDTH-20-2*b_h;
        CGFloat w_w = w_p-55;
        CGFloat W_X = (w_w-55*3)/3.0;
        
        point_BG = [[UIView alloc]init];
        point_BG.frame = CGRectMake(b_h, CGRectGetHeight(BGView.frame)-20-b_h, w_w, 20);
        point_BG.backgroundColor = [UIColor clearColor];
        [BGView addSubview:point_BG];
        
        point_1 = [[UIView alloc]init];
        point_1.frame = CGRectMake(0, 7, 10, 10);
        point_1.backgroundColor = [UIColor whiteColor];
        point_1.layer.cornerRadius = 5;
        point_1.layer.masksToBounds = YES;
        [point_BG addSubview:point_1];
        
        point_2 = [[UIView alloc]init];
        point_2.frame = CGRectMake(15, CGRectGetMinY(point_1.frame), 10, 10);
        point_2.backgroundColor = [UIColor whiteColor];
        point_2.layer.cornerRadius = 5;
        point_2.layer.masksToBounds = YES;
        [point_BG addSubview:point_2];

        point_3 = [[UIView alloc]init];
        point_3.frame = CGRectMake(30, CGRectGetMinY(point_1.frame), 10, 10);
        point_3.backgroundColor = [UIColor whiteColor];
        point_3.layer.cornerRadius = 5;
        point_3.layer.masksToBounds = YES;
        [point_BG addSubview:point_3];

        point_4 = [[UIView alloc]init];
        point_4.frame = CGRectMake(45, CGRectGetMinY(point_1.frame), 10, 10);
        point_4.backgroundColor = [UIColor whiteColor];
        point_4.layer.cornerRadius = 5;
        point_4.layer.masksToBounds = YES;
        [point_BG addSubview:point_4];

        point_5 = [[UIView alloc]init];
        point_5.frame = CGRectMake(60+W_X, CGRectGetMinY(point_1.frame), 10, 10);
        point_5.backgroundColor = [UIColor whiteColor];
        point_5.layer.cornerRadius = 5;
        point_5.layer.masksToBounds = YES;
        [point_BG addSubview:point_5];

        point_6 = [[UIView alloc]init];
        point_6.frame = CGRectMake(75+W_X, CGRectGetMinY(point_1.frame), 10, 10);
        point_6.backgroundColor = [UIColor whiteColor];
        point_6.layer.cornerRadius = 5;
        point_6.layer.masksToBounds = YES;
        [point_BG addSubview:point_6];

        point_7 = [[UIView alloc]init];
        point_7.frame = CGRectMake(90+W_X, CGRectGetMinY(point_1.frame), 10, 10);
        point_7.backgroundColor = [UIColor whiteColor];
        point_7.layer.cornerRadius = 5;
        point_7.layer.masksToBounds = YES;
        [point_BG addSubview:point_7];

        point_8 = [[UIView alloc]init];
        point_8.frame = CGRectMake(105+W_X, CGRectGetMinY(point_1.frame), 10, 10);
        point_8.backgroundColor = [UIColor whiteColor];
        point_8.layer.cornerRadius = 5;
        point_8.layer.masksToBounds = YES;
        [point_BG addSubview:point_8];

        point_9 = [[UIView alloc]init];
        point_9.frame = CGRectMake(120+2*W_X, CGRectGetMinY(point_1.frame), 10, 10);
        point_9.backgroundColor = [UIColor whiteColor];
        point_9.layer.cornerRadius = 5;
        point_9.layer.masksToBounds = YES;
        [point_BG addSubview:point_9];
        
        point_10 = [[UIView alloc]init];
        point_10.frame = CGRectMake(135+2*W_X, CGRectGetMinY(point_1.frame), 10, 10);
        point_10.backgroundColor = [UIColor whiteColor];
        point_10.layer.cornerRadius = 5;
        point_10.layer.masksToBounds = YES;
        [point_BG addSubview:point_10];
        
        point_11 = [[UIView alloc]init];
        point_11.frame = CGRectMake(150+2*W_X, CGRectGetMinY(point_1.frame), 10, 10);
        point_11.backgroundColor = [UIColor whiteColor];
        point_11.layer.cornerRadius = 5;
        point_11.layer.masksToBounds = YES;
        [point_BG addSubview:point_11];
        
        point_12 = [[UIView alloc]init];
        point_12.frame = CGRectMake(165+2*W_X, CGRectGetMinY(point_1.frame), 10, 10);
        point_12.backgroundColor = [UIColor whiteColor];
        point_12.layer.cornerRadius = 5;
        point_12.layer.masksToBounds = YES;
        [point_BG addSubview:point_12];

    
        bank_number = [[UILabel alloc]init];
        bank_number.backgroundColor = [UIColor clearColor];
        bank_number.frame = CGRectMake(CGRectGetMaxX(point_BG.frame)+5, CGRectGetHeight(BGView.frame)-20-b_h, 55, 20);
        bank_number.text = @"XXXX";
        bank_number.textColor = [UIColor whiteColor];
        bank_number.font = [UIFont boldSystemFontOfSize:18];
        bank_number.textAlignment = NSTextAlignmentRight;
        [BGView addSubview:bank_number];

        
    }
    return self;
}
- (void)setBankListModel:(BankListModel *)bankListModel {

    [bank_imgv sd_setImageWithURL:[NSURL URLWithString:bankListModel.icon] placeholderImage:[UIImage imageNamed:@"header_photo"]];
    bank_label.text = [Gobal isEmptyString:bankListModel.cardName]?@"--":bankListModel.cardName;
    bank_number.text = [Gobal isEmptyString:bankListModel.cardNo]?@"--":[bankListModel.cardNo substringFromIndex:[bankListModel.cardNo length]-4];
    bank_phone.text = [NSString stringWithFormat:@"手机尾号:%@",[Gobal isEmptyString:bankListModel.phone]?@"XXXX":[bankListModel.phone substringFromIndex:7]];

}


@end
