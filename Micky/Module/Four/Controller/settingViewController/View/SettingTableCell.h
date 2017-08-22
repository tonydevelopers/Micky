//
//  SettingTableCell.h
//  MickyEasyCredit
//
//  Created by 张宁 on 2017/4/6.
//  Copyright © 2017年 apple. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol SettingTableDelegate <NSObject>

- (void)clickSelectChangePassword:(NSInteger)indexTag;

@end


@interface SettingTableCell : UITableViewCell

@property(nonatomic,assign)id<SettingTableDelegate>deleagte;

@property(nonatomic,strong)UIView *BGView;
@property(nonatomic,strong)UIView *showView;
@property(nonatomic,strong)UILabel *title_label;
@property(nonatomic,strong)NSString *title_string;
@property(nonatomic,strong)UIButton *click;
@property(nonatomic,strong)UIImageView *photo;
@property(nonatomic,strong)UILabel *right_label;
@property(nonatomic,strong)UITextField *nick_name;
@property(nonatomic,strong)UIImageView *right_imgV;

- (void)setTitleLabel:(NSString *)title_str indexPathRow:(NSInteger)index_row;
- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier;

@end
