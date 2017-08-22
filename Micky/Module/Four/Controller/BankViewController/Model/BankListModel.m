//
//  BankListModel.m
//  MickyEasyCredit
//
//  Created by 张宁 on 2017/5/11.
//  Copyright © 2017年 apple. All rights reserved.
//

#import "BankListModel.h"

@implementation BankListModel

@synthesize  cardName;
@synthesize  cardNo;
@synthesize  bindNo;
@synthesize  cardId;
@synthesize  phone;
@synthesize  icon;

- (BankListModel *)initWithJsonDictionary:(NSDictionary*)dic
{
    self = [super init];
    [self updateWithJSonDictionary:dic];
    return self;
}
- (void)updateWithJSonDictionary:(NSDictionary*)dic
{
    cardName = [[dic objectForKey:@"cardName"] isEqual:NULL]?@"":[[dic objectForKey:@"cardName"] isEqual:nil]?@"":[[dic objectForKey:@"cardName"] isEqual:[NSNull null]]?@"":[[dic objectForKey:@"cardName"] isKindOfClass:[NSNull class]]?@"":[[dic objectForKey:@"cardName"] isKindOfClass:[NSNumber class]]?[NSString stringWithFormat:@"%d",[[dic objectForKey:@"cardName"] intValue]]:[dic objectForKey:@"cardName"];
    
    cardNo = [[dic objectForKey:@"cardNo"] isEqual:NULL]?@"":[[dic objectForKey:@"cardNo"] isEqual:nil]?@"":[[dic objectForKey:@"cardNo"] isEqual:[NSNull null]]?@"":[[dic objectForKey:@"cardNo"] isKindOfClass:[NSNull class]]?@"":[[dic objectForKey:@"cardNo"] isKindOfClass:[NSNumber class]]?[NSString stringWithFormat:@"%d",[[dic objectForKey:@"cardNo"] intValue]]:[dic objectForKey:@"cardNo"];
    
    bindNo = [[dic objectForKey:@"bindNo"] isEqual:NULL]?@"":[[dic objectForKey:@"bindNo"] isEqual:nil]?@"":[[dic objectForKey:@"bindNo"] isEqual:[NSNull null]]?@"":[[dic objectForKey:@"bindNo"] isKindOfClass:[NSNull class]]?@"":[[dic objectForKey:@"bindNo"] isKindOfClass:[NSNumber class]]?[NSString stringWithFormat:@"%d",[[dic objectForKey:@"bindNo"] intValue]]:[dic objectForKey:@"bindNo"];
    
    cardId = [[dic objectForKey:@"cardId"] isEqual:NULL]?@"":[[dic objectForKey:@"cardId"] isEqual:nil]?@"":[[dic objectForKey:@"cardId"] isEqual:[NSNull null]]?@"":[[dic objectForKey:@"cardId"] isKindOfClass:[NSNull class]]?@"":[[dic objectForKey:@"cardId"] isKindOfClass:[NSNumber class]]?[NSString stringWithFormat:@"%d",[[dic objectForKey:@"cardId"] intValue]]:[dic objectForKey:@"cardId"];
    
    phone = [[dic objectForKey:@"phone"] isEqual:NULL]?@"":[[dic objectForKey:@"phone"] isEqual:nil]?@"":[[dic objectForKey:@"phone"] isEqual:[NSNull null]]?@"":[[dic objectForKey:@"phone"] isKindOfClass:[NSNull class]]?@"":[[dic objectForKey:@"phone"] isKindOfClass:[NSNumber class]]?[NSString stringWithFormat:@"%d",[[dic objectForKey:@"phone"] intValue]]:[dic objectForKey:@"phone"];
    
    icon = [[dic objectForKey:@"icon"] isEqual:NULL]?@"":[[dic objectForKey:@"icon"] isEqual:nil]?@"":[[dic objectForKey:@"icon"] isEqual:[NSNull null]]?@"":[[dic objectForKey:@"icon"] isKindOfClass:[NSNull class]]?@"":[[dic objectForKey:@"icon"] isKindOfClass:[NSNumber class]]?[NSString stringWithFormat:@"%d",[[dic objectForKey:@"icon"] intValue]]:[dic objectForKey:@"icon"];
    
}
+ (BankListModel*)dataWithJsonDictionary:(NSDictionary*)dic
{
    BankListModel *u;
    u = [[BankListModel alloc] initWithJsonDictionary:dic];
    return u;
}


@end
