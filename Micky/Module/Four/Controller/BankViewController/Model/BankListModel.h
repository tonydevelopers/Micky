//
//  BankListModel.h
//  MickyEasyCredit
//
//  Created by 张宁 on 2017/5/11.
//  Copyright © 2017年 apple. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface BankListModel : NSObject

@property(nonatomic,strong)NSString *cardName;
@property(nonatomic,strong)NSString *cardNo;
@property(nonatomic,strong)NSString *bindNo;
@property(nonatomic,strong)NSString *cardId;
@property(nonatomic,strong)NSString *phone;
@property(nonatomic,strong)NSString *icon;
- (BankListModel*)initWithJsonDictionary:(NSDictionary*)dic;
- (void)updateWithJSonDictionary:(NSDictionary*)dic;
+ (BankListModel*)dataWithJsonDictionary:(NSDictionary*)dic;

@end
