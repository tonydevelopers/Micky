//
//  CouponTableTwoCell.h
//  MickyEasyCredit
//
//  Created by 张宁 on 2017/5/11.
//  Copyright © 2017年 apple. All rights reserved.
//

#import <UIKit/UIKit.h>
@class CouponModel;
@interface CouponTableTwoCell : UITableViewCell

@property(nonatomic,strong)UIView *BGView;
@property(nonatomic,strong)UIView *leftView;
@property(nonatomic,strong)UILabel*label_1;
@property(nonatomic,strong)UILabel*label_2;
@property(nonatomic,strong)UILabel*label_3;
@property(nonatomic,strong)UILabel*label_4;
@property(nonatomic,strong)UILabel*label_5;
@property(nonatomic,strong)UIImageView *right_imgV;
@property(nonatomic,strong)CouponModel *couponCompletedModel;
- (void)setCouponCompletedModel:(CouponModel *)couponCompletedModel;
- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier;

@end
