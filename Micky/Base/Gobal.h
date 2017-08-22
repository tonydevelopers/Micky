//
//  Gobal.h
//  HomeDecoration
//
//  Created by 张宁 on 16/8/15.
//  Copyright © 2016年 mosjoydev6. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import "Base.h"

@interface Gobal : NSObject

#pragma - common
extern BOOL const isTest;
extern NSInteger SCREENWIDTH;
extern NSInteger SCREENHEIGH;
#pragma mark - string
+(NSString*)convertNull:(id)object;
#pragma mark - NSString
+(BOOL)IsChinese:(NSString *)str;
+(BOOL)isEmptyString:(NSString *)str;
+(BOOL)isEmptyNull:(id)object;
#pragma mark - image
+(UIImage *)imageWithColor:(UIColor *)color size:(CGSize)size;
+(UIImage *)image:(UIImage *)image rotation:(UIImageOrientation)orientation;
+(UIImage*)ResizeImageWithImage: (UIImage*) sourceImage scaledToWidth: (float) i_width;
+(UIImage*)ResizeImageWithImage: (UIImage*) sourceImage scaledToHeight: (float) i_height;
#pragma mark - Alert
+(void)showAlert:(NSString *)title Content:(NSString *)message;
#pragma mark - view
+(UIView *)headerStepDemonstrationDeviceheight:(CGFloat)height labelArray:(NSArray *)labelArray titleArray:(NSArray *)titleArray stepCount:(int)step;
#pragma mark - label
+ (UILabel *)navigationItemTitle:(NSString *)title;
#pragma mark - Save and Fetch
+ (void)saveAppSetting:(NSString *)data Key:(NSString *)key;
+ (NSString *)loadAppSetting:(NSString *)keyword;
#pragma mark - other
#pragma mark -- 判断邮箱是否正确
+(BOOL)isValidateEmail:(NSString *)email;
#pragma mark -- 时间戳转化为时间
+(NSString *)TheTimeStampChangetime:(NSString *)time;
#pragma mark -- json字符串转化
+(NSDictionary *)dictionaryWithJsonString:(NSString *)jsonString;
#pragma mark -- 自适应高度
+(CGSize)sizeWithText:(NSString *)text font:(UIFont *)font maxSize:(CGSize)maxSize;
+(CGFloat)heightWithText:(NSString *)text font:(UIFont *)font maxWidth:(CGFloat)maxWidth;
#pragma mark -- 判断银行卡号是否正确
+(BOOL)checkCardNo:(NSString*) cardNo;
#pragma mark -- 判断手机号是否正确
+(BOOL)validateMobile:(NSString *)mobile;
#pragma mark -- 判断身份证号是否正确
+(BOOL)validateIDCardNumber:(NSString *)value;
#pragma mark -- 判断读取的是否是数字
+(BOOL)isPureNumandCharacters:(NSString *)string;
#pragma mark - 划线
#pragma mark -- 画虚线
+(void)drawDottedLine:(UIView*)selfView parentView:(UIView*)parentView someLong:(int)pointLength intervalLong:(int)intervalLength startPointX:(CGFloat)sx Y:(CGFloat)sy endPointX:(CGFloat)ex Y:(CGFloat)ey;
#pragma mark -- 画实线
+(UIView *)drawSolidLinePointX:(float)x PointY:(float)y lineW:(float)w lineH:(float)h lineColor:(NSArray *)color_A lineAlpha:(float)a;
#pragma mark -- 画虚线框
+(void)drawDottedBorder:(UIView *)f_view borderColor:(UIColor *)b_color lineWidth:(CGFloat)w_line lineDashInterval:(NSArray *)num_interval;
#pragma mark -- 简易的查看邮箱是否正确
+(BOOL)isEmail:(NSString *)email_str;
#pragma mark -- 绘制渐变色
+ (void)fillGradientColor:(NSArray *)color_A parentView:(UIView *)parent_V startPoint:(CGPoint) start_P endPoint:(CGPoint)end_P locations:(NSArray *)color_point_location;
#pragma mark - 二维码
+ (UIImage *)qrImageForString:(NSString *)string imageSize:(CGFloat)size;










@end
