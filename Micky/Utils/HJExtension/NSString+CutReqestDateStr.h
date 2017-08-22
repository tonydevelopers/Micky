//
//  NSString+CutReqestDateStr.h
//  WeiBoAPP
//
//  Created by Ibokan2 on 15/11/25.
//  Copyright © 2015年 Ibokan. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSString (CutReqestDateStr)

/*
 **把微博获取的时间字符串剪切成自己需要的字段，存到数组里边输出
 */
-(NSString *)cutReqestDateStr:(NSString *)dateStr;

/*
 **微博来源的的切割
 */
-(NSString *)cutSourceBySource:(NSString *)source;

@end
