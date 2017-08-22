//
//  BankTableCell.h
//  MickyEasyCredit
//
//  Created by 张宁 on 2017/5/9.
//  Copyright © 2017年 apple. All rights reserved.
//

#import <UIKit/UIKit.h>

@class BankListModel;

@interface BankTableCell : UITableViewCell

@property(nonatomic,strong)UIView  *BGView;
@property(nonatomic,strong)UIView  *point_BG;
@property(nonatomic,strong)UIView  *point_1;
@property(nonatomic,strong)UIView  *point_2;
@property(nonatomic,strong)UIView  *point_3;
@property(nonatomic,strong)UIView  *point_4;

@property(nonatomic,strong)UIView  *point_5;
@property(nonatomic,strong)UIView  *point_6;
@property(nonatomic,strong)UIView  *point_7;
@property(nonatomic,strong)UIView  *point_8;

@property(nonatomic,strong)UIView  *point_9;
@property(nonatomic,strong)UIView  *point_10;
@property(nonatomic,strong)UIView  *point_11;
@property(nonatomic,strong)UIView  *point_12;

@property(nonatomic,strong)UILabel *bank_label;
@property(nonatomic,strong)UILabel *bank_phone;
@property(nonatomic,strong)UILabel *bank_style;
@property(nonatomic,strong)UILabel *bank_number;
@property(nonatomic,strong)UIImageView  *bank_imgv;
@property(nonatomic,strong)BankListModel *bankListModel;

- (void)setBankListModel:(BankListModel *)bankListModel;
- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier;

@end
