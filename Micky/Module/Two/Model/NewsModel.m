//
//  News_Model.m
//  MickyEasyCredit
//
//  Created by 张宁 on 2017/4/6.
//  Copyright © 2017年 apple. All rights reserved.
//

#import "NewsModel.h"

@implementation NewsModel

@synthesize   msgContent;
@synthesize   msgType;
@synthesize   createDate;

- (NewsModel *)initWithJsonDictionary:(NSDictionary*)dic
{
    self = [super init];
    [self updateWithJSonDictionary:dic];
    return self;
}
- (void)updateWithJSonDictionary:(NSDictionary*)dic
{
    msgContent = [[dic objectForKey:@"msgContent"] isEqual:NULL]?@"":[[dic objectForKey:@"msgContent"] isEqual:nil]?@"":[[dic objectForKey:@"msgContent"] isEqual:[NSNull null]]?@"":[[dic objectForKey:@"msgContent"] isKindOfClass:[NSNull class]]?@"":[[dic objectForKey:@"msgContent"] isKindOfClass:[NSNumber class]]?[NSString stringWithFormat:@"%d",[[dic objectForKey:@"msgContent"] intValue]]:[dic objectForKey:@"msgContent"];
    
    msgType = [[dic objectForKey:@"msgType"] isEqual:NULL]?@"":[[dic objectForKey:@"msgType"] isEqual:nil]?@"":[[dic objectForKey:@"msgType"] isEqual:[NSNull null]]?@"":[[dic objectForKey:@"msgType"] isKindOfClass:[NSNull class]]?@"":[[dic objectForKey:@"msgType"] isKindOfClass:[NSNumber class]]?[NSString stringWithFormat:@"%d",[[dic objectForKey:@"msgType"] intValue]]:[dic objectForKey:@"msgType"];
    
    createDate = [[dic objectForKey:@"createDate"] isEqual:NULL]?@"":[[dic objectForKey:@"createDate"] isEqual:nil]?@"":[[dic objectForKey:@"createDate"] isEqual:[NSNull null]]?@"":[[dic objectForKey:@"createDate"] isKindOfClass:[NSNull class]]?@"":[[dic objectForKey:@"createDate"] isKindOfClass:[NSNumber class]]?[NSString stringWithFormat:@"%d",[[dic objectForKey:@"createDate"] intValue]]:[dic objectForKey:@"createDate"];
    
}
+ (NewsModel*)dataWithJsonDictionary:(NSDictionary*)dic
{
    NewsModel *u;
    u = [[NewsModel alloc] initWithJsonDictionary:dic];
    return u;
}


@end
