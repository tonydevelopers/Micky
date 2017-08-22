//
//  ECPOrderGlobal.m
//  ECPayMobileSDK iOS Example
//
//  Created by 歐付寶 on 2014/11/2.
//  Copyright (c) 2014年 歐付寶. All rights reserved.
//

#import "ECPGlobal.h"

static ECPEnvironment _environment = ECPEnvironment_PRODUCT;

@implementation ECPGlobal

+ (ECPEnvironment) environment { return _environment; }
+ (void) setEnvironment:(ECPEnvironment )value { _environment = value; }

@end
