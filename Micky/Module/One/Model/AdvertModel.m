//
//  AdvertModel.m
//  MickyEasyCredit
//
//  Created by 张宁 on 2017/4/6.
//  Copyright © 2017年 apple. All rights reserved.
//

#import "AdvertModel.h"

@implementation AdvertModel
@synthesize   title;
@synthesize   imgurl;
@synthesize   Id;

- (AdvertModel *)initWithJsonDictionary:(NSDictionary*)dic
{
    self = [super init];
    [self updateWithJSonDictionary:dic];
    return self;
}
- (void)updateWithJSonDictionary:(NSDictionary*)dic
{
    title = [[dic objectForKey:@"title"] isEqual:NULL]?@"":[[dic objectForKey:@"title"] isEqual:nil]?@"":[[dic objectForKey:@"title"] isEqual:[NSNull null]]?@"":[[dic objectForKey:@"title"] isKindOfClass:[NSNull class]]?@"":[[dic objectForKey:@"title"] isKindOfClass:[NSNumber class]]?[NSString stringWithFormat:@"%d",[[dic objectForKey:@"title"] intValue]]:[dic objectForKey:@"title"];
    
    imgurl = [[dic objectForKey:@"imgurl"] isEqual:NULL]?@"":[[dic objectForKey:@"imgurl"] isEqual:nil]?@"":[[dic objectForKey:@"imgurl"] isEqual:[NSNull null]]?@"":[[dic objectForKey:@"imgurl"] isKindOfClass:[NSNull class]]?@"":[[dic objectForKey:@"imgurl"] isKindOfClass:[NSNumber class]]?[NSString stringWithFormat:@"%d",[[dic objectForKey:@"imgurl"] intValue]]:[dic objectForKey:@"imgurl"];
    
    Id = [[dic objectForKey:@"id"] isEqual:NULL]?@"":[[dic objectForKey:@"id"] isEqual:nil]?@"":[[dic objectForKey:@"id"] isEqual:[NSNull null]]?@"":[[dic objectForKey:@"id"] isKindOfClass:[NSNull class]]?@"":[[dic objectForKey:@"id"] isKindOfClass:[NSNumber class]]?[NSString stringWithFormat:@"%d",[[dic objectForKey:@"id"] intValue]]:[dic objectForKey:@"id"];
    
}
+ (AdvertModel*)dataWithJsonDictionary:(NSDictionary*)dic
{
    AdvertModel *u;
    u = [[AdvertModel alloc] initWithJsonDictionary:dic];
    return u;
}

@end
