//
//  UserInfoModel.m
//  MickyEasyCredit
//
//  Created by 张宁 on 2017/4/7.
//  Copyright © 2017年 apple. All rights reserved.
//

#import "UserInfoModel.h"

@implementation UserInfoModel

@synthesize creditesFee;
@synthesize bonusAmout;
@synthesize faceImg;
@synthesize phone;
@synthesize name;

- (UserInfoModel *)initWithJsonDictionary:(NSDictionary*)dic
{
    self = [super init];
    [self updateWithJSonDictionary:dic];
    return self;
}
- (void)updateWithJSonDictionary:(NSDictionary*)dic
{
    creditesFee = [[dic objectForKey:@"creditesFee"] isEqual:NULL]?@"":[[dic objectForKey:@"creditesFee"] isEqual:nil]?@"":[[dic objectForKey:@"creditesFee"] isEqual:[NSNull null]]?@"":[[dic objectForKey:@"creditesFee"] isKindOfClass:[NSNull class]]?@"":[[dic objectForKey:@"creditesFee"] isKindOfClass:[NSNumber class]]?[NSString stringWithFormat:@"%d",[[dic objectForKey:@"creditesFee"] intValue]]:[dic objectForKey:@"creditesFee"];
    
    bonusAmout = [[dic objectForKey:@"bonusAmout"] isEqual:NULL]?@"":[[dic objectForKey:@"bonusAmout"] isEqual:nil]?@"":[[dic objectForKey:@"bonusAmout"] isEqual:[NSNull null]]?@"":[[dic objectForKey:@"bonusAmout"] isKindOfClass:[NSNull class]]?@"":[[dic objectForKey:@"bonusAmout"] isKindOfClass:[NSNumber class]]?[NSString stringWithFormat:@"%d",[[dic objectForKey:@"bonusAmout"] intValue]]:[dic objectForKey:@"bonusAmout"];
    
    faceImg = [[dic objectForKey:@"faceImg"] isEqual:NULL]?@"":[[dic objectForKey:@"faceImg"] isEqual:nil]?@"":[[dic objectForKey:@"faceImg"] isEqual:[NSNull null]]?@"":[[dic objectForKey:@"faceImg"] isKindOfClass:[NSNull class]]?@"":[[dic objectForKey:@"faceImg"] isKindOfClass:[NSNumber class]]?[NSString stringWithFormat:@"%d",[[dic objectForKey:@"faceImg"] intValue]]:[dic objectForKey:@"faceImg"];
    
    phone = [[dic objectForKey:@"phone"] isEqual:NULL]?@"":[[dic objectForKey:@"phone"] isEqual:nil]?@"":[[dic objectForKey:@"phone"] isEqual:[NSNull null]]?@"":[[dic objectForKey:@"phone"] isKindOfClass:[NSNull class]]?@"":[[dic objectForKey:@"phone"] isKindOfClass:[NSNumber class]]?[NSString stringWithFormat:@"%d",[[dic objectForKey:@"phone"] intValue]]:[dic objectForKey:@"phone"];

    name = [[dic objectForKey:@"name"] isEqual:NULL]?@"":[[dic objectForKey:@"name"] isEqual:nil]?@"":[[dic objectForKey:@"name"] isEqual:[NSNull null]]?@"":[[dic objectForKey:@"name"] isKindOfClass:[NSNull class]]?@"":[[dic objectForKey:@"name"] isKindOfClass:[NSNumber class]]?[NSString stringWithFormat:@"%d",[[dic objectForKey:@"name"] intValue]]:[dic objectForKey:@"name"];

}
+ (UserInfoModel*)dataWithJsonDictionary:(NSDictionary*)dic
{
    UserInfoModel *u;
    u = [[UserInfoModel alloc] initWithJsonDictionary:dic];
    return u;
}


@end
