//
//  MainTabViewController.h
//  HuaWei
//
//  Created by chan david on 5/4/13.
//  Copyright (c) 2013 Mosjoy. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MainListHeadView.h"
#import "TabbarView.h"
#import "Gobal.h"

@interface MainTabViewController : UITabBarController<UITabBarControllerDelegate,UITabBarDelegate>

@property (retain, nonatomic) UIPanGestureRecognizer        *panGestureRecognizer;
@property (retain, nonatomic) UIView                        *listView;
@property (retain, nonatomic) MainListHeadView              *headView;
@property (retain, nonatomic) TabbarView                    *tabbarView;
@property (assign, nonatomic) MainListViewStatus            status;

-(void)showHeaderView;
-(void)hideHeaderView;
-(void)showTabbarView;
-(void)hideTabbarView;
-(BOOL)isTabbarViewHidden;
-(void)showCatalogView;
-(void)showAllCatalogView;
-(void)hideCatalogView;

@end
