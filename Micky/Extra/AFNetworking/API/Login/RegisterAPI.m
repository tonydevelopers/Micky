//
//  RegisterAPI.m
//  NewStock
//
//  Created by Willey on 16/7/22.
//  Copyright © 2016年 Willey. All rights reserved.
//

#import "RegisterAPI.h"
#import "Defination.h"

@implementation RegisterAPI{
    NSString *_username;
    NSString *_password;
}

- (id)initWithUsername:(NSString *)username password:(NSString *)password {
    self = [super init];
    if (self) {
        _username = username;
        _password = password;
    }
    return self;
}

- (NSString *)requestUrl {
//    return API_ACCOUNT_REGISITER;
    return nil;

}

- (APIRequestMethod)requestMethod {
    return APIRequestMethodPost;
}

- (id)requestArgument {
    return @{
             @"username": _username,
             @"password": _password
             };
}

- (id)jsonValidator {
    return @{
             @"userId": [NSNumber class],
             @"nick": [NSString class],
             @"level": [NSNumber class]
             };
}

- (NSString *)userId {
    
    return [[[self responseJSONObject] objectForKey:@"userId"] stringValue];
}


@end
