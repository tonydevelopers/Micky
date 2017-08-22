//
//  priceView.h
//  MickyEasyCredit
//
//  Created by 张宁 on 2017/3/27.
//  Copyright © 2017年 apple. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface priceView : UIView
@property(nonatomic,strong)UILabel *real_pay;
@property(nonatomic,strong)UILabel *original_price;

- (instancetype)initWithFrame:(CGRect)frame MoneyMark:(NSString *)mark realPay:(NSString *)R_money originalPrice:(NSString *)O_money;
@end
