//
//  UserInfoModel.h
//  MickyEasyCredit
//
//  Created by 张宁 on 2017/4/7.
//  Copyright © 2017年 apple. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface UserInfoModel : NSObject

@property(nonatomic,strong)NSString *creditesFee;
@property(nonatomic,strong)NSString *bonusAmout;
@property(nonatomic,strong)NSString *faceImg;
@property(nonatomic,strong)NSString *phone;
@property(nonatomic,strong)NSString *name;

- (UserInfoModel*)initWithJsonDictionary:(NSDictionary*)dic;
- (void)updateWithJSonDictionary:(NSDictionary*)dic;
+ (UserInfoModel*)dataWithJsonDictionary:(NSDictionary*)dic;

@end
