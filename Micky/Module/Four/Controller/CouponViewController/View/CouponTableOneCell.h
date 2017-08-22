//
//  CouponTableOneCell.h
//  MickyEasyCredit
//
//  Created by 张宁 on 2017/5/11.
//  Copyright © 2017年 apple. All rights reserved.
//

#import <UIKit/UIKit.h>
@class CouponModel;
@interface CouponTableOneCell : UITableViewCell

@property(nonatomic,strong)UIView *BGView;
@property(nonatomic,strong)UIView *leftView;
@property(nonatomic,strong)UILabel*label_1;
@property(nonatomic,strong)UILabel*label_2;
@property(nonatomic,strong)UILabel*label_3;
@property(nonatomic,strong)UILabel*label_4;
@property(nonatomic,strong)UILabel*label_5;
@property(nonatomic,strong)CouponModel *couponNotUserModel;
- (void)setCouponNotUserModel:(CouponModel *)couponNotUserModel;
- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier;

@end
