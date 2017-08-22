//
//  customerTableTwoCell.h
//  MickyEasyCredit
//
//  Created by 张宁 on 2017/4/6.
//  Copyright © 2017年 apple. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface customerTableTwoCell : UITableViewCell

@property(nonatomic,strong)UIView *BGView;
@property(nonatomic,strong)UIView *showView;
@property(nonatomic,strong)UILabel *title_label;
@property(nonatomic,strong)UIImageView *left_imageV;
@property(nonatomic,strong)UIImageView *right_imageV;

- (void)setTitleLabel:(NSString *)titleStr iconImage:(NSString *)img indexPathRow:(NSInteger)index_row;
- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier;

@end
