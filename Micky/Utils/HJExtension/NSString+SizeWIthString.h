//
//  NSString+SizeWIthString.h
//  简单的微信详情界面
//
//  Created by Ibokan2 on 10/23/15.
//  Copyright © 2015 HJ. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface NSString (SizeWIthString)

/*
 普通文字的size
 */
+(CGSize)sizeWithString:(NSString *)str font:(UIFont *)font maxSize:(CGSize)maxSize;


/*
 数据是时间文字的size
 */
+(CGSize )sizeWithDate:(NSDate *)date font:(UIFont *)font maxSize:(CGSize)maxSize;

@end
