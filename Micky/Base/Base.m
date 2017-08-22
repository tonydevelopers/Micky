//
//  Base.m
//  NineDeepAndRemote
//
//  Created by 张宁 on 16/8/22.
//  Copyright © 2016年 YaChiLanDai. All rights reserved.
//

#import "Base.h"

@implementation Base


#pragma DLBase Common
/*
 UMS
 */
NSString* const UMSServerAddress = @"http://dev2.appnios.com/dailylook/index.php?";
NSString* const UMSAppKey = @"dec20cfb5d9b4534afa782418ce1e517";

/*
 Network
 */
NSString* const AppServerDomain = @"http://dev.yileapp.cn/";
NSString* const AppAPIPath = @"/mosjoyapi/chinalawyer/";
NSString* const downloadImageDomain = @"http://dev.yileapp.cn";
NSString* const downloadImageIndex = @"/mosjoyapi/chinalawyer/";
NSString* const goodsImageIndex = @"/mosjoyapi/chinalawyer/";
NSString* const webpagePath = @"mosjoyapi/chinalawyer/lawyer/";

/**
 Login & Registration
 */
BOOL setupRegisterByPhoneNum = YES;
BOOL isAutoRegistration = NO;
BOOL isLockScreen = NO;

/*
 DL Setting Key
 */
NSString * const appsetting_NumOfBadge = @"appsetting_NumOfBadge";
NSString * const appsetting_briefApp = @"appsetting_briefApp";
NSString * const appsetting_enable_alarm = @"appsetting_enable_alarm";

#pragma mark - Notification KEY
/*
 DL Notification Key
 */
NSString * const Notification_nextMonth = @"Notification_nextMonth";
NSString * const Notification_SetToday = @"Notification_SetToday";
NSString * const Notification_previousMonth = @"Notification_previousMonth";

NSString * const EditNotification_additem = @"EditNotification_additem";
NSString * const EditNotification_additemOnlyImage = @"EditNotification_additemOnlyImage";
NSString * const LoginNotification_sina = @"LoginNotification_sina";
NSString * const LoginNotification_qq = @"LoginNotification_qq";
NSString * const BindNotification_sina = @"BindNotification_sina";
NSString * const BindNotification_mobile = @"BindNotification_mobile";
NSString * const Notification_updateUserInfo = @"Notification_updateUserInfo";
NSString * const Notification_payment_success = @"Notification_payment_success";
NSString * const Notification_recharge_success = @"Notification_recharge_success";
NSString * const Notification_YPL_success = @"Notification_YPL_success";

//DX
NSString * const Notification_UpdateRecommend = @"Notification_UpdateRecommend";//更新推荐列表（登录与未登录状态）
NSString * const Notification_UpdateOvileBrowse = @"Notification_UpdateOvileBrowse";//更新橄榄枝（待确认与已读状态）
NSString * const Notification_UpdateOvileInvitation = @"Notification_UpdateOvileInvitation";//更新橄榄枝（已读与已接受状态）
NSString * const Notification_Updateunread_notify = @"Notification_Updateunread_notify";//监听橄榄枝未读消息（）
NSString * const Notification_UpdateResume = @"Notification_UpdateResume";//监听修改简历

NSString * const Notification_Reload_QuizList = @"Notification_Reload_QuizList";


// monitor user phone call action
NSString* const Notification_phoneCall_disconnected = @"Notification_phoneCall_disconnected";
NSString* const Notification_phoneCall_connected = @"Notification_phoneCall_connected";
NSString* const Notification_phoneCall_incoming = @"Notification_phoneCall_incoming";
NSString* const Notification_phoneCall_dialing = @"Notification_phoneCall_dialing";
NSString* const Notification_phoneCall_NothingIsDone = @"Notification_phoneCall_NothingIsDone";


#pragma mark - User Common Data Key
/*
 User Common Data Key
 */
NSString * const baseKey_username = @"baseKey_username";
NSString * const baseKey_userIDname = @"baseKey_userIDname";
NSString * const baseKey_password = @"baseKey_password";
NSString * const baseKey_email = @"baseKey_email";
NSString * const baseKey_mobile = @"baseKey_mobile";
NSString * const baseKey_mobile_prefix = @"baseKey_mobile_prefix";
NSString * const baseKey_sex = @"baseKey_sex";
NSString * const baseKey_realname = @"baseKey_realname";
NSString * const baseKey_type = @"baseKey_type";
NSString * const baseKey_Myuid = @"baseKey_Myuid";
NSString * const baseKey_nickname = @"baseKey_nickname";
NSString * const baseKey_city = @"baseKey_city";
NSString * const baseKey_token = @"baseKey_token";
NSString * const baseKey_myheadshot = @"baseKey_myheadshot";
NSString * const baseKey_myBackground = @"baseKey_myBackground";
NSString * const baseKey_deviceToken = @"baseKey_deviceToken";
NSString * const baseKey_deviceID = @"baseKey_deviceID";
NSString * const baseKey_loginType = @"baseKey_loginType";
NSString * const baseKey_timezone = @"baseKey_timezone";
NSString * const baseKey_job_position = @"baseKey_job_position";
NSString * const baseKey_interest_fields = @"baseKey_interest_fields";
NSString * const baseKey_userFriendlist = @"baseKey_userFriendlist";
NSString * const baseKey_sns_account = @"baseKey_sns_account";
NSString * const baseKey_sns_token = @"baseKey_sns_token";
NSString * const baseKey_sns_exptime = @"baseKey_sns_exptime";
NSString * const baseKey_tem_chat_record = @"baseKey_tem_chat_record";
NSString * const baseKey_autoLogin = @"baseKey_autoLogin";
NSString * const baseKey_avatarURL = @"baseKey_avatarURL";
NSString * const baseKey_Rebate = @"baseKey_Rebate";
NSString * const baseKey_Region = @"baseKey_Region";
NSString * const baseKey_likeValue = @"baseKey_likeValue";
NSString * const baseKey_viewValue = @"baseKey_viewValue";
NSString * const baseKey_latitude = @"baseKey_latitude";
NSString * const baseKey_longitude = @"baseKey_longitude";
NSString * const baseKey_loginMethod = @"baseKey_loginMethod";
NSString * const baseKey_signature = @"baseKey_signature";
NSString * const baseKey_period_status = @"baseKey_period_status";
NSString * const baseKey_period_status_dec = @"baseKey_period_status_dec";
NSString * const baseKey_is_apply = @"baseKey_is_apply";
NSString * const baseKey_daily_login = @"baseKey_daily_login";
NSString * const baseKey_exp_edu = @"baseKey_exp_edu";
NSString * const baseKey_exp_work = @"baseKey_exp_work";
NSString * const baseKey_im_account = @"baseKey_im_account";
NSString * const baseKey_location = @"baseKey_im_location";
NSString * const baseKey_unread_notify = @"baseKey_unread_notify";


NSString * const baseKey_rememBer = @"baseKey_rememBer";//记住密码标识
NSString * const baseKey_channelId = @"baseKey_channelId";//用來保存百度推度的channelid

//ring
NSString * const baseKey_ringtone = @"baseKey_ringtone";

//lock
NSString * const baseKey_lockEnable = @"baseKey_lockEnable";
NSString * const baseKey_lockPwd = @"baseKey_lockPwd";

//fund
NSString * const baseKey_fund_value = @"baseKey_fund_value";
NSString * const baseKey_avalible_fund = @"baseKey_avalible_fund";

/*
 Folder Path
 */
NSString* const defaultPath = @"Documents";
NSString* const defaultHistoryPath = @"/Library/Caches/history/";

/*
 DL Network param Key
 */
NSString * const DLRequestParam_PublishType_DailyLook = @"1";
NSString * const DLRequestParam_PublishType_ItemLook = @"2";
NSString * const DLRequestParam_LookType_Date = @"1";
NSString * const DLRequestParam_LookType_Casual = @"2";
NSString * const DLRequestParam_LookType_Formal = @"3";
NSString * const DLRequestParam_LookType_Party = @"4";
NSString * const DLRequestParam_LookType_Other = @"5";

/*
 cache File Key
 */
NSString * const cache_DLLooksFeed = @"cache_DLLooksFeed";
NSString * const cache_DLFeedList = @"cache_DLFeedList";
NSString * const cache_DLStoreLook = @"cache_DLStoreLook";
NSString * const cache_DLMyLookRecordList = @"cache_DLMyLookRecordList";
NSString * const cache_DLOrderList = @"cache_DLOrderList";
NSString * const cache_DLUserInfo = @"cache_DLUserInfo";
NSString * const cache_DLCatalogList = @"cache_DLCatalogList";
NSString * const cache_DLCatalogStoreItem = @"cache_DLCatalogStoreItem";
NSString * const cache_DLCatalogUsedStoreItem = @"cache_DLCatalogUsedStoreItem";
NSString * const cache_DLCatalogMyStoreItem = @"cache_DLCatalogMyStoreItem";

//------------------------项目---------------------------

NSString * const Notification_AliPayNotification = @"Notification_AliPayNotification";
NSString * const Notification_WXNotification = @"Notification_WXNotification";
NSString * const Notification_Language_Changed = @"Notification_Language_Changed";


NSString * const BASE_KEY_memberId = @"BASE_KEY_memberId";             //用户userID
NSString * const BASE_KEY_myCode = @"BASE_KEY_myCode";                 //邀请码
NSString * const BASE_KEY_phone = @"BASE_KEY_phone";                   //注册手机号
NSString * const BASE_KEY_faceImg = @"BASE_KEY_faceImg";               //用户头像
NSString * const BASE_KEY_name = @"BASE_KEY_name";                     //用户名


NSString * const BASE_KEY_AS_POSITIVE = @"BASE_KEY_AS_POSITIVE";               //身份正面
NSString * const BASE_KEY_IDENTITY_OPPOSITE = @"BASE_KEY_IDENTITY_OPPOSITE";   //身份反面
NSString * const BASE_KEY_HOLDING_IDENTITY = @"BASE_KEY_HOLDING_IDENTITY";     //手拿身份
NSString * const BASE_KEY_STUDENT_ID = @"BASE_KEY_STUDENT_ID";                 //学生证明
NSString * const BASE_KEY_STUDENT_PROOF = @"BASE_KEY_STUDENT_PROOF";           //学籍证明




NSString * const BaeKey_is_back_vc = @"BaeKey_is_back_vc";                   //
NSString * const BaeKey_field_str_7 = @"BaeKey_field_str_7";
NSString * const BaeKey_field_str_0 = @"BaeKey_field_str_0";

NSString * const BaeKey_CardID = @"BaeKey_CardID";
NSString * const BaeKey_Level = @"BaeKey_Level";
NSString * const BaeKey_Email = @"BaeKey_Email";
NSString * const BaeKey_Code = @"BaeKey_Code";
NSString * const BaeKey_MobileNo = @"BaeKey_MobileNo";
NSString * const BaeKey_HeadImage = @"BaeKey_HeadImage";
NSString * const BaeKey_Name = @"BaeKey_Name";
NSString * const BaeKey_Nickname = @"BaeKey_Nickname";
NSString * const BaeKey_Sex = @"BaeKey_Sex";
NSString * const BaeKey_Birth = @"BaeKey_Birth";
NSString * const BaeKey_Tel = @"BaeKey_Tel";
NSString * const BaeKey_Address = @"BaeKey_Address";
NSString * const BaeKey_UserPayType = @"BaeKey_UserPayType";

NSString * const BaeKey_address_default = @"BaeKey_address_default";
NSString * const BaeKey_address_mobile = @"BaeKey_address_mobile";
NSString * const BaeKey_address_name = @"BaeKey_address_name";
NSString * const BaeKey_address_Id = @"BaeKey_address_Id";

NSString * const BaeKey_IdCard_Front = @"BaeKey_IdCard_Front";
NSString * const BaeKey_IdCard_Reverse = @"BaeKey_IdCard_Reverse";



@end
