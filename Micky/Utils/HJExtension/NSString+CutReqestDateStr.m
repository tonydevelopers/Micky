//
//  NSString+CutReqestDateStr.m
//  WeiBoAPP
//
//  Created by Ibokan2 on 15/11/25.
//  Copyright © 2015年 Ibokan. All rights reserved.
//
#define WHOLE_DAY_SECONDS (24*60*60)

#import "NSString+CutReqestDateStr.h"
@implementation NSString (CutReqestDateStr)
//Wed Nov 25 10:26:20 +0800 2015
//yyyy年MM月dd天 HH:mm:ss
//2015年11月25天 17:02:39
-(NSString *)cutReqestDateStr:(NSString *)dateStr
{
    NSDateFormatter* formater = [[NSDateFormatter alloc] init];
    //NSLocale对象来控制日期和时间的显示
    NSLocale* local =[[NSLocale alloc] initWithLocaleIdentifier:@"en_US"];
    [formater setLocale: local];
    //设置时间的格式
    [formater setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
    NSDate* date = [formater dateFromString:dateStr];
    //微博时间和当前时间的时间间隔
    double interval = fabs([date timeIntervalSinceNow]);
    float day = interval/WHOLE_DAY_SECONDS;
    
    if (day < 1) {
        //小于一小时
        if (interval < 60*60)
        {
            int minCount = interval / 60;
            //小于1分钟
            if (minCount < 1)
            {
                return [NSString stringWithFormat:@"刚刚"];
            }
            //如果小于两分钟并且大于1分钟
            else if (minCount < 2 && minCount > 1)
                return [NSString stringWithFormat:@"1分钟前"];
            //大于两分钟
            else
                return [NSString stringWithFormat:@"%d分钟前",minCount];
        }
        //大于一小时，小于一天
        else if (interval >= 60 *60)
        {
            int hourCount = interval / (60*60);
            return [NSString stringWithFormat:@"%d小时前",hourCount];
        }
    }
    //大于一天，小于两天
    else if (day >= 1 && day < 2)
    {
        return [NSString stringWithFormat:@"昨天"];
    }
    //大于两天，小于三天
    else if(day >= 2 && day < 3){
        return [NSString stringWithFormat:@"前天"];
    }
    //大于三天，小于七天
    else if(day >= 3 && day < 7){
        int dayNumber = interval/WHOLE_DAY_SECONDS;
        
        //        NSLog(@"-------------------------------------------");
        //        NSLog(@"interval = %ld",(long)interval);
        //        NSLog(@"WHOLE_DAY_SECONDS = %d",WHOLE_DAY_SECONDS);
        //        NSLog(@"daynumber = %d",dayNumber);
        //        NSLog(@"-------------------------------------------");
        
        return [NSString stringWithFormat:@"%d天前",dayNumber];
    }
    //大于七天
    else
    {
        NSDateFormatter *dateFormatter = [[NSDateFormatter alloc]init];
        [dateFormatter setDateFormat:@"yyyy-MM-dd"];
        return [dateFormatter stringFromDate:date];
    }
    return nil;
}

/*
 **微博来源的的切割
 */
//"<a href=\"http://app.weibo.com/t/feed/63af84\" rel=\"nofollow\">vivo智能手机</a>"
-(NSString *)cutSourceBySource:(NSString *)source
{
//    NSLog(@"%@",source);
    NSArray *tempSourceArr = [source componentsSeparatedByString:@">"];
//    NSLog(@"tempSourceArr = %@",tempSourceArr);
//    NSLog(@"temSourceArr[1] = %@",tempSourceArr[1]);
    NSArray *resultSourceArr = [tempSourceArr[1] componentsSeparatedByString:@"<"];
//    NSLog(@"resultSoutceArr = %@",resultSourceArr);
    return [NSString stringWithFormat:@"来自 %@",[resultSourceArr firstObject]];
}

@end
