//
//  ConfirmBorrowView.h
//  MickyEasyCredit
//
//  Created by 张宁 on 2017/4/10.
//  Copyright © 2017年 apple. All rights reserved.
//

#import <UIKit/UIKit.h>
@class ConfirmBorrowView;

@protocol ConfirmBorrowDelegate <NSObject>

- (void)confirmBorrow;

@end


@interface ConfirmBorrowView : UIView

@property(nonatomic,assign) id<ConfirmBorrowDelegate>delegate;

@property(nonatomic,strong)UIView *show_view;
@property(nonatomic,strong)UILabel *text_label;
@property(nonatomic,strong)UIButton *confirm_Btn;
@property(nonatomic,strong)UIButton *cancle_Btn;

@property(nonatomic,strong)UILabel *jk_label;
@property(nonatomic,strong)UILabel *qx_label;
@property(nonatomic,strong)UILabel *fy_label;
@property(nonatomic,strong)UILabel *je_label;

- (void)show;
- (instancetype)initWithBorrow:(NSString *)b_price timeLimit:(NSString *)t_limit serviceFee:(NSString *)s_fee repaymentAmount:(NSString *)r_amount;

@end
