//
//  AppDelegate.h
//  MickyEasyCredit
//
//  Created by 张宁 on 16/10/26.
//  Copyright © 2016年 apple. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <AVFoundation/AVFoundation.h>
#import "MSNavigationController.h"
#import "MainTabViewController.h"
#import "UIViewController+HUD.h"
#import "UIView+MBProgressHUD.h"
#import "Reachability.h"
#import "NO_Data_View.h"
#import "SystemUtil.h"
#import "CustomHUD.h"
#import "Masonry.h"

#import "FCXRefreshFooterView.h"
#import "FCXRefreshHeaderView.h"
#import "UIScrollView+FCXRefresh.h"
#import "InternationalCintrol.h"

#import "LoginViewController.h"


@interface AppDelegate : NSObject <UIApplicationDelegate>

@property (strong, nonatomic) UIWindow *window;
@property (strong, nonatomic) Reachability* internetReachable;
@property (strong, nonatomic) MainTabViewController *mainTabController;
@property (strong, nonatomic) MSNavigationController *CurNavController;

@property (strong, nonatomic) MSNavigationController *OneNavController;
@property (strong, nonatomic) MSNavigationController *TwoNavController;
@property (strong, nonatomic) MSNavigationController *ThreeNavController;
@property (strong, nonatomic) MSNavigationController *FourNavController;

@property (strong, nonatomic) NSDictionary *headerDictionary;

+(AppDelegate*)getInstance;

-(void)hideTabBar;
-(void)showTabBar;
- (void)callLoginView:(BOOL)isEnterLogin;

@end









