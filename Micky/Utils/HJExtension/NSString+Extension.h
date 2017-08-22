//
//  NSString+Extension.h
//  lawconsult
//
//  Created by mosjoydev6 on 16/8/16.
//  Copyright © 2016年 Mosjoy. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <Foundation/Foundation.h>

@interface NSString (Extension)

/*
 **把微博获取的时间字符串剪切成自己需要的字段，存到数组里边输出
 */
-(NSString *)cutReqestDateStr:(NSString *)dateStr;

/*
 **微博来源的的切割
 */
-(NSString *)cutSourceBySource:(NSString *)source;

/**
 *  --------------------------------------------------------------------------------------
 */

/*
 普通文字的size
 */
+(CGSize)sizeWithString:(NSString *)str font:(UIFont *)font maxSize:(CGSize)maxSize;


/*
 数据是时间文字的size
 */
+(CGSize )sizeWithDate:(NSDate *)date font:(UIFont *)font maxSize:(CGSize)maxSize;

/**
 *  --------------------------------------------------------------------------------------
 */

/**
 *  字符串编码
 */
- (NSString *)stringEncode;


/**
 *  字符串解码
 */
- (NSString *)stringDecode;

/**
 *  --------------------------------------------------------------------------------------
 */

/**
 *  可变字符串改变颜色 ：fromString -> toString
 *
 *  @param color      颜色
 *  @param fromString 开始字符串
 *  @param toString   结束字符串（如果没有输入，或者为空，默认到最后）
 *
 *  @return 可变字符串
 */
-(NSMutableAttributedString *)stringColor:(UIColor *)color betweenFromString:(NSString *)fromString toString:(NSString *)toString;

/**
 *  可变字符串改变颜色 ： fromString 和 toString 之间
 *
 *  @param color      颜色
 *  @param fromString 开始字符串
 *  @param toString   结束字符串（如果没有输入，或者为空，默认到最后）
 *
 *  @return 可变字符串
 */
-(NSMutableAttributedString *)stringBetweenColor:(UIColor *)color betweenFromString:(NSString *)fromString toString:(NSString *)toString;

/**
 *  可变字符串改变字体大小
 *
 *  @param font       字体大小
 *  @param fromString 开始字符串
 *  @param toString   结束字符串(没有或则为空默认到最后)
 *
 *  @return 字体变化后的可变字符串
 */
-(NSMutableAttributedString *)stringFont:(UIFont *)font betweenFromString:(NSString *)fromString toString:(NSString *)toString;

/**
 *  可变字符串改变字体描边颜色和宽度
 *
 *  @param strokeColor 描边颜色
 *  @param strokeWidth 宽度
 *  @param fromString  开始字符串
 *  @param toString    结束字符串(没有或则为空默认到最后)
 *
 *  @return 字体变化后的可变字符串
 */
-(NSMutableAttributedString *)stringStrokeColor:(UIColor *)strokeColor strokeWidth:(CGFloat)strokeWidth betweenFromString:(NSString *)fromString toString:(NSString *)toString;

/**
 *  添加删除线
 */
-(NSMutableAttributedString *)stringStrikethroughStyleBetweenFromString:(NSString *)fromString toString:(NSString *)toString;


/**
 *  添加下划线
 */
-(NSMutableAttributedString *)stringUnderlineStyleBetweenFromString:(NSString *)fromString toString:(NSString *)toString;
@end
