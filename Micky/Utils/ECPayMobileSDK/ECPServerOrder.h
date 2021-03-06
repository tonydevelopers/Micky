//
//  ECPServerOrder.h
//  ECPayMobileSDK iOS Example
//
//  Created by 歐付寶 on 2014/11/2.
//  Copyright (c) 2014年 歐付寶. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "AFNetworking.h"

@interface ECPServerOrder : NSObject

+(NSString *)getAPIURLString;

+(AFHTTPSessionManager *)create:(id)parameters
                                  action:(void (^)(id responseObject, NSError *error))block;


+(AFHTTPSessionManager *)otp:(id)parameters
                               action:(void (^)(id responseObject, NSError *error))block;
@end
