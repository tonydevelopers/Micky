//
//  ECPServerOrder.m
//  ECPayMobileSDK iOS Example
//
//  Created by 歐付寶 on 2014/11/2.
//  Copyright (c) 2014年 歐付寶. All rights reserved.
//

#import "ECPServerOrder.h"
#import "ECPGlobal.h"



#define ECP_STAGE_ServerOrder_URL_STRING @"https://payment-stage.ecpay.com.tw/Mobile/CreateServerOrder"
#define ECP_PRODUCT_ServerOrder_URL_STRING @"https://payment.ecpay.com.tw/Mobile/CreateServerOrder"

#define ECP_STAGE_VerifyOtpCode_URL_STRING @"https://payment-stage.ecpay.com.tw/Mobile/VerifyOtpCode"
#define ECP_PRODUCT_VerifyOtpCode_URL_STRING @"https://payment.ecpay.com.tw/Mobile/VerifyOtpCode"


@implementation ECPServerOrder


+(NSString *)getAPIURLString
{
    NSString *urlString = ECP_PRODUCT_ServerOrder_URL_STRING;
    if ([ECPGlobal environment] == ECPEnvironment_STAGE) {
        urlString = ECP_STAGE_ServerOrder_URL_STRING;
    }
    return urlString;
}

+(NSString *)getOTPURLString
{
    NSString *urlString = ECP_PRODUCT_VerifyOtpCode_URL_STRING;
    if ([ECPGlobal environment] == ECPEnvironment_STAGE) {
        urlString = ECP_STAGE_VerifyOtpCode_URL_STRING;
    }
    return urlString;
}


+(AFHTTPSessionManager *)create:(id)parameters
                                  action:(void (^)(id responseObject, NSError *error))block {
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    
    NSString *path = [self getAPIURLString];
    manager.responseSerializer.acceptableContentTypes =[[NSSet alloc] initWithObjects: @"text/html",@"text/plain", nil];
    manager.requestSerializer.cachePolicy = NSURLRequestReloadIgnoringLocalAndRemoteCacheData;
    
    [manager POST:path
       parameters:parameters
         progress:nil
          success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        if ([responseObject objectForKey:@"RtnCode"] !=nil) {
            if (block) {
                block(responseObject, nil);
            }
        }else{
            if (block) {
                NSMutableDictionary* details = [NSMutableDictionary dictionary];
                [details setValue:@"Parse Error" forKey:NSLocalizedDescriptionKey];
                
                NSError *error = [NSError errorWithDomain:@"tw.com.allpay.app.ECPOrderSDK" code:1000 userInfo:details];
                
                block(nil, error);
            }
        }
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        if (block) {
            block(nil, error);
        }
    }];
    
    return manager;
}

+(AFHTTPSessionManager *)otp:(id)parameters
                                  action:(void (^)(id responseObject, NSError *error))block {
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    
    NSString *path = [self getOTPURLString];
    manager.responseSerializer.acceptableContentTypes =[[NSSet alloc] initWithObjects: @"text/html",@"text/plain", nil];
    manager.requestSerializer.cachePolicy = NSURLRequestReloadIgnoringLocalAndRemoteCacheData;
    
    [manager POST:path
       parameters:parameters
         progress:nil
          success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        if ([responseObject objectForKey:@"RtnCode"] !=nil) {
            if (block) {
                block(responseObject, nil);
            }
        }else{
            if (block) {
                NSMutableDictionary* details = [NSMutableDictionary dictionary];
                [details setValue:@"Parse Error" forKey:NSLocalizedDescriptionKey];
                
                NSError *error = [NSError errorWithDomain:@"tw.com.allpay.app.ECPOrderSDK" code:2000 userInfo:details];
                
                block(nil, error);
            }
        }
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        if (block) {
            block(nil, error);
        }
    }];
    
    return manager;
}

@end
