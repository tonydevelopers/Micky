//
//  AdvertModel.h
//  MickyEasyCredit
//
//  Created by 张宁 on 2017/4/6.
//  Copyright © 2017年 apple. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface AdvertModel : NSObject

@property(nonatomic,strong)NSString *Id;
@property(nonatomic,strong)NSString *title;
@property(nonatomic,strong)NSString *imgurl;

- (AdvertModel*)initWithJsonDictionary:(NSDictionary*)dic;
- (void)updateWithJSonDictionary:(NSDictionary*)dic;
+ (AdvertModel*)dataWithJsonDictionary:(NSDictionary*)dic;

@end
