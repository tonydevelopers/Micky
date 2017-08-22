//
//  NSString+Extension.m
//  lawconsult
//
//  Created by mosjoydev6 on 16/8/16.
//  Copyright © 2016年 Mosjoy. All rights reserved.
//
#define WHOLE_DAY_SECONDS (24*60*60)
#import "NSString+Extension.h"

@implementation NSString (Extension)

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
    //小于一天
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

/**
 *  --------------------------------------------------------------------------------------
 */


/**
 *  计算字符串size
 */
+(CGSize)sizeWithString:(NSString *)str font:(UIFont *)font maxSize:(CGSize)maxSize
{
    //    NSLog(@"str = %@",str);
    NSLog(@"font = %@",font);
    //    NSLog(@"maxSize.width = %f, height = %f",maxSize.width,maxSize.height);
    
    NSDictionary *attribute = @{NSFontAttributeName : font};
    
    
    CGSize size = [str boundingRectWithSize:maxSize options:NSStringDrawingUsesLineFragmentOrigin attributes:attribute context:nil].size;
    
    return size;
    
}

/**
 *  计算date的size
 */
-(CGSize)sizeWithDate:(NSDate *)date font:(UIFont *)font maxSize:(CGSize)maxSize
{
    NSString *str = [NSString stringWithFormat:@"%@",date];
    
    NSDictionary *attribute = @{NSFontAttributeName : font};
    
    CGSize size = [str boundingRectWithSize:maxSize options:NSStringDrawingUsesLineFragmentOrigin attributes:attribute context:nil].size;
    
    return size;
}

/**
 *  --------------------------------------------------------------------------------------
 */

/**
 *  字符串编码
 */
- (NSString *)stringEncode {
    /**
     *  CFAllocatorRef allocator,
     *  CFStringRef originalString,                     待转码的类型
     *  CFStringRef charactersToLeaveUnescaped,         指示不转义的字符
     *  CFStringRef legalURLCharactersToBeEscaped,      指示确定转义的字符
     *  CFStringEncoding encoding);                     编码类型
     */
    NSString *encodedString = (NSString *)CFBridgingRelease(CFURLCreateStringByAddingPercentEscapes(kCFAllocatorDefault, (CFStringRef)self, NULL, CFSTR(":/?#[]@!$ &'()*+,;=\"<>%{}|\\^~`"), kCFStringEncodingUTF8));
    return encodedString;
}

/**
 *  字符串解码
 */
- (NSString *)stringDecode {
    
//    NSMutableString *outputStr = [NSMutableString stringWithString:self];
//    [outputStr replaceOccurrencesOfString:@"+" withString:@"" options:NSLiteralSearch range:NSMakeRange(0, [outputStr length])];
//    return [outputStr stringByReplacingPercentEscapesUsingEncoding:NSUTF8StringEncoding];

    
    NSString *result = [(NSString *)self stringByReplacingOccurrencesOfString:@"+" withString:@" "];
    result = [result stringByReplacingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    return result;
}

/**
 *  --------------------------------------------------------------------------------------
 */

/**
 *  可变字符串改变颜色
 *
 *  @param color      颜色
 *  @param fromString 开始字符串
 *  @param toString   结束字符串
 *
 *  @return 可变字符串
 */
-(NSMutableAttributedString *)stringColor:(UIColor *)color betweenFromString:(NSString *)fromString toString:(NSString *)toString
{
    
    NSMutableAttributedString *attrString = [[NSMutableAttributedString alloc]initWithString:self];
    NSRange targetRange = [self calculateTargetRangeFromString:fromString toString:toString];
    [attrString addAttribute:NSForegroundColorAttributeName value:color range:targetRange];
    return attrString;
    
}

/**
 *  可变字符串改变颜色 ： fromString 和 toString 之间
 *
 *  @param color      颜色
 *  @param fromString 开始字符串
 *  @param toString   结束字符串（如果没有输入，或者为空，默认到最后）
 *
 *  @return 可变字符串
 */
-(NSMutableAttributedString *)stringBetweenColor:(UIColor *)color betweenFromString:(NSString *)fromString toString:(NSString *)toString
{
    
    NSMutableAttributedString *attrString = [[NSMutableAttributedString alloc]initWithString:self];
    NSRange targetRange = [self calculateTargetRangeBetweenFromString:fromString toString:toString];
    [attrString addAttribute:NSForegroundColorAttributeName value:color range:targetRange];
    return attrString;
}

/**
 *  可变字符串改变字体大小
 *
 *  @param font       字体大小
 *  @param fromString 开始字符串
 *  @param toString   结束字符串(没有或则为空默认到最后)
 *
 *  @return 字体变化后的可变字符串
 */
-(NSMutableAttributedString *)stringFont:(UIFont *)font betweenFromString:(NSString *)fromString toString:(NSString *)toString
{
    NSMutableAttributedString *attrString = [[NSMutableAttributedString alloc]initWithString:self];
    NSRange targetRange = [self calculateTargetRangeFromString:fromString toString:toString];
    [attrString addAttribute:NSFontAttributeName value:font range:targetRange];
    return attrString;
}

/**
 *  可变字符串改变字体描边颜色和宽度(可做成空心字符串)
 *
 *  @param strokeColor 描边颜色
 *  @param strokeWidth 宽度
 *  @param fromString  开始字符串
 *  @param toString    结束字符串(没有或则为空默认到最后)
 *
 *  @return 字体变化后的可变字符串
 */
-(NSMutableAttributedString *)stringStrokeColor:(UIColor *)strokeColor strokeWidth:(CGFloat)strokeWidth betweenFromString:(NSString *)fromString toString:(NSString *)toString
{
    
    NSMutableAttributedString *attrString = [[NSMutableAttributedString alloc]initWithString:self];
    
    NSRange targetRange = [self calculateTargetRangeFromString:fromString toString:toString];
    
    NSDictionary *attributes = @{NSStrokeColorAttributeName:strokeColor,
                                 NSStrokeWidthAttributeName:@(strokeWidth)};
    
    [attrString addAttributes:attributes range:targetRange];
    
    return attrString;
}

/**
 *  添加删除线
 */
-(NSMutableAttributedString *)stringStrikethroughStyleBetweenFromString:(NSString *)fromString toString:(NSString *)toString
{
    
    NSMutableAttributedString *attrString = [[NSMutableAttributedString alloc]initWithString:self];
    
    NSRange targetRange = [self calculateTargetRangeFromString:fromString toString:toString];
    
    NSDictionary *attributes = @{NSStrikethroughStyleAttributeName:@(NSUnderlineStyleSingle)};
    
    [attrString addAttributes:attributes range:targetRange];
    
    return attrString;
}

/**
 *  添加下划线
 */
-(NSMutableAttributedString *)stringUnderlineStyleBetweenFromString:(NSString *)fromString toString:(NSString *)toString
{
    
    NSMutableAttributedString *attrString = [[NSMutableAttributedString alloc]initWithString:self];
    
    NSRange targetRange = [self calculateTargetRangeFromString:fromString toString:toString];
    
    /**
     *  辅助效果
     *  NSUnderlinePatternSolid         固体
     *  NSUnderlinePatternDot           点
     *  NSUnderlinePatternDash          破折号样式
     *  NSUnderlinePatternDashDot       破折号点样式
     *  NSUnderlinePatternDashDotDot    点中点
     */
    NSDictionary *attributes = @{NSUnderlineStyleAttributeName:@(NSUnderlineStyleSingle)};
    
    [attrString addAttributes:attributes range:targetRange];
    
    return attrString;
}

/**
 *  计算目标range
 */
-(NSRange)calculateTargetRangeFromString:(NSString *)fromString toString:(NSString *)toString
{
    NSRange fromRange = [self rangeOfString:fromString];
    NSRange toRange = [self rangeOfString:toString];
    
    //开始字符串是空
    if ([self isEmpty:fromString]) {
        //返回当前字符串的range
        return NSMakeRange(0, self.length);
    }
    
    CGFloat length;
    //结束字符串是否为空
    if ([self isEmpty:toString]) {//结束字符串是空
        length = self.length - fromRange.location;
    }else{//结束字符串不为空
        length = toRange.location - fromRange.location + 1;
    }
    
    return NSMakeRange(fromRange.location, length);
}

-(NSRange)calculateTargetRangeBetweenFromString:(NSString *)fromString toString:(NSString *)toString
{
    NSRange fromRange = [self rangeOfString:fromString];
    NSRange toRange = [self rangeOfString:toString];
    
    //开始字符串是空
    if ([self isEmpty:fromString]) {
        //返回当前字符串的range
        return NSMakeRange(0, self.length);
    }
    
    
    CGFloat length;
    //结束字符串是否为空
    if ([self isEmpty:toString]) {//结束字符串是空
        length = self.length - fromRange.location;
    }else{//结束字符串不为空
        length = toRange.location - fromRange.location;
    }
    
    return NSMakeRange(fromRange.location+1, length-1);
}

-(BOOL)isEmpty:(id)object{
    
    if ([object isEqual:[NSNull null]]) {
        return YES;
    }else if ([object isKindOfClass:[NSNull class]]){
        return YES;
    }else if (object==nil){
        return YES;
    }else if ([object isEqualToString:@""]){
        return YES;
    }
    
    return NO;
    
}


@end
