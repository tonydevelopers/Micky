//
//  CouponModel.h
//  MickyEasyCredit
//
//  Created by 张宁 on 2017/5/11.
//  Copyright © 2017年 apple. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface CouponModel : NSObject

@property(nonatomic,strong)NSString *noCount;
@property(nonatomic,strong)NSString *yesCount;
@property(nonatomic,strong)NSString *expiredCount;
@property(nonatomic,strong)NSString *Id;
@property(nonatomic,strong)NSString *name;
@property(nonatomic,strong)NSString *startDate;
@property(nonatomic,strong)NSString *endDate;

- (CouponModel*)initWithJsonDictionary:(NSDictionary*)dic;
- (void)updateWithJSonDictionary:(NSDictionary*)dic;
+ (CouponModel*)dataWithJsonDictionary:(NSDictionary*)dic;

@end
