//
//  CouponViewController.h
//  MickyEasyCredit
//
//  Created by 张宁 on 2017/5/11.
//  Copyright © 2017年 apple. All rights reserved.
//

#import <UIKit/UIKit.h>

@class CouponModel;
@protocol CouponDelegate <NSObject>

- (void)selectCouponModel:(CouponModel *)model;

@end

@interface CouponViewController : UIViewController

@property(nonatomic,assign)id<CouponDelegate>delegate;
@property(nonatomic,assign)BOOL isPopBack;

@end
