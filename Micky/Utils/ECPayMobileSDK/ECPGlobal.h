//
//  ECPOrderGlobal.h
//  ECPayMobileSDK iOS Example
//
//  Created by 歐付寶 on 2014/11/2.
//  Copyright (c) 2014年 歐付寶. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef enum {
    ECPEnvironment_STAGE = 0,
    ECPEnvironment_PRODUCT
    
} ECPEnvironment;



@interface ECPGlobal : NSObject

// ---------------------------
// * environment 運行的環境
// APEnvironment_STAGE 測試環境
// APEnvironment_PRODUCT 正式環境
// ---------------------------
+ (ECPEnvironment) environment;
+ (void) setEnvironment:(ECPEnvironment )value;


@end
