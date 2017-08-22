//
//  AuthenticationModel.m
//  MickyEasyCredit
//
//  Created by 张宁 on 2017/4/8.
//  Copyright © 2017年 apple. All rights reserved.
//

#import "AuthenticationModel.h"

@implementation AuthenticationModel

@synthesize   personalStatus;
@synthesize   educationStatus;
@synthesize   contactStatus;
@synthesize   photoStatus;
@synthesize   bankCardStatus;
@synthesize   internetStatus;
@synthesize   phoneStatus;
@synthesize   learnStatus;


- (AuthenticationModel *)initWithJsonDictionary:(NSDictionary*)dic
{
    self = [super init];
    [self updateWithJSonDictionary:dic];
    return self;
}
- (void)updateWithJSonDictionary:(NSDictionary*)dic
{
    personalStatus = [[dic objectForKey:@"personalStatus"] isEqual:NULL]?@"":[[dic objectForKey:@"personalStatus"] isEqual:nil]?@"":[[dic objectForKey:@"personalStatus"] isEqual:[NSNull null]]?@"":[[dic objectForKey:@"personalStatus"] isKindOfClass:[NSNull class]]?@"":[[dic objectForKey:@"personalStatus"] isKindOfClass:[NSNumber class]]?[NSString stringWithFormat:@"%d",[[dic objectForKey:@"personalStatus"] intValue]]:[dic objectForKey:@"personalStatus"];
    
    educationStatus = [[dic objectForKey:@"educationStatus"] isEqual:NULL]?@"":[[dic objectForKey:@"educationStatus"] isEqual:nil]?@"":[[dic objectForKey:@"educationStatus"] isEqual:[NSNull null]]?@"":[[dic objectForKey:@"educationStatus"] isKindOfClass:[NSNull class]]?@"":[[dic objectForKey:@"educationStatus"] isKindOfClass:[NSNumber class]]?[NSString stringWithFormat:@"%d",[[dic objectForKey:@"educationStatus"] intValue]]:[dic objectForKey:@"educationStatus"];
    
    contactStatus = [[dic objectForKey:@"contactStatus"] isEqual:NULL]?@"":[[dic objectForKey:@"contactStatus"] isEqual:nil]?@"":[[dic objectForKey:@"contactStatus"] isEqual:[NSNull null]]?@"":[[dic objectForKey:@"contactStatus"] isKindOfClass:[NSNull class]]?@"":[[dic objectForKey:@"contactStatus"] isKindOfClass:[NSNumber class]]?[NSString stringWithFormat:@"%d",[[dic objectForKey:@"contactStatus"] intValue]]:[dic objectForKey:@"contactStatus"];
    
    photoStatus = [[dic objectForKey:@"photoStatus"] isEqual:NULL]?@"":[[dic objectForKey:@"photoStatus"] isEqual:nil]?@"":[[dic objectForKey:@"photoStatus"] isEqual:[NSNull null]]?@"":[[dic objectForKey:@"photoStatus"] isKindOfClass:[NSNull class]]?@"":[[dic objectForKey:@"photoStatus"] isKindOfClass:[NSNumber class]]?[NSString stringWithFormat:@"%d",[[dic objectForKey:@"photoStatus"] intValue]]:[dic objectForKey:@"photoStatus"];
    
    bankCardStatus = [[dic objectForKey:@"bankCardStatus"] isEqual:NULL]?@"":[[dic objectForKey:@"bankCardStatus"] isEqual:nil]?@"":[[dic objectForKey:@"bankCardStatus"] isEqual:[NSNull null]]?@"":[[dic objectForKey:@"bankCardStatus"] isKindOfClass:[NSNull class]]?@"":[[dic objectForKey:@"bankCardStatus"] isKindOfClass:[NSNumber class]]?[NSString stringWithFormat:@"%d",[[dic objectForKey:@"bankCardStatus"] intValue]]:[dic objectForKey:@"bankCardStatus"];

    internetStatus = [[dic objectForKey:@"internetStatus"] isEqual:NULL]?@"":[[dic objectForKey:@"internetStatus"] isEqual:nil]?@"":[[dic objectForKey:@"internetStatus"] isEqual:[NSNull null]]?@"":[[dic objectForKey:@"internetStatus"] isKindOfClass:[NSNull class]]?@"":[[dic objectForKey:@"internetStatus"] isKindOfClass:[NSNumber class]]?[NSString stringWithFormat:@"%d",[[dic objectForKey:@"internetStatus"] intValue]]:[dic objectForKey:@"internetStatus"];

    phoneStatus = [[dic objectForKey:@"phoneStatus"] isEqual:NULL]?@"":[[dic objectForKey:@"phoneStatus"] isEqual:nil]?@"":[[dic objectForKey:@"phoneStatus"] isEqual:[NSNull null]]?@"":[[dic objectForKey:@"phoneStatus"] isKindOfClass:[NSNull class]]?@"":[[dic objectForKey:@"phoneStatus"] isKindOfClass:[NSNumber class]]?[NSString stringWithFormat:@"%d",[[dic objectForKey:@"phoneStatus"] intValue]]:[dic objectForKey:@"phoneStatus"];
    
    learnStatus = [[dic objectForKey:@"learnStatus"] isEqual:NULL]?@"":[[dic objectForKey:@"learnStatus"] isEqual:nil]?@"":[[dic objectForKey:@"learnStatus"] isEqual:[NSNull null]]?@"":[[dic objectForKey:@"learnStatus"] isKindOfClass:[NSNull class]]?@"":[[dic objectForKey:@"learnStatus"] isKindOfClass:[NSNumber class]]?[NSString stringWithFormat:@"%d",[[dic objectForKey:@"learnStatus"] intValue]]:[dic objectForKey:@"learnStatus"];
    
}
+ (AuthenticationModel*)dataWithJsonDictionary:(NSDictionary*)dic
{
    AuthenticationModel *u;
    u = [[AuthenticationModel alloc] initWithJsonDictionary:dic];
    return u;
}


@end
