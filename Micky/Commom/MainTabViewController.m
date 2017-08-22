//
//  MainTabViewController.m
//  HuaWei
//
//  Created by chan david on 5/4/13.
//  Copyright (c) 2013 Mosjoy. All rights reserved.
//

#import "MainTabViewController.h"
#import "AppDelegate.h"
#import "Gobal.h"

@interface MainTabViewController ()

@end

@implementation MainTabViewController
@synthesize panGestureRecognizer;
@synthesize listView;
@synthesize headView;
@synthesize tabbarView;
@synthesize status;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];

    
    TabbarView *aTabbarView = [[TabbarView alloc] init];
    self.tabbarView = aTabbarView;
    [self.view addSubview:self.tabbarView];
    [aTabbarView release];
    [self.tabbarView.rightSegment setSelectedSegmentIndex:0];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - control view slide
-(void)showHeaderView{
    self.headView.frame = MainListHeadViewShowPositionProtrait;
}

-(void)hideHeaderView{
    if (![UIApplication sharedApplication].statusBarHidden)
        self.headView.frame = MainListHeadViewHidePositionProtrait;
    else
        self.headView.frame = MainListHeadViewHidePositionProtraitWhenHideStatusBar;
}

-(void)showTabbarView{
    [UIView beginAnimations:@"Open" context:NULL];
    [UIView setAnimationDuration:.3];
    if (SCREENHEIGH == 568)
        self.tabbarView.frame = MainViewTabbarShowPositionProtraitH;
    else
        self.tabbarView.frame = MainViewTabbarShowPositionProtrait;
    [UIView commitAnimations];
}

-(void)hideTabbarView{
    [UIView beginAnimations:@"Close" context:NULL];
    [UIView setAnimationDuration:.3];
    self.tabbarView.frame = MainViewTabbarHidePositionProtrait;
    [UIView commitAnimations];
}

-(BOOL)isTabbarViewHidden{
    return (self.tabbarView.frame.origin.y == MainViewTabbarHidePositionProtrait.origin.y)?YES:NO;
}

- (void)tabBarController:(UITabBarController *)tabBarController didSelectViewController:(UIViewController *)viewController{
    if([tabBarController selectedIndex] == 0){
        [AppDelegate getInstance].CurNavController = [AppDelegate getInstance].OneNavController;
    }
    else if([tabBarController selectedIndex] == 1){
        [AppDelegate getInstance].CurNavController = [AppDelegate getInstance].TwoNavController;
    }
    else if([tabBarController selectedIndex] == 2){
        [AppDelegate getInstance].CurNavController = [AppDelegate getInstance].ThreeNavController;
    }
    else if([tabBarController selectedIndex] == 3){
        [AppDelegate getInstance].CurNavController = [AppDelegate getInstance].FourNavController;
    }
}

- (BOOL)tabBarController:(UITabBarController *)tabBarController shouldSelectViewController:(UIViewController *)viewController NS_AVAILABLE_IOS(3_0){
    NSLog(@"shouldSelectViewController");
    return YES;
}

#pragma mark - UIGestureRecognizerDelegate
- (BOOL)gestureRecognizer:(UIGestureRecognizer *)gestureRecognizer shouldReceiveTouch:(UITouch *)touch {
    if ([gestureRecognizer isKindOfClass:[UIPanGestureRecognizer class]]) {
        return YES;
    }
    return NO;
}

@end
