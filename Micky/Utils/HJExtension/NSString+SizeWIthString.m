//
//  NSString+SizeWIthString.m
//  简单的微信详情界面
//
//  Created by Ibokan2 on 10/23/15.
//  Copyright © 2015 HJ. All rights reserved.
//

#import "NSString+SizeWIthString.h"

@implementation NSString (SizeWIthString)

+(CGSize)sizeWithString:(NSString *)str font:(UIFont *)font maxSize:(CGSize)maxSize
{
//    NSLog(@"str = %@",str);
//    NSLog(@"font = %@",font);
//    NSLog(@"maxSize.width = %f, height = %f",maxSize.width,maxSize.height);
    
    NSDictionary *attribute = @{NSFontAttributeName : font};
    
    
    CGSize size = [str boundingRectWithSize:maxSize options:NSStringDrawingUsesLineFragmentOrigin attributes:attribute context:nil].size;
    
    return size;
    
}

-(CGSize)sizeWithDate:(NSDate *)date font:(UIFont *)font maxSize:(CGSize)maxSize
{
    NSString *str = [NSString stringWithFormat:@"%@",date];
    
    NSDictionary *attribute = @{NSFontAttributeName : font};
    
    CGSize size = [str boundingRectWithSize:maxSize options:NSStringDrawingUsesLineFragmentOrigin attributes:attribute context:nil].size;
    
    return size;
}

@end
