//
//  RegisterAPI.h
//  NewStock
//
//  Created by Willey on 16/7/22.
//  Copyright © 2016年 Willey. All rights reserved.
//

#import "APIRequest.h"

@interface RegisterAPI : APIRequest

- (id)initWithUsername:(NSString *)username password:(NSString *)password;

- (NSString *)userId;

@end
