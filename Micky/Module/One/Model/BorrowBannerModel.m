//
//  BorrowBannerModel.m
//  MickyEasyCredit
//
//  Created by 张宁 on 2017/4/15.
//  Copyright © 2017年 apple. All rights reserved.
//

#import "BorrowBannerModel.h"

@implementation BorrowBannerModel
@synthesize   name;
@synthesize   jkAmount;

- (BorrowBannerModel *)initWithJsonDictionary:(NSDictionary*)dic
{
    self = [super init];
    [self updateWithJSonDictionary:dic];
    return self;
}
- (void)updateWithJSonDictionary:(NSDictionary*)dic
{
    name = [[dic objectForKey:@"name"] isEqual:NULL]?@"":[[dic objectForKey:@"name"] isEqual:nil]?@"":[[dic objectForKey:@"name"] isEqual:[NSNull null]]?@"":[[dic objectForKey:@"name"] isKindOfClass:[NSNull class]]?@"":[[dic objectForKey:@"name"] isKindOfClass:[NSNumber class]]?[NSString stringWithFormat:@"%d",[[dic objectForKey:@"name"] intValue]]:[dic objectForKey:@"name"];
    
    jkAmount = [[dic objectForKey:@"jkAmount"] isEqual:NULL]?@"":[[dic objectForKey:@"jkAmount"] isEqual:nil]?@"":[[dic objectForKey:@"jkAmount"] isEqual:[NSNull null]]?@"":[[dic objectForKey:@"jkAmount"] isKindOfClass:[NSNull class]]?@"":[[dic objectForKey:@"jkAmount"] isKindOfClass:[NSNumber class]]?[NSString stringWithFormat:@"%d",[[dic objectForKey:@"jkAmount"] intValue]]:[dic objectForKey:@"jkAmount"];
    
}
+ (BorrowBannerModel*)dataWithJsonDictionary:(NSDictionary*)dic
{
    BorrowBannerModel *u;
    u = [[BorrowBannerModel alloc] initWithJsonDictionary:dic];
    return u;
}

@end
