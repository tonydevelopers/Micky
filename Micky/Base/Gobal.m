//
//  Gobal.m
//  HomeDecoration
//
//  Created by 张宁 on 16/8/15.
//  Copyright © 2016年 mosjoydev6. All rights reserved.
//

#import "Gobal.h"
#import "qrencode.h"
#import <sys/sysctl.h>
#import <sys/xattr.h>
enum {
    qr_margin = 3
};
@implementation Gobal


#pragma - common
BOOL const isTest = NO;
NSInteger SCREENWIDTH = 0;
NSInteger SCREENHEIGH = 0;
#pragma mark -- 判断空字符串
+(NSString*)convertNull:(id)object {
    // 转换空串
    if ([object isEqual:[NSNull null]]) {
        return @"--";
    }
    else if ([object isKindOfClass:[NSNull class]])
    {
        return @"--";
    }
    else if (object==nil){
        return @"--";
    }else if([object isEqualToString:@""]){
        return @"--";
    }
    return object;
}
#pragma mark - NSString
+ (BOOL)isEmptyString:(NSString *)str {
    if (!str || [str isEqual:[NSNull null]]) {
        return YES;
    }else if ([str isKindOfClass:[NSNumber class]]){
        return NO;
    }else {
        NSCharacterSet *set = [NSCharacterSet whitespaceAndNewlineCharacterSet];
        NSString *trimedString = [str stringByTrimmingCharactersInSet:set];
        if ([trimedString length]==0) {
            return YES;
        } else {
            return NO;
        }
    }
    return NO;
}
+(BOOL)isEmptyNull:(id)object {
    
    if ([object isEqual:NULL]) {
        return YES;
    }else if ([object isEqual:nil]) {
        return YES;
    }else if ([object isEqual:[NSNull null]]) {
        return YES;
    }else if ([object  isKindOfClass:[NSNull class]]) {
        return YES;
    }else if (object==nil) {
        return YES;
    }
    return NO;
}
#pragma mark -- 颜色图片
+ (UIImage *)imageWithColor:(UIColor *)color size:(CGSize)size {
    
    CGRect rect = CGRectMake(0.0f, 0.0f, size.width, size.height);
    UIGraphicsBeginImageContext(rect.size);
    CGContextRef context = UIGraphicsGetCurrentContext();
    
    CGContextSetFillColorWithColor(context, [color CGColor]);
    CGContextFillRect(context, rect);
    
    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    return image;
}
#pragma mark -- 图片旋转
+ (UIImage *)image:(UIImage *)image rotation:(UIImageOrientation)orientation {
    
    long double rotate = 0.0;
    CGRect rect;
    float translateX = 0;
    float translateY = 0;
    float scaleX = 1.0;
    float scaleY = 1.0;
    
    switch (orientation) {
        case UIImageOrientationLeft:
            rotate = M_PI_2;
            rect = CGRectMake(0, 0, image.size.height, image.size.width);
            translateX = 0;
            translateY = -rect.size.width;
            scaleY = rect.size.width/rect.size.height;
            scaleX = rect.size.height/rect.size.width;
            break;
        case UIImageOrientationRight:
            rotate = 3 * M_PI_2;
            rect = CGRectMake(0, 0, image.size.height, image.size.width);
            translateX = -rect.size.height;
            translateY = 0;
            scaleY = rect.size.width/rect.size.height;
            scaleX = rect.size.height/rect.size.width;
            break;
        case UIImageOrientationDown:
            rotate = M_PI;
            rect = CGRectMake(0, 0, image.size.width, image.size.height);
            translateX = -rect.size.width;
            translateY = -rect.size.height;
            break;
        default:
            rotate = 0.0;
            rect = CGRectMake(0, 0, image.size.width, image.size.height);
            translateX = 0;
            translateY = 0;
            break;
    }
    
    UIGraphicsBeginImageContext(rect.size);
    CGContextRef context = UIGraphicsGetCurrentContext();
    //做CTM变换
    CGContextTranslateCTM(context, 0.0, rect.size.height);
    CGContextScaleCTM(context, 1.0, -1.0);
    CGContextRotateCTM(context, rotate);
    CGContextTranslateCTM(context, translateX, translateY);
    CGContextScaleCTM(context, scaleX, scaleY);
    //绘制图片
    CGContextDrawImage(context, CGRectMake(0, 0, rect.size.width, rect.size.height), image.CGImage);
    UIImage *newPic = UIGraphicsGetImageFromCurrentImageContext();
    return newPic;
}
#pragma mark -- 图片按宽度修饰
+(UIImage*)ResizeImageWithImage: (UIImage*) sourceImage scaledToWidth: (float) i_width
{
    float oldWidth = sourceImage.size.width;
    if (i_width > oldWidth)
        return sourceImage;
    float scaleFactor = i_width / oldWidth;
    
    float newHeight = sourceImage.size.height * scaleFactor;
    float newWidth = oldWidth * scaleFactor;
    
    UIGraphicsBeginImageContext(CGSizeMake(newWidth, newHeight));
    [sourceImage drawInRect:CGRectMake(0, 0, newWidth, newHeight)];
    UIImage *newImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return newImage;
}
#pragma mark -- 图片按高度修饰
+(UIImage*)ResizeImageWithImage: (UIImage*) sourceImage scaledToHeight: (float) i_height
{
    float oldHeight = sourceImage.size.height;
    if (i_height > oldHeight)
        return sourceImage;
    float scaleFactor = i_height / oldHeight;
    
    float newWidth = sourceImage.size.height * scaleFactor;
    float newHeight = oldHeight * scaleFactor;
    
    UIGraphicsBeginImageContext(CGSizeMake(newWidth, newHeight));
    [sourceImage drawInRect:CGRectMake(0, 0, newWidth, newHeight)];
    UIImage *newImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return newImage;
}
#pragma mark - Alert
+(void)showAlert:(NSString *)title Content:(NSString *)message {
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:title
                                                    message:message
                                                   delegate:self
                                          cancelButtonTitle:@"确定"
                                          otherButtonTitles: nil];
    [alert show];
    [alert release];
}
#pragma mark -- 判断字符串里面是否含汉字
+(BOOL)IsChinese:(NSString *)str {
    
    for(int i=0; i< [str length];i++){
        int a = [str characterAtIndex:i];
        if( a > 0x4e00 && a < 0x9fff){
            return YES;
        }
    }
    return NO;
}
#pragma mark -- 导航栏文字
+ (UILabel *)navigationItemTitle:(NSString *)title {
    
    UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 100, 44)];
    label.text = title;
    label.font = [UIFont systemFontOfSize:20];
    label.textAlignment = NSTextAlignmentCenter;
    label.textColor = [UIColor colorWithRed:40/255.0 green:54/255.0 blue:78/255.0 alpha:1.0];
    return label;
}
#pragma mark -- 步骤显示器
+ (UIView *)headerStepDemonstrationDeviceheight:(CGFloat)height labelArray:(NSArray *)labelArray titleArray:(NSArray *)titleArray stepCount:(int)step {
    
    UIView *headerView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, height)];
    headerView.backgroundColor = [UIColor colorWithRed:105/255.0f green:124/255.0f blue:214/255.0f alpha:1.0f];
    
    NSInteger setCount = [labelArray count]>[titleArray count]?[labelArray count]:[titleArray count];
    for (int i = 0; i < setCount; i++) {
        
        CGFloat M = headerView.frame.size.width;
        
        CGFloat X = (M-120)/(setCount-1);//接应线长
        CGFloat W = 15*[titleArray[i] length];
        
        UILabel *label = [[UILabel alloc]init];
        label.frame = CGRectMake(20+(X-1+20)*i, (height-40)/2.0, 20, 20);
        label.text = labelArray[i];
        label.layer.borderWidth = 0;
        label.layer.masksToBounds = YES;
        label.font = [UIFont systemFontOfSize:15];
        label.textAlignment = NSTextAlignmentCenter;
        label.layer.cornerRadius = label.frame.size.height/2.0;
        label.textColor = [UIColor colorWithRed:105/255.0f green:124/255.0f blue:214/255.0f alpha:1.0f];
        label.backgroundColor = [UIColor colorWithRed:69/255.0 green:88/255.0 blue:179/255.0 alpha:1.0];
        label.layer.borderColor = [[UIColor colorWithRed:69/255.0 green:88/255.0 blue:179/255.0 alpha:1.0]CGColor];
        [headerView addSubview:label];
        
        UILabel *title = [[UILabel alloc]init];
        title.text = titleArray[i];
        title.font  = [UIFont systemFontOfSize:12];
        title.textAlignment = NSTextAlignmentCenter;
        title.backgroundColor = [UIColor clearColor];
        title.frame = CGRectMake(30+(X-1+20)*i-W/2.0, (height-40)/2.0+20, W, 20);
        title.textColor = [UIColor colorWithRed:69/255.0 green:88/255.0 blue:179/255.0 alpha:1.0];
        [headerView addSubview:title];
        
        UIView *line = [[UIView alloc]init];
        if (i < setCount-1) {
            line.frame = CGRectMake(40+(X+19)*i, (height-20)/2.0, X, 2);
            line.backgroundColor = [UIColor colorWithRed:69/255.0 green:88/255.0 blue:179/255.0 alpha:1.0];
            [headerView addSubview:line];
        }
        if (i <= step) {
            
            label.layer.borderColor = [[UIColor whiteColor]CGColor];
            label.textColor = [UIColor colorWithRed:105/255.0f green:124/255.0f blue:214/255.0f alpha:1.0f];
            
            label.backgroundColor = [UIColor whiteColor];
            title.textColor = [UIColor whiteColor];
            if (step>0 && i <= step-1) {
                line.backgroundColor = [UIColor whiteColor];
            }
        }
    }
    return headerView;
}
#pragma mark -- 判断邮箱
+(BOOL)isValidateEmail:(NSString *)email {
    NSString *emailRegex = @"[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,4}";
    NSPredicate *emailTest = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", emailRegex];
    return [emailTest evaluateWithObject:email];
}
#pragma mark -- 时间戳转化为时间
+(NSString *)TheTimeStampChangetime:(NSString *)time {
    
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    [formatter setDateStyle:NSDateFormatterMediumStyle];
    [formatter setTimeStyle:NSDateFormatterShortStyle];
    [formatter setDateFormat:@"YYYY-MM-dd HH:mm:ss"];
    NSTimeZone* timeZone = [NSTimeZone timeZoneWithName:@"Asia/Shanghai"];
    [formatter setTimeZone:timeZone];
    NSDate *confromTimesp = [NSDate dateWithTimeIntervalSince1970:[time intValue]];
    NSString *confromTimespStr = [formatter stringFromDate:confromTimesp];
    return confromTimespStr;
    
}
#pragma mark -- json字符串转换
+ (NSDictionary *)dictionaryWithJsonString:(NSString *)jsonString {
    if (jsonString == nil) {
        return nil;
    }
    NSData *jsonData = [jsonString dataUsingEncoding:NSUTF8StringEncoding];
    NSError *err;
    NSDictionary *dic = [NSJSONSerialization JSONObjectWithData:jsonData
                                                        options:NSJSONReadingMutableContainers
                                                          error:&err];
    if(err) {
        NSLog(@"json解析失败：%@",err);
        return nil;
    }
    return dic;
}
#pragma mark -- 自适应高度
+(CGSize)sizeWithText:(NSString *)text font:(UIFont *)font maxSize:(CGSize)maxSize {
    if (!text || !text.length) {
        return CGSizeZero;
    }
    NSDictionary *dict = @{NSFontAttributeName:font};
    CGRect rect = [text boundingRectWithSize:maxSize options:NSStringDrawingUsesLineFragmentOrigin attributes:dict context:nil];
    return rect.size;
}
+(CGFloat)heightWithText:(NSString *)text font:(UIFont *)font maxWidth:(CGFloat)maxWidth {
    return ceil([self sizeWithText:text font:font maxSize:CGSizeMake(maxWidth, MAXFLOAT)].height);
}
#pragma mark - Save and Fetch
+ (void)saveAppSetting:(NSString *)data Key:(NSString *)key{
    NSString *filePath = [[NSHomeDirectory() stringByAppendingPathComponent:@"Documents"] stringByAppendingPathComponent:@"APPsetting.plist"];
    NSMutableDictionary *DictionaryArray = [[NSMutableDictionary alloc]initWithContentsOfFile:filePath];
    if (DictionaryArray==nil || [DictionaryArray count]<1){
        NSMutableDictionary *Array = [[NSMutableDictionary alloc]initWithObjectsAndKeys:data,key, nil];
        [Array writeToFile:filePath atomically:YES];
    }else{
        [DictionaryArray setValue:data forKey:key];
        [DictionaryArray writeToFile:filePath atomically:YES];
    }
}
#pragma mark - device
+ (NSString *)loadAppSetting:(NSString *)keyword{
    NSString *filePath = [[NSHomeDirectory() stringByAppendingPathComponent:@"Documents"] stringByAppendingPathComponent:@"APPsetting.plist"];
    NSMutableDictionary *DictionaryArray = [[NSMutableDictionary alloc]initWithContentsOfFile:filePath];
    if (DictionaryArray==nil || [DictionaryArray count]<1){
        return nil;
    }else{
        return [DictionaryArray objectForKey:keyword];
    }
}

//+ (BOOL)cachePersonalData:(NSString *)data Key:(NSString *)key{
//    BOOL result = NO;
//    NSString *filePath = [[[NSHomeDirectory() stringByAppendingPathComponent:@"Documents"] stringByAppendingPathComponent:[Gobal loadAppSetting:baseKey_Myuid]]stringByAppendingPathComponent:@"UserPersonData.plist"];
//    NSMutableDictionary *DictionaryArray = [[NSMutableDictionary alloc]initWithContentsOfFile:filePath];
//    if (DictionaryArray==nil || [DictionaryArray count]<1){
//        if ([[NSFileManager defaultManager] createDirectoryAtPath:[[NSHomeDirectory() stringByAppendingPathComponent:@"Documents"] stringByAppendingPathComponent:[Gobal loadAppSetting:baseKey_Myuid]] withIntermediateDirectories:YES attributes:nil error:nil]) {
//        }
//        NSMutableDictionary *Array = [[NSMutableDictionary alloc]initWithObjectsAndKeys:data,key, nil];
//        result = [Array writeToFile:filePath atomically:YES];
//    }else{
//        [DictionaryArray setValue:data forKey:key];
//        result = [DictionaryArray writeToFile:filePath atomically:YES];
//    }
//    return result;
//}

//+ (BOOL)removePersonalData:(NSString *)key{
//    BOOL result = NO;
//    NSString *filePath = [[[NSHomeDirectory() stringByAppendingPathComponent:@"Documents"] stringByAppendingPathComponent:[Gobal loadAppSetting:baseKey_Myuid]]stringByAppendingPathComponent:@"UserPersonData.plist"];
//    NSMutableDictionary *DictionaryArray = [[NSMutableDictionary alloc]initWithContentsOfFile:filePath];
//    if (DictionaryArray==nil || [DictionaryArray count]<1){
//        return NO;
//    }else{
//        [DictionaryArray removeObjectForKey:key];
//        result = [DictionaryArray writeToFile:filePath atomically:YES];
//    }
//    return result;
//}
//
//+ (NSString *)loadPersonalDataFromCache:(NSString *)keyword{
//    NSString *filePath = [[[NSHomeDirectory() stringByAppendingPathComponent:@"Documents"] stringByAppendingPathComponent:[Gobal loadAppSetting:baseKey_Myuid]]stringByAppendingPathComponent:@"UserPersonData.plist"];
//    NSMutableDictionary *DictionaryArray = [[[NSMutableDictionary alloc]initWithContentsOfFile:filePath] autorelease];
//    if (DictionaryArray==nil || [DictionaryArray count]<1){
//        return nil;
//    }else{
//        return [DictionaryArray objectForKey:keyword];
//    }
//}
#pragma mark -- 判读是否为数字
+(BOOL)isPureNumandCharacters:(NSString *)string {
    
    string = [string stringByTrimmingCharactersInSet:[NSCharacterSet decimalDigitCharacterSet]];
    [NSCharacterSet decimalDigitCharacterSet];
    if(string.length > 0)
    {
        return NO;
    }
    return YES;
}
#pragma mark -- 判断手机号是否正确
+(BOOL)validateMobile:(NSString *)mobile {
    
    //手机号以13， 15，18开头，八个 \d 数字字符
    NSString *phoneRegex = @"^((13[0-9])|(15[^4,\\D])|(18[0,0-9]))\\d{8}$";
    NSPredicate *phoneTest = [NSPredicate predicateWithFormat:@"SELF MATCHES %@",phoneRegex];
    return [phoneTest evaluateWithObject:mobile];
}
#pragma mark -- 判断银行卡号是否正确
+(BOOL)checkCardNo:(NSString*) cardNo{
    int oddsum = 0;     //奇数求和
    int evensum = 0;    //偶数求和
    int allsum = 0;
    int cardNoLength = (int)[cardNo length];
    int lastNum = [[cardNo substringFromIndex:cardNoLength-1] intValue];
    
    cardNo = [cardNo substringToIndex:cardNoLength - 1];
    for (int i = cardNoLength -1 ; i>=1;i--) {
        NSString *tmpString = [cardNo substringWithRange:NSMakeRange(i-1, 1)];
        int tmpVal = [tmpString intValue];
        if (cardNoLength % 2 ==1 ) {
            if((i % 2) == 0){
                tmpVal *= 2;
                if(tmpVal>=10)
                    tmpVal -= 9;
                evensum += tmpVal;
            }else{
                oddsum += tmpVal;
            }
        }else{
            if((i % 2) == 1){
                tmpVal *= 2;
                if(tmpVal>=10)
                    tmpVal -= 9;
                evensum += tmpVal;
            }else{
                oddsum += tmpVal;
            }
        }
    }
    
    allsum = oddsum + evensum;
    allsum += lastNum;
    if((allsum % 10) == 0)
        return YES;
    else
        return NO;
}
#pragma mark -- 判断身份证
+ (BOOL)validateIDCardNumber:(NSString *)value {
    value = [value stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]];
    
    int length =0;
    if (!value) {
        return NO;
    }else {
        length = (int)value.length;
        if (length !=15 && length !=18) {
            return NO;
        }
    }
    // 省份代码
    NSArray *areasArray =@[@"11",@"12", @"13",@"14", @"15",@"21", @"22",@"23", @"31",@"32", @"33",@"34", @"35",@"36", @"37",@"41", @"42",@"43", @"44",@"45", @"46",@"50", @"51",@"52", @"53",@"54", @"61",@"62", @"63",@"64", @"65",@"71", @"81",@"82", @"91"];
    
    NSString *valueStart2 = [value substringToIndex:2];
    BOOL areaFlag =NO;
    for (NSString *areaCode in areasArray) {
        if ([areaCode isEqualToString:valueStart2]) {
            areaFlag =YES;
            break;
        }
    }
    if (!areaFlag) {
        return false;
    }
    NSRegularExpression *regularExpression;
    NSUInteger numberofMatch;
    
    int year =0;
    switch (length) {
        case15:
            year = [value substringWithRange:NSMakeRange(6,2)].intValue +1900;
            
            if (year %4 ==0 || (year %100 ==0 && year %4 ==0)) {
                
                regularExpression = [[NSRegularExpression alloc]initWithPattern:@"^[1-9][0-9]{5}[0-9]{2}((01|03|05|07|08|10|12)(0[1-9]|[1-2][0-9]|3[0-1])|(04|06|09|11)(0[1-9]|[1-2][0-9]|30)|02(0[1-9]|[1-2][0-9]))[0-9]{3}$"
                                                                        options:NSRegularExpressionCaseInsensitive
                                                                          error:nil];//测试出生日期的合法性
            }else {
                regularExpression = [[NSRegularExpression alloc]initWithPattern:@"^[1-9][0-9]{5}[0-9]{2}((01|03|05|07|08|10|12)(0[1-9]|[1-2][0-9]|3[0-1])|(04|06|09|11)(0[1-9]|[1-2][0-9]|30)|02(0[1-9]|1[0-9]|2[0-8]))[0-9]{3}$"
                                                                        options:NSRegularExpressionCaseInsensitive
                                                                          error:nil];//测试出生日期的合法性
            }
            numberofMatch = [regularExpression numberOfMatchesInString:value
                                                               options:NSMatchingReportProgress
                                                                 range:NSMakeRange(0, value.length)];
            
            if(numberofMatch >0) {
                return YES;
            }else {
                return NO;
            }
        case18:
            
            year = [value substringWithRange:NSMakeRange(6,4)].intValue;
            if (year %4 ==0 || (year %100 ==0 && year %4 ==0)) {
                
                regularExpression = [[NSRegularExpression alloc]initWithPattern:@"^[1-9][0-9]{5}19[0-9]{2}((01|03|05|07|08|10|12)(0[1-9]|[1-2][0-9]|3[0-1])|(04|06|09|11)(0[1-9]|[1-2][0-9]|30)|02(0[1-9]|[1-2][0-9]))[0-9]{3}[0-9Xx]$"
                                                                        options:NSRegularExpressionCaseInsensitive
                                                                          error:nil];//测试出生日期的合法性
            }else {
                regularExpression = [[NSRegularExpression alloc]initWithPattern:@"^[1-9][0-9]{5}19[0-9]{2}((01|03|05|07|08|10|12)(0[1-9]|[1-2][0-9]|3[0-1])|(04|06|09|11)(0[1-9]|[1-2][0-9]|30)|02(0[1-9]|1[0-9]|2[0-8]))[0-9]{3}[0-9Xx]$"
                                                                        options:NSRegularExpressionCaseInsensitive
                                                                          error:nil];//测试出生日期的合法性
            }
            numberofMatch = [regularExpression numberOfMatchesInString:value
                                                               options:NSMatchingReportProgress
                                                                 range:NSMakeRange(0, value.length)];
            
            if(numberofMatch >0) {
                int S = ([value substringWithRange:NSMakeRange(0,1)].intValue + [value substringWithRange:NSMakeRange(10,1)].intValue) *7 + ([value substringWithRange:NSMakeRange(1,1)].intValue + [value substringWithRange:NSMakeRange(11,1)].intValue) *9 + ([value substringWithRange:NSMakeRange(2,1)].intValue + [value substringWithRange:NSMakeRange(12,1)].intValue) *10 + ([value substringWithRange:NSMakeRange(3,1)].intValue + [value substringWithRange:NSMakeRange(13,1)].intValue) *5 + ([value substringWithRange:NSMakeRange(4,1)].intValue + [value substringWithRange:NSMakeRange(14,1)].intValue) *8 + ([value substringWithRange:NSMakeRange(5,1)].intValue + [value substringWithRange:NSMakeRange(15,1)].intValue) *4 + ([value substringWithRange:NSMakeRange(6,1)].intValue + [value substringWithRange:NSMakeRange(16,1)].intValue) *2 + [value substringWithRange:NSMakeRange(7,1)].intValue *1 + [value substringWithRange:NSMakeRange(8,1)].intValue *6 + [value substringWithRange:NSMakeRange(9,1)].intValue *3;
                int Y = S %11;
                NSString *M =@"F";
                NSString *JYM =@"10X98765432";
                M = [JYM substringWithRange:NSMakeRange(Y,1)];// 判断校验位
                if ([M isEqualToString:[value substringWithRange:NSMakeRange(17,1)]]) {
                    return YES;// 检测ID的校验位
                }else {
                    return NO;
                }
                
            }else {
                return NO;
            }
        default:
            return false;
    }
}

#pragma mark -- 初步判断是否是邮箱
+(BOOL)isEmail:(NSString *)email_str {
    
    if([email_str rangeOfString:@"@"].location !=NSNotFound){
        
        NSArray *array = [email_str componentsSeparatedByString:@"@"];
        if (array.count<2) {
            return NO;
        }else {
            NSString *titleStr = array[1];
            if([titleStr rangeOfString:@"."].location !=NSNotFound){
                NSString *firstStr = [titleStr substringToIndex:1];
                NSLog(@"看看是啥 == %@",firstStr);

                if ([firstStr isEqualToString:@"."]) {
                    return NO;
                }else{
                    return YES;
                }
            }else{
                return NO;
            }
        }
    }
    return NO;
}
#pragma mark -- 画虚线
+(void)drawDottedLine:(UIView*)selfView parentView:(UIView*)parentView someLong:(int)pointLength intervalLong:(int)intervalLength startPointX:(CGFloat)sx Y:(CGFloat)sy endPointX:(CGFloat)ex Y:(CGFloat)ey{
    CAShapeLayer *shapeLayer = [CAShapeLayer layer];
    [shapeLayer setBounds:selfView.bounds];
    [shapeLayer setPosition:selfView.center];
    [shapeLayer setFillColor:[[UIColor clearColor] CGColor]];
    [shapeLayer setStrokeColor:[[UIColor colorWithRed:223/255.0 green:223/255.0 blue:223/255.0 alpha:1.0f] CGColor]];
    [shapeLayer setLineWidth:1.0f];
    [shapeLayer setLineJoin:kCALineJoinRound];
    [shapeLayer setLineDashPattern:
     [NSArray arrayWithObjects:[NSNumber numberWithInt:pointLength],[NSNumber numberWithInt:intervalLength],nil]];
    CGMutablePathRef path = CGPathCreateMutable();
    CGPathMoveToPoint(path, NULL, sx, sy);
    CGPathAddLineToPoint(path, NULL, ex,ey);
    [shapeLayer setPath:path];
    CGPathRelease(path);
    [[parentView layer] addSublayer:shapeLayer];
}
#pragma mark -- 划实线
+(UIView *)drawSolidLinePointX:(float)x PointY:(float)y lineW:(float)w lineH:(float)h lineColor:(NSArray *)color_A lineAlpha:(float)a {
    
    UIView *line = [[UIView alloc]init];
    line.backgroundColor = [UIColor colorWithRed:[color_A[0] floatValue]/255.0 green:[color_A[1] floatValue]/255.0 blue:[color_A[2] floatValue]/255.0 alpha:a];
    line.frame = CGRectMake(x, y, w, h);
    line.alpha = a;
    line.opaque = NO;
    return line;
}
#pragma mark -- 画虚线边框
+(void)drawDottedBorder:(UIView *)f_view borderColor:(UIColor *)b_color lineWidth:(CGFloat)w_line lineDashInterval:(NSArray *)num_interval {

    CAShapeLayer *border = [CAShapeLayer layer];
    border.strokeColor = b_color.CGColor;
    border.fillColor = nil;
    border.path = [UIBezierPath bezierPathWithRect:f_view.bounds].CGPath;
    border.frame = f_view.bounds;
    border.lineWidth = w_line;
    border.lineCap = @"square";
    border.lineDashPattern = num_interval;
    [f_view.layer addSublayer:border];
}
#pragma mark -- 渐变色
+ (void)fillGradientColor:(NSArray *)color_A parentView:(UIView *)parent_V startPoint:(CGPoint) start_P endPoint:(CGPoint)end_P locations:(NSArray *)color_point_location{
    
    CAGradientLayer *gradientLayer = [CAGradientLayer layer];
    gradientLayer.frame = parent_V.bounds;
    [parent_V.layer addSublayer:gradientLayer];
    gradientLayer.startPoint = start_P;//CGPointMake(0, 0);
    gradientLayer.endPoint = end_P; //CGPointMake(0, 1);
    gradientLayer.colors = color_A;
//@[(__bridge id)[UIColor redColor].CGColor,
//(__bridge id)[UIColor grayColor].CGColor,
//(__bridge id)[UIColor blueColor].CGColor];
    gradientLayer.locations = color_point_location;//@[@(0.2),@(0.5f), @(1.0f)];
    
}
#pragma mark -- 二维码
+ (UIImage *)qrImageForString:(NSString *)string imageSize:(CGFloat)size {
    if (![string length]) {
        return nil;
    }
    
    QRcode *code = QRcode_encodeString([string UTF8String], 0, QR_ECLEVEL_L, QR_MODE_8, 1);
    if (!code) {
        return nil;
    }
    
    // create context
    CGColorSpaceRef colorSpace = CGColorSpaceCreateDeviceRGB();
    CGContextRef ctx = CGBitmapContextCreate(0, size, size, 8, size * 4, colorSpace, kCGImageAlphaPremultipliedLast);
    
    CGAffineTransform translateTransform = CGAffineTransformMakeTranslation(0, -size);
    CGAffineTransform scaleTransform = CGAffineTransformMakeScale(1, -1);
    CGContextConcatCTM(ctx, CGAffineTransformConcat(translateTransform, scaleTransform));
    
    // draw QR on this context
    [Gobal drawQRCode:code context:ctx size:size];
    
    // get image
    CGImageRef qrCGImage = CGBitmapContextCreateImage(ctx);
    UIImage * qrImage = [UIImage imageWithCGImage:qrCGImage];
    
    // some releases
    CGContextRelease(ctx);
    CGImageRelease(qrCGImage);
    CGColorSpaceRelease(colorSpace);
    QRcode_free(code);
    
    return qrImage;
}
+ (void)drawQRCode:(QRcode *)code context:(CGContextRef)ctx size:(CGFloat)size {
    unsigned char *data = 0;
    int width;
    data = code->data;
    width = code->width;
    float zoom = (double)size / (code->width + 2.0 * qr_margin);
    CGRect rectDraw = CGRectMake(0, 0, zoom, zoom);
    
    // draw
    CGContextSetFillColor(ctx, CGColorGetComponents([UIColor blackColor].CGColor));
    for(int i = 0; i < width; ++i) {
        for(int j = 0; j < width; ++j) {
            if(*data & 1) {
                rectDraw.origin = CGPointMake((j + qr_margin) * zoom,(i + qr_margin) * zoom);
                CGContextAddRect(ctx, rectDraw);
            }
            ++data;
        }
    }
    CGContextFillPath(ctx);
}

+ (NSString *)getModel {
    size_t size;
    sysctlbyname("hw.machine", NULL, &size, NULL, 0);
    char *model = malloc(size);
    sysctlbyname("hw.machine", model, &size, NULL, 0);
    NSString *deviceModel = [NSString stringWithCString:model encoding:NSUTF8StringEncoding];
    free(model);
    return deviceModel;
}

//@interface NSAttributedString : NSObject <NSCopying, NSMutableCopying, NSSecureCoding>
//
//@property (readonly, copy) NSString *string;
//- (NSDictionary<NSString *, id> *)attributesAtIndex:(NSUInteger)location effectiveRange:(nullable NSRangePointer)range;
//
//@end
//
//@interface NSAttributedString (NSExtendedAttributedString)
//
//@property (readonly) NSUInteger length;
//- (nullable id)attribute:(NSString *)attrName atIndex:(NSUInteger)location effectiveRange:(nullable NSRangePointer)range;
//- (NSAttributedString *)attributedSubstringFromRange:(NSRange)range;
//
//- (NSDictionary<NSString *, id> *)attributesAtIndex:(NSUInteger)location longestEffectiveRange:(nullable NSRangePointer)range inRange:(NSRange)rangeLimit;
//- (nullable id)attribute:(NSString *)attrName atIndex:(NSUInteger)location longestEffectiveRange:(nullable NSRangePointer)range inRange:(NSRange)rangeLimit;
//
//- (BOOL)isEqualToAttributedString:(NSAttributedString *)other;
//
//- (instancetype)initWithString:(NSString *)str;
//- (instancetype)initWithString:(NSString *)str attributes:(nullable NSDictionary<NSString *, id> *)attrs;
//- (instancetype)initWithAttributedString:(NSAttributedString *)attrStr;
//
//typedef NS_OPTIONS(NSUInteger, NSAttributedStringEnumerationOptions) {
//    NSAttributedStringEnumerationReverse = (1UL << 1),
//    NSAttributedStringEnumerationLongestEffectiveRangeNotRequired = (1UL << 20)
//};
//
//- (void)enumerateAttributesInRange:(NSRange)enumerationRange options:(NSAttributedStringEnumerationOptions)opts usingBlock:(void (NS_NOESCAPE ^)(NSDictionary<NSString *, id> *attrs, NSRange range, BOOL *stop))block NS_AVAILABLE(10_6, 4_0);
//- (void)enumerateAttribute:(NSString *)attrName inRange:(NSRange)enumerationRange options:(NSAttributedStringEnumerationOptions)opts usingBlock:(void (NS_NOESCAPE ^)(id _Nullable value, NSRange range, BOOL *stop))block NS_AVAILABLE(10_6, 4_0);
//
//@end
//
//NS_CLASS_AVAILABLE(10_0, 3_2)
//@interface NSMutableAttributedString : NSAttributedString
//
//- (void)replaceCharactersInRange:(NSRange)range withString:(NSString *)str;
//- (void)setAttributes:(nullable NSDictionary<NSString *, id> *)attrs range:(NSRange)range;
//
//@end
//
//@interface NSMutableAttributedString (NSExtendedMutableAttributedString)
//
//@property (readonly, retain) NSMutableString *mutableString;
//
//- (void)addAttribute:(NSString *)name value:(id)value range:(NSRange)range;
//- (void)addAttributes:(NSDictionary<NSString *, id> *)attrs range:(NSRange)range;
//- (void)removeAttribute:(NSString *)name range:(NSRange)range;
//
//- (void)replaceCharactersInRange:(NSRange)range withAttributedString:(NSAttributedString *)attrString;
//- (void)insertAttributedString:(NSAttributedString *)attrString atIndex:(NSUInteger)loc;
//- (void)appendAttributedString:(NSAttributedString *)attrString;
//- (void)deleteCharactersInRange:(NSRange)range;
//- (void)setAttributedString:(NSAttributedString *)attrString;
//
//- (void)beginEditing;
//- (void)endEditing;
//
//@end







/*
 
 self.title = @"For iOS 6 & later";
 NSMutableAttributedString *str = [[NSMutableAttributedString alloc] initWithString:@"Using NSAttributed String"];
 [str addAttribute:NSForegroundColorAttributeName value:[UIColor blueColor] range:NSMakeRange(0,5)];
 [str addAttribute:NSForegroundColorAttributeName value:[UIColor redColor] range:NSMakeRange(6,12)];
 [str addAttribute:NSForegroundColorAttributeName value:[UIColor greenColor] range:NSMakeRange(19,6)];
 [str addAttribute:NSFontAttributeName value:[UIFont fontWithName:@"Arial-BoldItalicMT" size:30.0] range:NSMakeRange(0, 5)];
 [str addAttribute:NSFontAttributeName value:[UIFont fontWithName:@"HelveticaNeue-Bold" size:30.0] range:NSMakeRange(6, 12)];
 [str addAttribute:NSFontAttributeName value:[UIFont fontWithName:@"Courier-BoldOblique" size:30.0] range:NSMakeRange(19, 6)];
 attrLabel.attributedText = str;
 
 */







@end
