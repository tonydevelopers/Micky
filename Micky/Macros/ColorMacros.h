//
//  ColorMacros.h
//  MickyEasyCredit
//
//  Created by  张宁 on 2016/10/5.
//  Copyright © 2016年  张宁. All rights reserved.
//

#ifndef ColorMacros_h
#define ColorMacros_h

#define BASE_COLOR            @"#F2CEC9"             //NavBar背景颜色
#define BASE_COLOR_1          @"#FC80A2"             //基础字体 按钮图标颜色
#define VC_BGCOLOR            @"#F5F5F5"             //ViewController 背景颜色
#define VC_BGCOLOR_WHITE      @"#FFFFFF"             //ViewController 白色背景颜色



#define SelfWidth self.frame.size.width
#define SelfHeight self.frame.size.height
#define SelfViewWidth self.view.frame.size.width
#define SelfViewHeight self.view.frame.size.height
#define ScreenWidth [UIScreen mainScreen].bounds.size.width
#define ScreenHeight [UIScreen mainScreen].bounds.size.height



#define IS_IPAD (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad)
#define IS_IPHONE5 (([[UIScreen mainScreen] bounds].size.height-568)?NO:YES)
#define IS_OS_5_OR_LATER    ([[[UIDevice currentDevice] systemVersion] floatValue] >= 5.0)
#define IS_OS_6_OR_LATER    ([[[UIDevice currentDevice] systemVersion] floatValue] >= 6.0)
#define IS_OS_7_OR_LATER    ([[[UIDevice currentDevice] systemVersion] floatValue] >= 7.0)
#define IS_OS_8_OR_LATER    ([[[UIDevice currentDevice] systemVersion] floatValue] >= 8.0)
#define IS_OS_9_OR_LATER    ([[[UIDevice currentDevice] systemVersion] floatValue] >= 9.0)
#define IS_OS_10_OR_LATER   ([[[UIDevice currentDevice] systemVersion] floatValue] >= 10.0)



#ifdef DEBUG
#define debugLog(...) NSLog(__VA_ARGS__)
#define debugMethod(...) NSLog((@"In %s,%s [Line %d] "), __PRETTY_FUNCTION__,__FILE__,__LINE__,##__VA_ARGS__)
//#define debugMethod() NSLog(@"%s",__func__)
#else
#define debugLog(...)
#define debugMethod()
#define findAllMed()
#endif


#define OS_VERSION [[[UIDevice currentDevice] systemVersion] floatValue]
#define DOCUMENT [(NSSearchPathForDirectoriesInDomains(NSDocumentDirectory,NSUserDomainMask,YES)) lastObject]


//主颜色
#define MainColor [UIColor colorWithRed:180/255.0 green:40/255.0 blue:45/255.0 alpha:1.0]
//副颜色
#define GOBALCOLOR [UIColor colorWithRed:89/255.0 green:173/255.0 blue:229/255.0 alpha:1.0]
//背景颜色
#define BACKGROUND_COLOR [UIColor colorWithRed:240.0/255.0 green:240.0/255.0 blue:240.0/255.0 alpha:1.0]
//下拉刷新颜色
#define REFRESH_BG_COLOR [UIColor colorWithRed:240.0/255.0 green:244.0/255.0 blue:247.0/255.0 alpha:1.0]
//深色字颜色
#define WORD_FONT_COLOR [UIColor colorWithRed:50.0/255.0 green:50.0/255.0 blue:50.0/255.0 alpha:1.0]
//浅色字颜色
#define TITLE_FONT_COLOR [UIColor colorWithRed:145.0/255.0 green:145.0/255.0 blue:145.0/255.0 alpha:1.0]
////按钮高亮颜色
#define BUTTON_COLOR_HIGHT [UIColor colorWithRed:89.0/255.0 green:141.0/255.0 blue:229.0/255.0 alpha:0.7]
////按钮正常颜色
//#define BUTTON_COLOR_NORMA [UIColor colorWithRed:235.0/255.0 green:65.0/255.0 blue:32.0/255.0 alpha:1.0]

#define BUTTON_COLOR_NORMA [UIColor colorWithRed:89.0/255.0 green:141.0/255.0 blue:229.0/255.0 alpha:1.0]


//自定义不透明颜色
#define RGBColor(r,g,b) [UIColor colorWithRed:r/255.0 green:g/255.0 blue:b/255.0 alpha:1.0]
//自定义颜色
#define RGBAColor(r,g,b,a) [UIColor colorWithRed:r/255.0 green:g/255.0 blue:b/255.0 alpha:a]


//分割线颜色
#define LINE_BORD_COLOR [UIColor colorWithRed:230/255.0 green:230/255.0 blue:230/255.0 alpha:1.0]
#define BASE_COLOR_LINE [UIColor colorWithRed:220/255.0 green:220/255.0 blue:220/255.0 alpha:1.0]
#define TOP_COLOR [UIColor colorWithRed:225/255.0 green:225/255.0 blue:225/255.0 alpha:1.0]
#define MIDDLE_COLOR [UIColor colorWithRed:240/255.0 green:240/255.0 blue:240/255.0 alpha:1.0]
#define BOTTOM_COLOR [UIColor colorWithRed:205/255.0 green:215/255.0 blue:205/255.0 alpha:1.0]



#pragma mark - Appkey
//个推官网
#define kGtAppId @"v0gngwlishAWBG2VOvref7"
#define kGtAppKey @"CZDEV29YPq9potDSaiWROA"
#define kGtAppSecret @"zd1paReo6H7YXYrfUXg8i9"
//友盟
#define AppKey @"58c39680310c9318f3001655"
#define AppMasterSecret @"3yu7ptf1f4jevhk4m0x9e8kcdb8adv8g"

#define USHARE_SHARE_APPKEY @"58f43b406e27a4784400060f"
//分享跳转链接
//#define QYDShare_URL @"http://mobile.umeng.com/social"

//#define QYDShare_URL(domain) [NSString stringWithFormat:@"%@?userId=%@",@"http://192.168.2.115:8083/jeeplus/a/h5/toShare",domain]
//#define QYDShare_URL(domain) [NSString stringWithFormat:@"%@?userId=%@",@"http://192.168.2.110:8080/jeeplus/a/h5/toShare",domain]
//#define QYDShare_URL(domain) [NSString stringWithFormat:@"%@?userId=%@",@"http://116.193.51.30:8089/jeeplus/a/h5/toShare",domain]
#define QYDShare_URL(domain) [NSString stringWithFormat:@"%@?userId=%@",@"http://dev.qianyijinrong.com:8089/jeeplus/a/h5/toShare",domain]

//微信
#define WXAppKey     @"wx15c235d6600dafee"
#define WXAppSecret  @"f978ce60ef82ba8e1ce58335348e8807"
//QQ
#define QQAppKey     @"41ee5200"
#define QQAppId      @"1106137600"
#define QQAppSecret  @"JLhZrn6VQrMZSktT"



//navigation 颜色
#define NAVIGATIONBAR_COLOR_STYLE(navigate_color,statusBar_style) self.navigationController.navigationBar.translucent = NO; \
[self.navigationController.navigationBar setBackgroundImage:[Gobal imageWithColor:navigate_color size:CGSizeMake(50, 50)] forBarMetrics:UIBarMetricsDefault]; \
self.navigationController.navigationBar.shadowImage = [[UIImage alloc] init];\
[[UIApplication sharedApplication] setStatusBarStyle:statusBar_style]
//分割线占满真个界面的宽度
#define SEPARATOR_WIDTH_FULL(view)    if ([view respondsToSelector:@selector(setLayoutMargins:)]) {\
[view setLayoutMargins:UIEdgeInsetsZero];\
}\
if ([view respondsToSelector:@selector(setSeparatorInset:)]) {\
[view setSeparatorInset:UIEdgeInsetsZero];\
}


//通知中心
#define NSNOTIFICATION_CENTER [NSNotificationCenter defaultCenter]
#define ImageURL(X) [NSString stringWithFormat:@"%@%@%@",downloadImageDomain,downloadImageIndex,X]




#endif /* ColorMacros_h */
