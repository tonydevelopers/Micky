//
//  NSDictionary+String.m
//  Micky
//
//  Created by tony on 2017/8/22.
//  Copyright © 2017年 apple. All rights reserved.
//

#import "NSDictionary+String.h"

@implementation NSDictionary (String)

-(NSString *) urlParams {
    
    NSArray * keys = [self.allKeys sortedArrayUsingComparator:^NSComparisonResult(NSString*  _Nonnull obj1, NSString*  _Nonnull obj2) {
        
        return [obj1 compare:obj2];
    }];
    
    NSMutableString * result = [[NSMutableString alloc] initWithString:@""];
    
    for (int i = 0; i < keys.count; i++) {
        
        NSString * key = [keys objectAtIndex:i];
        
        [result appendString:key];
        [result appendString:@"="];
        [result appendString:[self objectForKey:key]];
        
        if (i < keys.count - 1) {
            [result appendString:@"&"];
        }
    }
    
    return result;
}

@end
