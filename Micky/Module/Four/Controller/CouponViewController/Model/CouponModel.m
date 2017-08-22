//
//  CouponModel.m
//  MickyEasyCredit
//
//  Created by 张宁 on 2017/5/11.
//  Copyright © 2017年 apple. All rights reserved.
//

#import "CouponModel.h"

@implementation CouponModel

@synthesize  Id;
@synthesize  name;
@synthesize  endDate;
@synthesize  startDate;
@synthesize  noCount;
@synthesize  yesCount;
@synthesize  expiredCount;


- (CouponModel *)initWithJsonDictionary:(NSDictionary*)dic
{
    self = [super init];
    [self updateWithJSonDictionary:dic];
    return self;
}
- (void)updateWithJSonDictionary:(NSDictionary*)dic
{
    Id = [[dic objectForKey:@"id"] isEqual:NULL]?@"":[[dic objectForKey:@"id"] isEqual:nil]?@"":[[dic objectForKey:@"id"] isEqual:[NSNull null]]?@"":[[dic objectForKey:@"id"] isKindOfClass:[NSNull class]]?@"":[[dic objectForKey:@"id"] isKindOfClass:[NSNumber class]]?[NSString stringWithFormat:@"%d",[[dic objectForKey:@"id"] intValue]]:[dic objectForKey:@"id"];
    
    name = [[dic objectForKey:@"name"] isEqual:NULL]?@"":[[dic objectForKey:@"name"] isEqual:nil]?@"":[[dic objectForKey:@"name"] isEqual:[NSNull null]]?@"":[[dic objectForKey:@"name"] isKindOfClass:[NSNull class]]?@"":[[dic objectForKey:@"name"] isKindOfClass:[NSNumber class]]?[NSString stringWithFormat:@"%d",[[dic objectForKey:@"name"] intValue]]:[dic objectForKey:@"name"];
    
    endDate = [[dic objectForKey:@"endDate"] isEqual:NULL]?@"":[[dic objectForKey:@"endDate"] isEqual:nil]?@"":[[dic objectForKey:@"endDate"] isEqual:[NSNull null]]?@"":[[dic objectForKey:@"endDate"] isKindOfClass:[NSNull class]]?@"":[[dic objectForKey:@"endDate"] isKindOfClass:[NSNumber class]]?[NSString stringWithFormat:@"%d",[[dic objectForKey:@"endDate"] intValue]]:[dic objectForKey:@"endDate"];
    
    startDate = [[dic objectForKey:@"startDate"] isEqual:NULL]?@"":[[dic objectForKey:@"startDate"] isEqual:nil]?@"":[[dic objectForKey:@"startDate"] isEqual:[NSNull null]]?@"":[[dic objectForKey:@"startDate"] isKindOfClass:[NSNull class]]?@"":[[dic objectForKey:@"startDate"] isKindOfClass:[NSNumber class]]?[NSString stringWithFormat:@"%d",[[dic objectForKey:@"startDate"] intValue]]:[dic objectForKey:@"startDate"];
    
    noCount = [[dic objectForKey:@"noCount"] isEqual:NULL]?@"":[[dic objectForKey:@"noCount"] isEqual:nil]?@"":[[dic objectForKey:@"noCount"] isEqual:[NSNull null]]?@"":[[dic objectForKey:@"noCount"] isKindOfClass:[NSNull class]]?@"":[[dic objectForKey:@"noCount"] isKindOfClass:[NSNumber class]]?[NSString stringWithFormat:@"%d",[[dic objectForKey:@"noCount"] intValue]]:[dic objectForKey:@"noCount"];
    
    yesCount = [[dic objectForKey:@"yesCount"] isEqual:NULL]?@"":[[dic objectForKey:@"yesCount"] isEqual:nil]?@"":[[dic objectForKey:@"yesCount"] isEqual:[NSNull null]]?@"":[[dic objectForKey:@"yesCount"] isKindOfClass:[NSNull class]]?@"":[[dic objectForKey:@"yesCount"] isKindOfClass:[NSNumber class]]?[NSString stringWithFormat:@"%d",[[dic objectForKey:@"yesCount"] intValue]]:[dic objectForKey:@"yesCount"];
    
    expiredCount = [[dic objectForKey:@"expiredCount"] isEqual:NULL]?@"":[[dic objectForKey:@"expiredCount"] isEqual:nil]?@"":[[dic objectForKey:@"expiredCount"] isEqual:[NSNull null]]?@"":[[dic objectForKey:@"expiredCount"] isKindOfClass:[NSNull class]]?@"":[[dic objectForKey:@"expiredCount"] isKindOfClass:[NSNumber class]]?[NSString stringWithFormat:@"%d",[[dic objectForKey:@"expiredCount"] intValue]]:[dic objectForKey:@"expiredCount"];

}
+ (CouponModel*)dataWithJsonDictionary:(NSDictionary*)dic
{
    CouponModel *u;
    u = [[CouponModel alloc] initWithJsonDictionary:dic];
    return u;
}

@end
