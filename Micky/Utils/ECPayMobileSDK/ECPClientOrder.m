//
//  ClientOrder.m
//  ECPayMobileSDK iOS Example
//
//  Created by 歐付寶 on 2014/10/30.
//  Copyright (c) 2014年 歐付寶. All rights reserved.
//

#import "ECPClientOrder.h"
#import "ECPGlobal.h"
#import "ECPWebViewCtrl.h"




#define ECP_STAGE_ClientOrder_URL_STRING @"https://payment-stage.ecpay.com.tw/Mobile/CreateClientOrder/V2"
#define ECP_PRODUCT_ClientOrder_URL_STRING @"https://payment.ecpay.com.tw/Mobile/CreateClientOrder/V2"


@implementation ECPClientOrder


+(void)getWebViewWithAttributes:(NSDictionary *)attributes
{
    [ECPWebViewCtrl getWebViewWithURL:[self getAPIURLString] attributes:attributes];
}


+(NSString *)getAPIURLString
{
    NSString *urlString = ECP_PRODUCT_ClientOrder_URL_STRING;
    if ([ECPGlobal environment] == ECPEnvironment_STAGE) {
        urlString = ECP_STAGE_ClientOrder_URL_STRING;
    }
    return urlString;
}


@end

