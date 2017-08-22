//
//  MetaData.m
//  91credit
//
//  Created by dev002 on 26/4/16.
//  Copyright © 2016年 Mosjoy. All rights reserved.
//

#import "MetaData.h"

@implementation MetaData
static NSDictionary *_address;
+(NSDictionary *)address
{
    if (!_address) {
        _address = [NSDictionary dictionaryWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"address.plist" ofType:nil]];
    }
    return _address;
}

static NSMutableArray *_cityGroups;
+(NSArray *)cityGroups
{
    if (!_cityGroups) {
        _cityGroups = [NSMutableArray arrayWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"cityGroups.plist" ofType:nil]];
    }
    return _cityGroups;
}
@end
