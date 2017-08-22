//
//  AuthenticationModel.h
//  MickyEasyCredit
//
//  Created by 张宁 on 2017/4/8.
//  Copyright © 2017年 apple. All rights reserved.
//

#import <Foundation/Foundation.h>


@interface AuthenticationModel : NSObject

@property(nonatomic,strong)NSString *personalStatus;
@property(nonatomic,strong)NSString *educationStatus;
@property(nonatomic,strong)NSString *contactStatus;
@property(nonatomic,strong)NSString *photoStatus;
@property(nonatomic,strong)NSString *bankCardStatus;
@property(nonatomic,strong)NSString *internetStatus;
@property(nonatomic,strong)NSString *phoneStatus;
@property(nonatomic,strong)NSString *learnStatus;
- (AuthenticationModel*)initWithJsonDictionary:(NSDictionary*)dic;
- (void)updateWithJSonDictionary:(NSDictionary*)dic;
+ (AuthenticationModel*)dataWithJsonDictionary:(NSDictionary*)dic;

@end
