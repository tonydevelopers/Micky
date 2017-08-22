//
//  AuthenticationTableCell.h
//  MickyEasyCredit
//
//  Created by 张宁 on 2017/4/8.
//  Copyright © 2017年 apple. All rights reserved.
//

#import <UIKit/UIKit.h>

@class AuthenticationModel;

@interface AuthenticationTableCell : UITableViewCell

@property(nonatomic,strong)UIView *BGView;
@property(nonatomic,strong)UIView *showView;
@property(nonatomic,strong)UIImageView *left_imgV;
@property(nonatomic,strong)UILabel *title_label;
@property(nonatomic,strong)UILabel *state_label;
@property(nonatomic,strong)UIImageView *right_imgv;
@property(nonatomic,strong)AuthenticationModel *authenticationModel;
- (void)setTitleLabel:(NSString *)title_str indexPathRow:(NSInteger)index_row authenticationStr:(AuthenticationModel *)authenticateM;
- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier;

@end
