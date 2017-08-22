//
//  AppDelegate.m
//  MickyEasyCredit
//
//  Created by 张宁 on 16/10/26.
//  Copyright © 2016年 apple. All rights reserved.
//

#import "AppDelegate.h"

#import "OneViewController.h"
#import "TwoViewController.h"
#import "ThreeViewController.h"
#import "FourViewController.h"
#import "APINetworkConfig.h"
#import "SDiOSVersion.h"

#import "MSIntroductionPage.h"
#import "MSIntroductionController.h"

#import "WXApiManager.h"
#import <AlipaySDK/AlipaySDK.h>
#import <UMSocialCore/UMSocialCore.h>
#import "NSString+MD5.h"
#import "NSData+Base64.h"
#import "RSAEncryptor.h"

@interface AppDelegate ()

@end

@implementation AppDelegate

static AppDelegate *thisApp;
static UIWindow *curWindow;

@synthesize window=_window,mainTabController;

@synthesize internetReachable=_internetReachable;

@synthesize OneNavController=_OneNavController,
            TwoNavController=_TwoNavController,
            ThreeNavController=_ThreeNavController,
            FourNavController=_FourNavController,
            CurNavController=_CurNavController;

- (UIInterfaceOrientationMask)application:(UIApplication *)application supportedInterfaceOrientationsForWindow:(UIWindow *)window {
    
    return UIInterfaceOrientationMaskPortrait;
}

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    self.window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
    SCREENWIDTH = [self.window bounds].size.width;
    SCREENHEIGH = [self.window bounds].size.height;
    curWindow = _window;
    thisApp = self;
    
    [NSThread sleepForTimeInterval:1.5];
    
    [self EnterApplication];
    
    NSString * str = @"这是一个测试qwerty.";
    NSLog(@"===| %@", [str md5]);
    
    //原始数据
    NSString *originalString = @"这是一段将要使用'.der'文件加密的字符串!";
    
    //使用.der和.p12中的公钥私钥加密解密
    NSString *public_key_path = [[NSBundle mainBundle] pathForResource:@"public_key.der" ofType:nil];
    NSString *private_key_path = [[NSBundle mainBundle] pathForResource:@"private_key.p12" ofType:nil];
    
    NSString *encryptStr = [RSAEncryptor encryptString:originalString publicKeyWithContentsOfFile:public_key_path];
    NSLog(@"加密前:%@", originalString);
    NSLog(@"加密后:%@", encryptStr);
    NSLog(@"解密后:%@", [RSAEncryptor decryptString:encryptStr privateKeyWithContentsOfFile:private_key_path password:@"***"]);
    
//    [self setupRequestFilters];
    [self socialManagerShare];
    [self setUpGuidePage];
    
    //三方--微信支付
    [WXApi registerApp:@"wx6d2454feb3662644" withDescription:@"demo 2.0"];
    
    
    [self.window makeKeyAndVisible];
    return YES;
}
- (void)applicationWillResignActive:(UIApplication *)application {
}
- (void)applicationDidEnterBackground:(UIApplication *)application {
}
- (void)applicationWillEnterForeground:(UIApplication *)application {
}
- (void)applicationDidBecomeActive:(UIApplication *)application {
}
- (void)applicationWillTerminate:(UIApplication *)application {
}
#pragma mark - Common
+(AppDelegate *) getInstance{
    return thisApp;
}
#pragma mark -- 网络设置，公共请求头
- (void)setupRequestFilters {
    //公共请求头
//    APINetworkConfig *config = [APINetworkConfig sharedInstance];
//    config.baseUrl = BASE_URL;
//    //公共请求头
//    NSString *appVersion = [[[NSBundle mainBundle] infoDictionary] objectForKey:@"CFBundleShortVersionString"];
//    NSString *deviceID = [SystemUtil getUUIDForDevice];
//    NSString *deviceType = DeviceVersionNames[[SDiOSVersion deviceVersion]];
//    NSString *deviceSystem = [SystemUtil getIOSVersion];
//    
//    NSDictionary *dic = @{
//                          @"deviceID":deviceID,
//                          @"phoneType":deviceType,
//                          @"phoneSystem":deviceSystem,
//                          @"appVersion":appVersion,
//                          @"apiVersion":appVersion};
//    config.headerDictionary = dic;
//    NSLog(@"deviceId == %@==%@",deviceID,dic);
//    [SystemUtil getAESPw:@"jiabei"];
}
#pragma mark -- 初始化主页
- (void)EnterApplication{
    //首页
    OneViewController *creditVC = [[OneViewController alloc] initWithNibName:nil bundle:nil RootNavController:nil];
    creditVC.title = @"";
    _OneNavController = [[MSNavigationController alloc] initWithNibName:nil bundle:nil];
    _OneNavController.navigationBar.translucent = NO;
    _OneNavController.navigationBar.barTintColor = BUTTON_COLOR_HIGHT;
    [_OneNavController initWithRootViewController:creditVC];
    [creditVC release];
    //商家
    TwoViewController * BusinessVC = [[TwoViewController alloc] init];
    BusinessVC.title = @"";
    _TwoNavController = [[MSNavigationController alloc] initWithNibName:nil bundle:nil];
    _TwoNavController.navigationBar.translucent = NO;
    _TwoNavController.navigationBar.barTintColor = BUTTON_COLOR_HIGHT;
    [_TwoNavController initWithRootViewController:BusinessVC];
    [BusinessVC release];
    
    //社区
    ThreeViewController *discussController = [[ThreeViewController alloc] initWithNibName:nil bundle:nil];
    _ThreeNavController.title = @"";
    _ThreeNavController = [[MSNavigationController alloc] initWithNibName:nil bundle:nil];
    _ThreeNavController.navigationBar.translucent = NO;
    _ThreeNavController.navigationBar.barTintColor = BUTTON_COLOR_HIGHT;
    [_ThreeNavController initWithRootViewController:discussController];
    [discussController release];
    
    //我的
    FourViewController *myHomeVC = [[FourViewController alloc] init];
    myHomeVC.title = @"";
    _FourNavController = [[MSNavigationController alloc] initWithNibName:nil bundle:nil];
    _FourNavController.navigationBar.translucent = NO;
    _FourNavController.navigationBar.barTintColor = BUTTON_COLOR_HIGHT;
    [_FourNavController initWithRootViewController:myHomeVC];
    [myHomeVC release];
    
    
    self.mainTabController = [[MainTabViewController alloc] init];
    self.mainTabController.viewControllers = [NSArray arrayWithObjects:_OneNavController,_TwoNavController,_ThreeNavController, _FourNavController,nil];
    
    self.window.rootViewController = self.mainTabController;
    [self.window addSubview:mainTabController.view];
    
    [[AppDelegate getInstance] hideTabBar];
    _CurNavController = self.OneNavController;
    [[[[AppDelegate getInstance] mainTabController] tabbarView].one_Btn sendActionsForControlEvents:UIControlEventTouchUpInside];
}
#pragma mark -- 设置引导页
- (void)setUpGuidePage {
    
    if(![[NSUserDefaults standardUserDefaults] boolForKey:appsetting_briefApp]){
        [[NSUserDefaults standardUserDefaults] setBool:YES forKey:appsetting_briefApp];
        NSLog(@"第一次启动");
    }else{
        [[NSUserDefaults standardUserDefaults] setBool:NO forKey:@"firstStart"];
        NSLog(@"不是第一次启动");
    }
    if ([[Gobal loadAppSetting:appsetting_briefApp] intValue] != 1 || [Gobal isEmptyString:[Gobal loadAppSetting:appsetting_briefApp]]){
        [AppDelegate getInstance].window.alpha = 0;
        MSIntroductionPage *layer1 = [[MSIntroductionPage alloc] initWithSubTitle:@""
                                                                      description:@""
                                                                      pictureName:[NSString stringWithFormat:@"default_%ld_1.png",(long)SCREENHEIGH]];
        MSIntroductionPage *layer2 = [[MSIntroductionPage alloc] initWithSubTitle:@""
                                                                      description:@""
                                                                      pictureName:[NSString stringWithFormat:@"default_%ld_2.png",(long)SCREENHEIGH]];
        MSIntroductionPage *layer3 = [[MSIntroductionPage alloc] initWithSubTitle:@""
                                                                      description:@""
                                                                      pictureName:[NSString stringWithFormat:@"default_%ld_3.png",(long)SCREENHEIGH]];
        
        MSIntroductionLabelStyle *subStyle = [[MSIntroductionLabelStyle alloc] init];
        [subStyle setFont:[UIFont boldSystemFontOfSize:20]];;
        [subStyle setTextColor:[UIColor colorWithRed:255/255.0f green:128/255.0f blue:49/255.0f alpha:1.0f]];
        [subStyle setLinesNumber:TUTORIAL_SUB_TITLE_LINES_NUMBER];
        [subStyle setOffset:TUTORIAL_SUB_TITLE_OFFSET-((SCREENHEIGH>500)?5:15)];
        
        MSIntroductionLabelStyle *subStyle2 = [[MSIntroductionLabelStyle alloc] init];
        [subStyle2 setFont:[UIFont boldSystemFontOfSize:20]];
        [subStyle2 setTextColor:[UIColor colorWithRed:194/255.0f green:110/255.0f blue:28/255.0f alpha:1.0f]];
        [subStyle2 setLinesNumber:TUTORIAL_SUB_TITLE_LINES_NUMBER];
        [subStyle2 setOffset:TUTORIAL_SUB_TITLE_OFFSET-((SCREENHEIGH>500)?-5:0)];
        
        MSIntroductionLabelStyle *subStyle3 = [[MSIntroductionLabelStyle alloc] init];
        [subStyle3 setFont:[UIFont boldSystemFontOfSize:20]];
        [subStyle3 setTextColor:[UIColor colorWithRed:239/255.0f green:92/255.0f blue:153/255.0f alpha:1.0f]];
        [subStyle3 setLinesNumber:TUTORIAL_SUB_TITLE_LINES_NUMBER];
        [subStyle3 setOffset:TUTORIAL_SUB_TITLE_OFFSET-((SCREENHEIGH>500)?-5:0)];
        
       
        
        MSIntroductionLabelStyle *descStyle = [[MSIntroductionLabelStyle alloc] init];
        [descStyle setFont:TUTORIAL_DESC_FONT];
        [descStyle setTextColor:[UIColor colorWithRed:255/255.0f green:128/255.0f blue:49/255.0f alpha:1.0f]];
        [descStyle setLinesNumber:TUTORIAL_DESC_LINES_NUMBER];
        [descStyle setOffset:TUTORIAL_DESC_OFFSET-((SCREENHEIGH>500)?5:15)];
        
        MSIntroductionLabelStyle *descStyle2 = [[MSIntroductionLabelStyle alloc] init];
        [descStyle2 setFont:TUTORIAL_DESC_FONT];
        [descStyle2 setTextColor:[UIColor colorWithRed:194/255.0f green:110/255.0f blue:28/255.0f alpha:1.0f]];
        [descStyle2 setLinesNumber:TUTORIAL_DESC_LINES_NUMBER];
        [descStyle2 setOffset:TUTORIAL_DESC_OFFSET-((SCREENHEIGH>500)?-10:-5)];
        
        MSIntroductionLabelStyle *descStyle3 = [[MSIntroductionLabelStyle alloc] init];
        [descStyle3 setFont:TUTORIAL_DESC_FONT];
        [descStyle3 setTextColor:[UIColor colorWithRed:239/255.0f green:92/255.0f blue:153/255.0f alpha:1.0f]];
        [descStyle3 setLinesNumber:TUTORIAL_DESC_LINES_NUMBER];
        [descStyle3 setOffset:TUTORIAL_DESC_OFFSET-((SCREENHEIGH>500)?-10:-5)];
        
        
        // Load into an array.
        NSArray *tutorialLayers = @[layer1,layer2,layer3];
        MSIntroductionController *controller = [[MSIntroductionController alloc] initWithNibName:nil
                                                                                          bundle:nil
                                                                                        andPages:tutorialLayers];
        //        [controller setCommonPageSubTitleStyle:subStyle];
        //        [controller setCommonPageDescriptionStyle:descStyle];
        [controller setSubTitleStyleArray:@[subStyle,subStyle2,subStyle3]];
        [controller setDescStyleArray:@[descStyle,descStyle2,descStyle3]];
        // Set button 1 action.
        //        [controller setButton1Block:^(UIButton *button){
        //
        //            [UIView animateWithDuration:0.5 animations:^{
        //                [AppDelegate getInstance].window.alpha = 0;
        //            } completion:^(BOOL finished) {
        //                [controller viewsDisappear];
        //                [UIView animateWithDuration:0.7 animations:^{
        //                    [AppDelegate getInstance].window.alpha = 1;
        //                    LoginViewController *loginController = [[LoginViewController alloc] initWithNibName:@"LoginViewController" bundle:nil];
        //                    UINavigationController *navController = [[UINavigationController alloc] initWithNibName:nil bundle:nil];
        //                    navController.navigationBar.barTintColor = [UIColor whiteColor];
        //                    [navController initWithRootViewController:loginController];
        //                    [[AppDelegate getInstance].mainTabController presentViewController:navController animated:([[[UIDevice currentDevice] systemVersion] floatValue] >= 7.1)?NO:YES completion:nil];
        //                }];
        //            }];
        //        }];
        [controller setButton2Block:^(UIButton *button){
            dispatch_async(dispatch_get_main_queue(), ^{
                [UIView animateWithDuration:0.5 animations:^{
                    [AppDelegate getInstance].window.alpha = 0;
                } completion:^(BOOL finished) {
                    [controller viewsDisappear];
                    dispatch_async(dispatch_get_main_queue(), ^{
                        [UIView animateWithDuration:0.5 animations:^{
                            [AppDelegate getInstance].window.alpha = 1;
                        }];
                    });
                }];
            });
        }];
        
        [subStyle release];
        [subStyle2 release];
        [subStyle3 release];
        [descStyle release];
        [descStyle2 release];
        [descStyle3 release];
        [layer1 release];
        [layer2 release];
        [layer3 release];
        [controller release];
        
        dispatch_async(dispatch_get_main_queue(), ^{
            [UIView animateWithDuration:0.9 animations:^{
                [[AppDelegate getInstance].mainTabController presentViewController:controller animated:YES completion:^{
                }];
                [AppDelegate getInstance].window.alpha = 1;
            } completion:^(BOOL finished) {
                
            }];
        });
    }

}
#pragma mark -- 隐藏tab
- (void)hideTabBar {
    if ([self.mainTabController respondsToSelector:@selector(setExtendedLayoutIncludesOpaqueBars:)]) {
        //iOS 7 - hide by property
        UITabBar *tabBar = self.mainTabController.tabBar;
        [self.mainTabController setExtendedLayoutIncludesOpaqueBars:YES];
        tabBar.hidden = YES;
    }
    UITabBar *tabBar = self.mainTabController.tabBar;
    UIView *parent = tabBar.superview; // UILayoutContainerView
    UIView *content = [parent.subviews objectAtIndex:0];  // UITransitionView
    UIView *window = parent.superview;
    
    [UIView animateWithDuration:0.01
                     animations:^{
                         CGRect tabFrame = tabBar.frame;
                         tabFrame.origin.y = CGRectGetMaxY(window.bounds)+50;
                         tabBar.frame = tabFrame;
                         content.frame = window.bounds;
                     }];
    
}
#pragma mark -- 显示tab
- (void)showTabBar {
    UITabBar *tabBar = self.mainTabController.tabBar;
    UIView *parent = tabBar.superview; // UILayoutContainerView
    UIView *content = [parent.subviews objectAtIndex:0];  // UITransitionView
    UIView *window = parent.superview;
    
    [UIView animateWithDuration:0.5
                     animations:^{
                         CGRect tabFrame = tabBar.frame;
                         tabFrame.origin.y = CGRectGetMaxY(window.bounds) - CGRectGetHeight(tabBar.frame);
                         tabBar.frame = tabFrame;
                         
                         CGRect contentFrame = content.frame;
                         contentFrame.size.height -= tabFrame.size.height;
                     }];
}
#pragma mark - Network Connection
+ (BOOL) checkNetworkStatus:(NSNotification *)notice
{
    // called after network status changes
    NetworkStatus internetStatus = [[[AppDelegate getInstance] internetReachable] currentReachabilityStatus];
    if (internetStatus == NotReachable) {
        return NO;
    }else{
        return YES;
    }
}
+ (NetworkStatus) checkNetworkType:(NSNotification *)notice
{
    // called after network status changes
    NetworkStatus internetStatus = [[[AppDelegate getInstance] internetReachable] currentReachabilityStatus];
    return internetStatus;
}
#pragma mark -- 召唤登录页面
- (void)callLoginView:(BOOL)isEnterLogin{
    [[AppDelegate getInstance].mainTabController hideTabbarView];
    LoginViewController *loginController = [[LoginViewController alloc] initWithNibName:@"LoginViewController" bundle:nil];
    loginController.is_Enter_login =isEnterLogin;
    [[AppDelegate getInstance].CurNavController pushViewController:loginController animated:YES];
}
#pragma mark -- 支付宝
-(BOOL)application:(UIApplication *)application openURL:(NSURL *)url sourceApplication:(NSString *)sourceApplication annotation:(id)annotation{
    if ([url.host isEqualToString:@"safepay"]) {
        [[AlipaySDK defaultService] processOrderWithPaymentResult:url standbyCallback:^(NSDictionary *resultDic) {
            NSLog(@"result = %@",resultDic);
            [[NSNotificationCenter defaultCenter] postNotificationName:Notification_AliPayNotification object:nil userInfo:@{@"resultDic":resultDic}];

        }];
        
        [[AlipaySDK defaultService] processAuth_V2Result:url
                                         standbyCallback:^(NSDictionary *resultDic) {
                                             NSLog(@"result = %@",resultDic);
                                             NSString *resultStr = resultDic[@"result"];
                                             NSLog(@"result = %@",resultStr);
                                             [[NSNotificationCenter defaultCenter] postNotificationName:Notification_AliPayNotification object:nil userInfo:@{@"resultDic":resultDic}];
                                         }];
    }
    else if ([url.host isEqualToString:@"platformapi"]){//支付宝钱包快登授权返回 authCode
        [[AlipaySDK defaultService] processAuthResult:url standbyCallback:^(NSDictionary *resultDic) {
            NSLog(@"result = %@",resultDic);
            [[NSNotificationCenter defaultCenter] postNotificationName:Notification_AliPayNotification object:nil userInfo:@{@"resultDic":resultDic}];
        }];
    }else if ([url.host isEqualToString:@"pay"]) {
        [[NSNotificationCenter defaultCenter] postNotificationName:Notification_WXNotification object:nil];
        return [WXApi handleOpenURL:url delegate:[WXApiManager sharedManager]];
    }
    return  YES ;
}
#pragma mark -- 支付宝 NOTE: 9.0以后使用新API接口
- (BOOL)application:(UIApplication *)app openURL:(NSURL *)url options:(NSDictionary<NSString*, id> *)options
{
    
    NSLog(@"sourceApplication == %@",url.host);
    if ([url.host isEqualToString:@"safepay"]) {
        [[AlipaySDK defaultService] processOrderWithPaymentResult:url standbyCallback:^(NSDictionary *resultDic) {
            NSLog(@"result = %@",resultDic);
            [[NSNotificationCenter defaultCenter] postNotificationName:Notification_AliPayNotification object:nil userInfo:@{@"resultDic":resultDic}];
        }];
        
        [[AlipaySDK defaultService] processAuth_V2Result:url
                                         standbyCallback:^(NSDictionary *resultDic) {
                                             NSLog(@"result = %@",resultDic);
                                             NSString *resultStr = resultDic[@"result"];
                                             NSLog(@"result = %@",resultStr);
                                             [[NSNotificationCenter defaultCenter] postNotificationName:Notification_AliPayNotification object:nil userInfo:@{@"resultDic":resultDic}];
                                         }];
    }
    else if ([url.host isEqualToString:@"platformapi"]){//支付宝钱包快登授权返回 authCode
        [[AlipaySDK defaultService] processAuthResult:url standbyCallback:^(NSDictionary *resultDic) {
            NSLog(@"result = %@",resultDic);
            [[NSNotificationCenter defaultCenter] postNotificationName:Notification_AliPayNotification object:nil userInfo:@{@"resultDic":resultDic}];
        }];
    }else if ([url.host isEqualToString:@"pay"]) {
        
        [[NSNotificationCenter defaultCenter] postNotificationName:Notification_WXNotification object:nil];
        return [WXApi handleOpenURL:url delegate:[WXApiManager sharedManager]];
    }
    return YES;
}
#pragma mark -- 微信支付
- (BOOL)application:(UIApplication *)application handleOpenURL:(NSURL *)url {
    
    [[NSNotificationCenter defaultCenter] postNotificationName:Notification_WXNotification object:nil];
    return  [WXApi handleOpenURL:url delegate:[WXApiManager sharedManager]];
}
#pragma mark -- 分享
- (void)socialManagerShare {
    
    [[UMSocialManager defaultManager] openLog:YES];
    [UMSocialGlobal shareInstance].isClearCacheWhenGetUserInfo = NO;
    [[UMSocialManager defaultManager] setUmSocialAppkey:USHARE_SHARE_APPKEY];
    [self configUSharePlatforms];
    
}
- (void)configUSharePlatforms {
    
    [[UMSocialManager defaultManager] setPlaform:UMSocialPlatformType_WechatSession appKey:WXAppKey appSecret:WXAppSecret redirectURL:QYDShare_URL([Gobal loadAppSetting:BASE_KEY_memberId])];
    
    [[UMSocialManager defaultManager] setPlaform:UMSocialPlatformType_QQ appKey:QQAppId appSecret:nil redirectURL:QYDShare_URL([Gobal loadAppSetting:BASE_KEY_memberId])];
        
}


@end
