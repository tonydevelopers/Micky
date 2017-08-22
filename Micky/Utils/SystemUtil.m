//
//  SystemUtil.m
//

#import "SystemUtil.h"
#import <CommonCrypto/CommonDigest.h>
#import <sys/socket.h>
#import <sys/sysctl.h>
#import <net/if.h>
#import <net/if_dl.h>
//#import "KeychainIDFA.h"
#import "sys/utsname.h"
#import "Defination.h"
#import "FCUUID.h"
#import "CocoaSecurity.h"
#import "NSData+AES128.h"

#import "SecurityUtil.h"

#import "AESCryptoHelper.h"
#import "AESCipher.h"

#import "AESCrypt.h"



#import "NSData+Base64.h"
#import "NSString+Base64.h"
#import "NSData+CommonCrypto.h"

@implementation SystemUtil


+ (BOOL)isIPhone5 // iPhone 5 screen size
{
    BOOL flag = NO;
    if([[UIScreen mainScreen] bounds].size.height == 568.0f) {
        flag = YES;
    }
    return flag;
}

+ (float)systemVersion; // get the system version
{
    return [[[UIDevice currentDevice] systemVersion] floatValue];
}

// Download file from web, save to Documents file
+ (NSString *)saveFileToDocuments:(NSString *)url
{
    NSString *resultFilePath = @"";
    if (url.length > 7) {
        
        
        NSString *destFilePath = [[NSHomeDirectory() stringByAppendingPathComponent:@"Documents"] stringByAppendingPathComponent:[url substringFromIndex:7]];
        NSString *destFolderPath = [destFilePath stringByDeletingLastPathComponent];
        
        
        if (! [[NSFileManager defaultManager] fileExistsAtPath:destFolderPath]) {
            
            [[NSFileManager defaultManager] createDirectoryAtPath:destFolderPath withIntermediateDirectories:YES attributes:nil error:nil];
        }
        
        
        if ([[NSFileManager defaultManager] fileExistsAtPath:destFilePath]) {
            
            resultFilePath = destFilePath;
        } else {
            
            NSData *imageData = [NSData dataWithContentsOfURL:[NSURL URLWithString:url]];
            if ([imageData writeToFile:destFilePath atomically:YES]) {
                resultFilePath = destFilePath;
            }
        }
    }
    return resultFilePath;
}

+ (NSString *)trimTheDate:(NSString *)date
{
    int theIndex = date.length;
    for (int index = 0; index < date.length; index ++) {
        if ([date characterAtIndex:index] == ' ') {
            theIndex = index;
            break;
        }
    }
    NSString *result = [date substringToIndex:theIndex];
    return result;
}


+ (NSString *)formatJSONString:(NSString *)string
{
    NSString *resultString = [string stringByReplacingOccurrencesOfString:@"\\n" withString:@"\n"];
    resultString = [resultString stringByReplacingOccurrencesOfString:@"\\r" withString:@"\r"];
    resultString = [resultString stringByReplacingOccurrencesOfString:@"\n" withString:@"\\n"];
    resultString = [resultString stringByReplacingOccurrencesOfString:@"\r" withString:@"\\r"];
    return resultString;
}


//判断用户是否登录
+ (BOOL)isSignIn
{
    BOOL flag = NO;
    if ([[NSUserDefaults standardUserDefaults] objectForKey:USER_NAME]) {
        if (! [[[NSUserDefaults standardUserDefaults] objectForKey:USER_NAME] isEqualToString:@""]) {
            flag = YES;
        }
    }
    return flag;
}

//退出登录
+ (void)signOut
{
    [[NSUserDefaults standardUserDefaults] setObject:@"" forKey:USER_ID];
    [[NSUserDefaults standardUserDefaults] removeObjectForKey:USER_ID];
    
    [[NSUserDefaults standardUserDefaults] setObject:@"" forKey:USER_NAME];
    [[NSUserDefaults standardUserDefaults] removeObjectForKey:USER_NAME];
    [[NSUserDefaults standardUserDefaults] synchronize];
}

+ (BOOL)extractIdentity:(SecIdentityRef *)outIdentity andTrust:(SecTrustRef*)outTrust fromPKCS12Data:(NSData *)inPKCS12Data
{
    OSStatus securityError = errSecSuccess;
    
    //	NSDictionary *optionsDictionary = [NSDictionary dictionaryWithObject:@"" forKey:(id)kSecImportExportPassphrase];
    
    CFStringRef password = CFSTR("EIWnsA1n6tGs"); //证书密码
    const void *keys[] =   { kSecImportExportPassphrase };
    const void *values[] = { password };
    
    CFDictionaryRef optionsDictionary = CFDictionaryCreate(NULL, keys,values, 1,NULL, NULL);
    CFArrayRef items = CFArrayCreate(NULL, 0, 0, NULL);
    securityError = SecPKCS12Import((__bridge CFDataRef)inPKCS12Data,(CFDictionaryRef)optionsDictionary,&items);
    
    if (securityError == 0) {
        CFDictionaryRef myIdentityAndTrust = CFArrayGetValueAtIndex (items, 0);
        const void *tempIdentity = NULL;
        tempIdentity = CFDictionaryGetValue (myIdentityAndTrust, kSecImportItemIdentity);
        *outIdentity = (SecIdentityRef)tempIdentity;
        const void *tempTrust = NULL;
        tempTrust = CFDictionaryGetValue (myIdentityAndTrust, kSecImportItemTrust);
        *outTrust = (SecTrustRef)tempTrust;
    } else {
        NSLog(@"Failed with error code %d",(int)securityError);
        CFRelease(optionsDictionary);
        CFRelease(items);
        return NO;
    }
    CFRelease(optionsDictionary);
    CFRelease(items);
    return YES;
}
//调用拨打电话功能 拼接电话号码
+ (void)callPhone:(NSString *)num
{
    [[UIApplication sharedApplication] openURL:[NSURL URLWithString:[@"telprompt://" stringByAppendingString:num]]];
}


//用NSUserDefaults来保存用户注册的用户名密码。
+ (NSString *)getCache:(NSString *)k
{
    NSString *v = [[NSUserDefaults standardUserDefaults] objectForKey:k];
    if (!v) {
        v = @"";
    }
    return v;
}
+ (void)putCache:(NSString *)k value:(NSString *)v
{
    [[NSUserDefaults standardUserDefaults] setObject:v forKey:k];
    [[NSUserDefaults standardUserDefaults] synchronize];
}

+ (void)saveCookie
{
    NSArray *cookies = [[NSHTTPCookieStorage sharedHTTPCookieStorage] cookiesForURL: [NSURL URLWithString:BASE_URL]];
    NSData *data = [NSKeyedArchiver archivedDataWithRootObject:cookies];
    [[NSUserDefaults standardUserDefaults] setObject:data forKey:@"UserDefaultsCookie"];
}
+ (void)setCookie
{
    NSData *cookiesdata = [[NSUserDefaults standardUserDefaults] objectForKey:@"UserDefaultsCookie"];
    if([cookiesdata length]) {
        NSArray *cookies = [NSKeyedUnarchiver unarchiveObjectWithData:cookiesdata];
        NSHTTPCookie *cookie;
        for (cookie in cookies) {
            NSLog(@"cookie:%@",cookie);
            [[NSHTTPCookieStorage sharedHTTPCookieStorage] setCookie:cookie];
        }
    }
}
+ (void)cleanCookie
{
    [[NSUserDefaults standardUserDefaults] removeObjectForKey:@"UserDefaultsCookie"];
}

//MD5加密。
+ (NSString *)md5:(NSString *)value
{
    char hexDigits[] = { '0', '1', '2', '3', '4', '5', '6', '7', '8', '9', 'a', 'b', 'c', 'd', 'e', 'f' };
    
    const char * cStr = [value UTF8String];
    unsigned char result[16];
    CC_MD5(cStr, strlen(cStr), result);
    
    int j = 16;
    unsigned char str[48];
    int k = 0;
    for (int i = 0; i < j; i++)
    {
        Byte byte0 = result[i];
        str[k++] = hexDigits[byte0 >> 4 & 0xf];
        str[k++] = hexDigits[byte0 & 0xf];
        str[k++] = hexDigits[byte0 & 3];
        
    }
    NSString *strNSString = [NSString stringWithFormat:@"%s",str];//[[[NSString alloc] initWithCString:str encoding:NSASCIIStringEncoding] autorelease];
    
    
    return [strNSString substringToIndex:48];
}

+ (NSString *)customer_md5:(NSString *)value
{
    if ([value isEqualToString:@""])
    {
        return @"";
    }
    const char * cStr = [value UTF8String];
    unsigned char result[16];
    CC_MD5(cStr, strlen(cStr), result);
    NSString *output = [NSString stringWithFormat:
                        @"%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x",
                        result[0], result[1], result[2], result[3],
                        result[4], result[5], result[6], result[7],
                        result[8], result[9], result[10], result[11],
                        result[12], result[13], result[14], result[15]
                        ];
    return output.uppercaseString;
}

+(NSString *)getSignature
{
    if ([SystemUtil isSignIn])
    {
        NSString *pw = [SystemUtil getCache:USER_PW];//@"123456";//
        NSString *pw_md5 = [SystemUtil customer_md5:pw];
        long long customId = [[SystemUtil getCache:USER_ID] longLongValue];
        NSString *toHex = [SystemUtil ToHex:customId];
        NSString *signature = [SystemUtil customer_md5:[NSString stringWithFormat:@"%@%@",pw_md5,toHex]];
        
        return signature;
    }
    else
    {
        return @"";
    }
}

+(NSString *)ToHex:(long long int)tmpid
{
    NSString *nLetterValue;
    NSString *str =@"";
    long long int ttmpig;
    for (int i = 0; i<9; i++) {
        ttmpig=tmpid%16;
        tmpid=tmpid/16;
        switch (ttmpig)
        {
            case 10:
                nLetterValue =@"A";break;
            case 11:
                nLetterValue =@"B";break;
            case 12:
                nLetterValue =@"C";break;
            case 13:
                nLetterValue =@"D";break;
            case 14:
                nLetterValue =@"E";break;
            case 15:
                nLetterValue =@"F";break;
            default:nLetterValue=[[NSString alloc]initWithFormat:@"%lli",ttmpig];
                
        }
        str = [nLetterValue stringByAppendingString:str];
        if (tmpid == 0) {
            break;
        }
        
    }
    return str;
}

+(NSString *)getAppVersion   //版本
{
    return [NSString stringWithFormat:@"iOS%@",[[NSBundle mainBundle] objectForInfoDictionaryKey:(NSString*)kCFBundleVersionKey]];
}

+ (NSString *)getIOSVersion
{
    NSString *version = [[UIDevice currentDevice] systemVersion];
    NSString *systemName = [[UIDevice currentDevice] systemName];
    return [NSString stringWithFormat:@"%@ %@", systemName,version];
}

+ (NSString*)deviceString
{
    // 需要#import "sys/utsname.h"
    struct utsname systemInfo;
    uname(&systemInfo);
    NSString *platform = [NSString stringWithCString:systemInfo.machine encoding:NSUTF8StringEncoding];
    return platform;
}

//+(NSString *)getKeychainIDFA
//{
//    return [KeychainIDFA IDFA];
//}

+ (NSString *)getUUIDForDevice
{
    return [FCUUID uuidForDevice];
}

+ (NSString *)getAsteristString:(NSString *)str
{
    if ([SystemUtil isNotNSnull:str] && [str length]>8)
    {
        NSRange range=NSMakeRange(4,[str length]-8);
        NSString *string = [str stringByReplacingCharactersInRange:range withString:@"****"];
        
        return string;
    }
    
    return @"";
}

+(NSString *)getMobileString:(NSString *)str
{
    if([SystemUtil isNotNSnull:str] && [str length] == 11)
    {
        NSRange range=NSMakeRange(3,[str length]-7);
        NSString *string = [str stringByReplacingCharactersInRange:range withString:@"****"];
        
        return string;
    }
    return @"";
}

+ (UIImage *)getScreenImage:(UIView *)view
{
    CGRect rect = view.frame;
    UIGraphicsBeginImageContext(rect.size);
    CGContextRef context = UIGraphicsGetCurrentContext();
    [view.layer renderInContext:context];
    UIImage *img = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    
    UIImage *bottomImg = [UIImage imageNamed:@"QR_code"];
    CGFloat width = img.size.width;
    CGFloat height = img.size.height;
    CGSize offScreenSize = CGSizeMake(width, height+bottomImg.size.height);
    UIGraphicsBeginImageContext(offScreenSize);
    
    //rect.origin.x += width/2;
    [img drawInRect:rect];
    
    CGRect bottomRect = CGRectMake((width-bottomImg.size.width)/2, height, bottomImg.size.width, bottomImg.size.height);
    [bottomImg drawInRect:bottomRect];
    
    
    
    UIImage* imagez = UIGraphicsGetImageFromCurrentImageContext();
    
    UIGraphicsEndImageContext();
    
    
    return imagez;
}
+ (UIImage*)imageWithColor:(UIColor*)color andHeight:(CGFloat)height
{
    CGRect rect = CGRectMake(0.0f, 0.0f, 1.0f, height);
    UIGraphicsBeginImageContext(rect.size);
    CGContextRef context = UIGraphicsGetCurrentContext();
    
    CGContextSetFillColorWithColor(context, [color CGColor]);
    CGContextFillRect(context, rect);
    
    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    return image;
}

+ (BOOL)isNotNSnull:(id)value
{
    if(value && ((NSNull *)value !=[NSNull null]))
    {
        if ([value isKindOfClass:NSString.class])
        {
            if ([value isEqualToString:@""])
            {
                return NO;
            }
        }
        return YES;
    }
    else
    {
        return NO;
    }
}

+ (UIImage *)reSizeImage:(UIImage *)image toSize:(CGSize)reSize
{
    UIGraphicsBeginImageContext(CGSizeMake(reSize.width, reSize.height));
    [image drawInRect:CGRectMake(0, 0, reSize.width, reSize.height)];
    UIImage *reSizeImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    return reSizeImage;
}

+ (UIImage *)scaleImage:(UIImage *)image toScale:(float)scaleSize
{
    UIGraphicsBeginImageContext(CGSizeMake(image.size.width * scaleSize, image.size.height * scaleSize));
    [image drawInRect:CGRectMake(0, 0, image.size.width * scaleSize, image.size.height * scaleSize)];
    UIImage *scaledImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    return scaledImage;
    
}

+(UIColor *) hexStringToColor: (NSString *) stringToConvert
{
    NSString *cString = [[stringToConvert stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]] uppercaseString];
    // String should be 6 or 8 characters
    
    if ([cString length] < 6) return [UIColor blackColor];
    // strip 0X if it appears
    if ([cString hasPrefix:@"0X"]) cString = [cString substringFromIndex:2];
    if ([cString hasPrefix:@"#"]) cString = [cString substringFromIndex:1];
    if ([cString length] != 6) return [UIColor blackColor];
    
    // Separate into r, g, b substrings
    
    NSRange range;
    range.location = 0;
    range.length = 2;
    NSString *rString = [cString substringWithRange:range];
    range.location = 2;
    NSString *gString = [cString substringWithRange:range];
    range.location = 4;
    NSString *bString = [cString substringWithRange:range];
    // Scan values
    unsigned int r, g, b;
    
    [[NSScanner scannerWithString:rString] scanHexInt:&r];
    [[NSScanner scannerWithString:gString] scanHexInt:&g];
    [[NSScanner scannerWithString:bString] scanHexInt:&b];
    
    return [UIColor colorWithRed:((float) r / 255.0f)
                           green:((float) g / 255.0f)
                            blue:((float) b / 255.0f)
                           alpha:1.0f];
    
}

+(UIFont *)myFont:(CGFloat)fontSize;
{
    CGAffineTransform matrix1 =  CGAffineTransformMake(1, 0, tanf(15 * (CGFloat)M_PI / 180), 1, 0, 0);
    
    UIFontDescriptor *desc1 = [ UIFontDescriptor fontDescriptorWithName :[ UIFont systemFontOfSize :fontSize]. fontName matrix :matrix1];
    
    if ( IOS7_OR_LATER )
    {
        return  [UIFont fontWithDescriptor :desc1 size :fontSize];
    }
    else
    {
        return [UIFont systemFontOfSize:fontSize];
    }
}

+(NSString *)get2decimal:(double)ff
{
    long long n = (ff+0.000005)*100;
    return [NSString stringWithFormat:@"%.2lf", ((double)n)/100.0];
}

+(NSString *)get4decimal:(double)ff
{
    long long n = ff*10000;
    return [NSString stringWithFormat:@"%.4lf", ((double)n)/10000.0];
}

+(NSString *)getPercentage:(double)ff;
{
    long long n = (ff+0.000005)*100;
    return [NSString stringWithFormat:@"%.2lf%%", ((double)n)/100.0];
}
+(NSString *)getPrecisionPrice:(double)ff precision:(int)precision
{
    NSString *str = [NSString stringWithFormat:@"%%.%dlf%%",precision];
    //NSLog(@"%@",[NSString stringWithFormat:str, precision]);
    return [NSString stringWithFormat:str, ff];
}


//+(NSString *)
+(NSString*)DataTOjsonString:(id)object
{
    NSString *jsonString = nil;
    NSError *error;
    NSData *jsonData = [NSJSONSerialization dataWithJSONObject:object
                                                       options:NSJSONWritingPrettyPrinted // Pass 0 if you don't care about the readability of the generated string
                                                         error:&error];
    if (! jsonData) {
        NSLog(@"Got an error: %@", error);
    } else {
        jsonString = [[NSString alloc] initWithData:jsonData encoding:NSUTF8StringEncoding];
    }
    return jsonString;
}


//
+ (NSString *)FormatValue:(NSString *)valueStr dig:(int)dig
{
    float value = [valueStr floatValue];
    if (value > 0.000001) {
        if (value >= DECIMAL_HUNDRED_MILLION) {
            NSString * sfmt = [NSString stringWithFormat:@"%%.%df亿", dig];
            return [NSString stringWithFormat:sfmt, (float)value/DECIMAL_HUNDRED_MILLION];
        }
        else if (value >= DECIMAL_TEN_THOUSAND) {
            NSString * sfmt = [NSString stringWithFormat:@"%%.%df万", dig];
            return [NSString stringWithFormat:sfmt, (float)value/DECIMAL_TEN_THOUSAND];
        }
        NSString * sfmt = [NSString stringWithFormat:@"%%.%df", dig];
        return [NSString stringWithFormat:sfmt, value];
    }
    return @"--";
}
+ (NSString *)FormatFloatValue:(float)value dig:(int)dig
{
    if (value > 0.000001) {
        if (value >= DECIMAL_HUNDRED_MILLION) {
            NSString * sfmt = [NSString stringWithFormat:@"%%.%df亿", dig];
            return [NSString stringWithFormat:sfmt, (float)value/DECIMAL_HUNDRED_MILLION];
        }
        else if (value >= DECIMAL_TEN_THOUSAND) {
            NSString * sfmt = [NSString stringWithFormat:@"%%.%df万", dig];
            return [NSString stringWithFormat:sfmt, (float)value/DECIMAL_TEN_THOUSAND];
        }
        NSString * sfmt = [NSString stringWithFormat:@"%%.%df", dig];
        return [NSString stringWithFormat:sfmt, value];
    }
    return @"--";
}




/**
 *  Description
 */

-(NSString *)getBinaryByhex:(NSString *)hex
{
    NSMutableDictionary  *hexDic = [[NSMutableDictionary alloc] init];
    
    hexDic = [[NSMutableDictionary alloc] initWithCapacity:16];
    
    [hexDic setObject:@"0000" forKey:@"0"];
    
    [hexDic setObject:@"0001" forKey:@"1"];
    
    [hexDic setObject:@"0010" forKey:@"2"];
    
    [hexDic setObject:@"0011" forKey:@"3"];
    
    [hexDic setObject:@"0100" forKey:@"4"];
    
    [hexDic setObject:@"0101" forKey:@"5"];
    
    [hexDic setObject:@"0110" forKey:@"6"];
    
    [hexDic setObject:@"0111" forKey:@"7"];
    
    [hexDic setObject:@"1000" forKey:@"8"];
    
    [hexDic setObject:@"1001" forKey:@"9"];
    
    [hexDic setObject:@"1010" forKey:@"A"];
    
    [hexDic setObject:@"1011" forKey:@"B"];
    
    [hexDic setObject:@"1100" forKey:@"C"];
    
    [hexDic setObject:@"1101" forKey:@"D"];
    
    [hexDic setObject:@"1110" forKey:@"E"];
    
    [hexDic setObject:@"1111" forKey:@"F"];
    
    NSMutableString *binaryString=[[NSMutableString alloc] init];
    
    for (int i=0; i<[hex length]; i++) {
        
        NSRange rage;
        
        rage.length = 1;
        
        rage.location = i;
        
        NSString *key = [hex substringWithRange:rage];
        
        //NSLog(@"%@",[NSString stringWithFormat:@"%@",[hexDic objectForKey:key]]);
        
        binaryString = [NSString stringWithFormat:@"%@%@",binaryString,[NSString stringWithFormat:@"%@",[hexDic objectForKey:key]]];
        
    }
    
    //NSLog(@"转化后的二进制为:%@",binaryString);
    
    return binaryString;
    
}
+ (NSString*)getSha256:(NSString *)str
{
    const char *cstr = [str cStringUsingEncoding:NSUTF8StringEncoding];
    NSData *data = [NSData dataWithBytes:cstr length:str.length];
    
    uint8_t digest[CC_SHA256_DIGEST_LENGTH];
    
    CC_SHA256(data.bytes, data.length, digest);
    
    NSMutableString* output = [NSMutableString stringWithCapacity:CC_SHA256_DIGEST_LENGTH * 2];
    
    for(int i = 0; i < CC_SHA256_DIGEST_LENGTH; i++)
        [output appendFormat:@"%02x", digest[i]];
    
    return output;
}
+ (NSString *)getSHA256Key:(NSString *)str
{
    CocoaSecurityResult *sha256 = [CocoaSecurity sha256:str];
    //    NSLog(@"%@",sha256);
    //    NSLog(@"%@",sha256.hex);
    //    NSLog(@"%@",sha256.hexLower);
    //    NSLog(@"%@",sha256.data);
    //    NSLog(@"%@",[SystemUtil dataToHexString:sha256.data]);
    //    Byte *bytes = (Byte *)[sha256.data bytes];
    
    return sha256.hexLower;
}
+(NSString *)dataToHexString:(NSData *)data
{
    NSUInteger len = [data length];
    char *chars = (char *)[data bytes];
    NSMutableString *hexString = [[NSMutableString alloc] init];
    for (NSUInteger i=0; i<len; i++) {
        [hexString appendString:[NSString stringWithFormat:@"%0.2hhx",chars[i]]];
    }
    return hexString;
}
+ (NSString *)getAESPw:(NSString *)pw
{
    NSString *pwd = [SystemUtil customer_md5:pw].lowercaseString;
    NSString *deviceId = [SystemUtil getUUIDForDevice];
    
    NSString *md5DeviceId = [SystemUtil customer_md5:deviceId].lowercaseString;
    NSString *encryptedData = [AESCrypt encrypt:pwd password:md5DeviceId];
    
    NSLog(@"%@",encryptedData);
    
    return encryptedData;
}

+ (NSString *)getRandomPw:(NSString *)pw
{
    srand((unsigned)time(0)); //不加这句每次产生的随机数不变
    int i = rand() % 1000000;
    return [NSString stringWithFormat:@"%@|%d",pw,i];
    //    //第二种
    //    srandom(time(0));
    //    int i = random() % 5;
    //    //第三种
    //    int i = arc4random() % 5 ;
}
@end
