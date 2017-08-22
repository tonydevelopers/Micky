//
//  defination.h
//

#ifndef NewStock_defination_h
#define NewStock_defination_h


#define IOS7_OR_LATER       ([[[UIDevice currentDevice] systemVersion] compare:@"7.0"] != NSOrderedAscending )


#define APP_ID @"888888888"

#define kUIColorFromRGB(rgbValue) [UIColor \
colorWithRed:((float)((rgbValue & 0xFF0000) >> 16))/255.0 \
green:((float)((rgbValue & 0xFF00) >> 8))/255.0 \
blue:((float)(rgbValue & 0xFF))/255.0 alpha:1.0]


#define MSG_LOGOUT @"logoutMessage"//退出
//#define CHANNEL_ID @"tongbu"
//#define CHANNEL_ID @"91手机助手"

//下载渠道
#define CHANNEL_ID @"App Store"


//用户信息
#define USER_ID @"user_id"
#define USER_NAME @"user_name"
#define USER_PW @"user_pw"

#define INPUT_USER_NAME @"input_user_name"

//设备信息
#define API_SIGNATURE_NAME @"signature"
#define API_DEVICE_IDENTIFICATION @"deviceIdentification"
#define API_DEVICE_MAC_ADDRESS @"macAddress"
#define API_DEVICE_PHONE_TYPE @"phoneType"
#define API_APP_VERSION @"appVersion"




//接口版本号
#define API_VERSION @"1.0"



#endif
