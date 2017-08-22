//
//  PhotoAuthModel.m
//  MickyEasyCredit
//
//  Created by 张宁 on 2017/4/12.
//  Copyright © 2017年 apple. All rights reserved.
//

#import "PhotoAuthModel.h"

@implementation PhotoAuthModel
@synthesize   Id;
@synthesize   idCardFrontUrl;
@synthesize   idCardBackUrl;
@synthesize   idCardHandHeldUrl;
@synthesize   studentCardJobCardUrl;
@synthesize   schoolPageJobCardUrl;

- (PhotoAuthModel *)initWithJsonDictionary:(NSDictionary*)dic
{
    self = [super init];
    [self updateWithJSonDictionary:dic];
    return self;
}
- (void)updateWithJSonDictionary:(NSDictionary*)dic
{
    Id = [[dic objectForKey:@"id"] isEqual:NULL]?@"":[[dic objectForKey:@"id"] isEqual:nil]?@"":[[dic objectForKey:@"id"] isEqual:[NSNull null]]?@"":[[dic objectForKey:@"id"] isKindOfClass:[NSNull class]]?@"":[[dic objectForKey:@"id"] isKindOfClass:[NSNumber class]]?[NSString stringWithFormat:@"%d",[[dic objectForKey:@"id"] intValue]]:[dic objectForKey:@"id"];
    
    idCardFrontUrl = [[dic objectForKey:@"idCardFrontUrl"] isEqual:NULL]?@"":[[dic objectForKey:@"idCardFrontUrl"] isEqual:nil]?@"":[[dic objectForKey:@"idCardFrontUrl"] isEqual:[NSNull null]]?@"":[[dic objectForKey:@"idCardFrontUrl"] isKindOfClass:[NSNull class]]?@"":[[dic objectForKey:@"idCardFrontUrl"] isKindOfClass:[NSNumber class]]?[NSString stringWithFormat:@"%d",[[dic objectForKey:@"idCardFrontUrl"] intValue]]:[dic objectForKey:@"idCardFrontUrl"];
    
    idCardBackUrl = [[dic objectForKey:@"idCardBackUrl"] isEqual:NULL]?@"":[[dic objectForKey:@"idCardBackUrl"] isEqual:nil]?@"":[[dic objectForKey:@"idCardBackUrl"] isEqual:[NSNull null]]?@"":[[dic objectForKey:@"idCardBackUrl"] isKindOfClass:[NSNull class]]?@"":[[dic objectForKey:@"idCardBackUrl"] isKindOfClass:[NSNumber class]]?[NSString stringWithFormat:@"%d",[[dic objectForKey:@"idCardBackUrl"] intValue]]:[dic objectForKey:@"idCardBackUrl"];
    
    idCardHandHeldUrl = [[dic objectForKey:@"idCardHandHeldUrl"] isEqual:NULL]?@"":[[dic objectForKey:@"idCardHandHeldUrl"] isEqual:nil]?@"":[[dic objectForKey:@"idCardHandHeldUrl"] isEqual:[NSNull null]]?@"":[[dic objectForKey:@"idCardHandHeldUrl"] isKindOfClass:[NSNull class]]?@"":[[dic objectForKey:@"idCardHandHeldUrl"] isKindOfClass:[NSNumber class]]?[NSString stringWithFormat:@"%d",[[dic objectForKey:@"idCardHandHeldUrl"] intValue]]:[dic objectForKey:@"idCardHandHeldUrl"];
    
    studentCardJobCardUrl = [[dic objectForKey:@"studentCardJobCardUrl"] isEqual:NULL]?@"":[[dic objectForKey:@"studentCardJobCardUrl"] isEqual:nil]?@"":[[dic objectForKey:@"photoStatus"] isEqual:[NSNull null]]?@"":[[dic objectForKey:@"studentCardJobCardUrl"] isKindOfClass:[NSNull class]]?@"":[[dic objectForKey:@"studentCardJobCardUrl"] isKindOfClass:[NSNumber class]]?[NSString stringWithFormat:@"%d",[[dic objectForKey:@"studentCardJobCardUrl"] intValue]]:[dic objectForKey:@"studentCardJobCardUrl"];
    
    schoolPageJobCardUrl = [[dic objectForKey:@"schoolPageJobCardUrl"] isEqual:NULL]?@"":[[dic objectForKey:@"schoolPageJobCardUrl"] isEqual:nil]?@"":[[dic objectForKey:@"schoolPageJobCardUrl"] isEqual:[NSNull null]]?@"":[[dic objectForKey:@"schoolPageJobCardUrl"] isKindOfClass:[NSNull class]]?@"":[[dic objectForKey:@"schoolPageJobCardUrl"] isKindOfClass:[NSNumber class]]?[NSString stringWithFormat:@"%d",[[dic objectForKey:@"schoolPageJobCardUrl"] intValue]]:[dic objectForKey:@"schoolPageJobCardUrl"];

}
+ (PhotoAuthModel*)dataWithJsonDictionary:(NSDictionary*)dic
{
    PhotoAuthModel *u;
    u = [[PhotoAuthModel alloc] initWithJsonDictionary:dic];
    return u;
}

@end
