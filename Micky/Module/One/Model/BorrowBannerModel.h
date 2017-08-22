//
//  BorrowBannerModel.h
//  MickyEasyCredit
//
//  Created by 张宁 on 2017/4/15.
//  Copyright © 2017年 apple. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface BorrowBannerModel : NSObject

@property(nonatomic,strong)NSString *name;
@property(nonatomic,strong)NSString *jkAmount;

- (BorrowBannerModel*)initWithJsonDictionary:(NSDictionary*)dic;
- (void)updateWithJSonDictionary:(NSDictionary*)dic;
+ (BorrowBannerModel*)dataWithJsonDictionary:(NSDictionary*)dic;

@end
