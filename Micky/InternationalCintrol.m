//
//  InternationalCintrol.m
//  MyInternatinal
//
//  Created by 张宁 on 2016/11/14.
//  Copyright © 2016年 apple. All rights reserved.
//

#import "InternationalCintrol.h"

@implementation InternationalCintrol

static NSBundle *bundle = nil;

+ ( NSBundle * )bundle{
    
    return bundle;
    
}

+(NSString *)userLanguage{
    NSArray *languages = [NSLocale preferredLanguages];
    NSString *language = [languages objectAtIndex:0];
    NSLog(@"当前语言%@", language);
    return language;
}

+(void)initUserLanguage{
    
    NSUserDefaults *def = [NSUserDefaults standardUserDefaults];
    
    NSString *string = [def valueForKey:@"userLanguage"];
    
    if(string.length == 0){
        
        //获取系统当前语言版本(中文zh-Hans,英文en)
        
        NSArray* languages = [def objectForKey:@"AppleLanguages"];
        
        NSString *current = [languages objectAtIndex:0];
        
        string = current;
        
        [def setValue:current forKey:@"userLanguage"];
        
        [def synchronize];//持久化，不加的话不会保存
    }
    
    //获取文件路径
    NSString *path = [[NSBundle mainBundle] pathForResource:string ofType:@"lproj"];
    
    bundle = [NSBundle bundleWithPath:path];//生成bundle
}



+(void)setUserlanguage:(NSString *)language{
    
    NSUserDefaults *def = [NSUserDefaults standardUserDefaults];
    
    //1.第一步改变bundle的值
    NSString *path = [[NSBundle mainBundle] pathForResource:language ofType:@"lproj" ];
    
    bundle = [NSBundle bundleWithPath:path];
    
    //2.持久化
    [def setValue:language forKey:@"userLanguage"];
    
    [def synchronize];
}

@end
