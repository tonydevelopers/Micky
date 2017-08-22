//
//  Base.h
//  NineDeepAndRemote
//
//  Created by 张宁 on 16/8/22.
//  Copyright © 2016年 YaChiLanDai. All rights reserved.
//
typedef enum {
    MainListViewStatusClose = 0,
    MainListViewStatusOpen,
    MainListViewStatusOpenning,
    MainListViewStatusClossing
} MainListViewStatus;
#import <Foundation/Foundation.h>
#import <CoreLocation/CoreLocation.h>

@interface Base : NSObject

/*
 UMS
 */
extern NSString* const UMSServerAddress;
extern NSString* const UMSAppKey;

/*
 Network
 */
extern NSString* const AppServerDomain;
extern NSString* const AppAPIPath;
extern NSString* const downloadImageDomain;
extern NSString* const downloadImageIndex;
extern NSString* const goodsImageIndex;
extern NSString* const webpagePath;
extern NSString* const contractwebpagePath;

/*
 Login & Registration
 */
extern BOOL setupRegisterByPhoneNum;
extern BOOL isAutoRegistration;
extern BOOL isLockScreen;

/*
 DL Setting Key
 */
extern NSString * const appsetting_NumOfBadge;
extern NSString * const appsetting_briefApp;
extern NSString * const appsetting_enable_alarm;

#pragma mark - Notification KEY
/*
 DL Notification Key
 */
extern NSString * const Notification_SetToday;
extern NSString * const Notification_previousMonth;
extern NSString * const Notification_nextMonth;

extern NSString * const EditNotification_additem;
extern NSString * const EditNotification_additemOnlyImage;
extern NSString * const LoginNotification_sina;
extern NSString * const LoginNotification_qq;
extern NSString * const Notification_updateUserInfo;
extern NSString * const Notification_payment_success;
extern NSString * const Notification_recharge_success;
extern NSString * const Notification_YPL_success;
extern NSString * const BindNotification_sina;
extern NSString * const BindNotification_mobile;


// monitor user phone call action
extern NSString* const Notification_phoneCall_disconnected;
extern NSString* const Notification_phoneCall_connected;
extern NSString* const Notification_phoneCall_incoming;
extern NSString* const Notification_phoneCall_dialing;
extern NSString* const Notification_phoneCall_NothingIsDone;

#pragma mark - User Common Data Key
/*
 User Common Data Key
 */
extern NSString * const baseKey_username;
extern NSString * const baseKey_userIDname;
extern NSString * const baseKey_password;
extern NSString * const baseKey_email;
extern NSString * const baseKey_mobile;
extern NSString * const baseKey_mobile_prefix;
extern NSString * const baseKey_sex;
extern NSString * const baseKey_realname;
extern NSString * const baseKey_type;
extern NSString * const baseKey_Myuid;
extern NSString * const baseKey_nickname;
extern NSString * const baseKey_city;
extern NSString * const baseKey_token;
extern NSString * const baseKey_myheadshot;
extern NSString * const baseKey_myBackground;
extern NSString * const baseKey_deviceToken;
extern NSString * const baseKey_deviceID;
extern NSString * const baseKey_loginType;
extern NSString * const baseKey_timezone;
extern NSString * const baseKey_job_position;
extern NSString * const baseKey_interest_fields;
extern NSString * const baseKey_userFriendlist;
extern NSString * const baseKey_sns_account;
extern NSString * const baseKey_sns_token;
extern NSString * const baseKey_sns_exptime;
extern NSString * const baseKey_tem_chat_record;
extern NSString * const baseKey_autoLogin;
extern NSString * const baseKey_avatarURL;
extern NSString * const baseKey_Rebate;
extern NSString * const baseKey_Region;
extern NSString * const baseKey_likeValue;
extern NSString * const baseKey_viewValue;
extern NSString * const baseKey_latitude;
extern NSString * const baseKey_longitude;
extern NSString * const baseKey_loginMethod;
extern NSString * const baseKey_signature;
extern NSString * const baseKey_period_status;
extern NSString * const baseKey_period_status_dec;
extern NSString * const baseKey_is_apply;
extern NSString * const baseKey_daily_login;
extern NSString * const baseKey_exp_edu;
extern NSString * const baseKey_exp_work;
extern NSString * const baseKey_im_account;
extern NSString * const baseKey_location;
extern NSString * const baseKey_unread_notify;


//ring
extern NSString * const baseKey_ringtone;

//lock
extern NSString * const baseKey_lockEnable;
extern NSString * const baseKey_lockPwd;

//fund
extern NSString * const baseKey_fund_value;
extern NSString * const baseKey_avalible_fund;

//365 basic
extern NSString * const baseKey_bb_birthday;

/*
 Folder Path
 */
extern NSString* const defaultPath;
extern NSString* const defaultHistoryPath;

/*
 DL Network param Key
 */
extern NSString * const DLRequestParam_PublishType_DailyLook;
extern NSString * const DLRequestParam_PublishType_ItemLook;
extern NSString * const DLRequestParam_LookType_Date;
extern NSString * const DLRequestParam_LookType_Casual;
extern NSString * const DLRequestParam_LookType_Formal;
extern NSString * const DLRequestParam_LookType_Party;
extern NSString * const DLRequestParam_LookType_Other;

/*
 cache File Key
 */
extern NSString * const cache_DLLooksFeed;
extern NSString * const cache_DLFeedList;
extern NSString * const cache_DLStoreLook;
extern NSString * const cache_DLMyLookRecordList;
extern NSString * const cache_DLOrderList;
extern NSString * const cache_DLUserInfo;
extern NSString * const cache_DLCatalogList;
extern NSString * const cache_DLCatalogStoreItem;
extern NSString * const cache_DLCatalogUsedStoreItem;
extern NSString * const cache_DLCatalogMyStoreItem;


//---------------------------项目-------------------

extern NSString * const Notification_AliPayNotification;
extern NSString * const Notification_WXNotification;
extern NSString * const Notification_Language_Changed;

extern NSString * const BASE_KEY_memberId;                   //用户userID
extern NSString * const BASE_KEY_myCode;                     //邀请码
extern NSString * const BASE_KEY_phone;                      //注册手机号
extern NSString * const BASE_KEY_faceImg;                    //用户头像
extern NSString * const BASE_KEY_name;                       //用户名

extern NSString * const BASE_KEY_AS_POSITIVE;                //身份正面
extern NSString * const BASE_KEY_IDENTITY_OPPOSITE;          //身份反面
extern NSString * const BASE_KEY_HOLDING_IDENTITY;           //手拿身份
extern NSString * const BASE_KEY_STUDENT_ID;                 //学生证明
extern NSString * const BASE_KEY_STUDENT_PROOF;              //学籍证明


extern NSString * const BaeKey_field_str_7;
extern NSString * const BaeKey_field_str_0;
extern NSString * const BaeKey_user_token;                   //
extern NSString * const BaeKey_CardID;                       //
extern NSString * const BaeKey_Level;                        //
extern NSString * const BaeKey_Email;                        //
extern NSString * const BaeKey_Code;                         //
extern NSString * const BaeKey_HeadImage;                    //
extern NSString * const BaeKey_Name;                         //
extern NSString * const BaeKey_Nickname;                     //
extern NSString * const BaeKey_Sex;                          //
extern NSString * const BaeKey_Birth;                        //
extern NSString * const BaeKey_Tel;                          //
extern NSString * const BaeKey_Address;                      //
extern NSString * const BaeKey_is_back_vc;                   //
extern NSString * const BaeKey_UserPayType;

extern NSString * const BaeKey_address_default;              //
extern NSString * const BaeKey_address_mobile;               //
extern NSString * const BaeKey_address_name;                 //
extern NSString * const BaeKey_address_Id;                   //

extern NSString * const BaeKey_IdCard_Front;                 //
extern NSString * const BaeKey_IdCard_Reverse;               //



@end
