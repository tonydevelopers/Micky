//
//  News_Model.h
//  MickyEasyCredit
//
//  Created by 张宁 on 2017/4/6.
//  Copyright © 2017年 apple. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NewsModel : NSObject

@property(nonatomic,strong)NSString *msgContent;
@property(nonatomic,strong)NSString *msgType;
@property(nonatomic,strong)NSString *createDate;

- (NewsModel*)initWithJsonDictionary:(NSDictionary*)dic;
- (void)updateWithJSonDictionary:(NSDictionary*)dic;
+ (NewsModel*)dataWithJsonDictionary:(NSDictionary*)dic;

@end
