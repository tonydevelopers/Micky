//
//  PhotoTextMaxViewController.m
//  MickyEasyCredit
//
//  Created by 张宁 on 2017/4/14.
//  Copyright © 2017年 apple. All rights reserved.
//

#import "PhotoTextMaxViewController.h"
#import <JavaScriptCore/JavaScriptCore.h>
#import "AppDelegate.h"

#import "AdvertModel.h"

@interface PhotoTextMaxViewController ()<UIWebViewDelegate>
{
    UILabel *titleLabel;
    FCXRefreshHeaderView *headerView;
}
@property (nonatomic,strong)NSString *json_Str;
@property (nonatomic,strong)JSContext *jsContext;
@property(nonatomic,strong)UIButton  *rightButton;

@end

@implementation PhotoTextMaxViewController
- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    self.navigationController.navigationBar.hidden = NO;
    NAVIGATIONBAR_COLOR_STYLE(BUTTON_COLOR_NORMA,UIStatusBarStyleLightContent);
}
- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = BACKGROUND_COLOR;
    
    [self initData];
    [self initNavigate];
    [self initLayout];
    
}
#pragma mark - init
#pragma mark -- init/Data
- (void)initData {
    
}
#pragma mark -- init/navigate
- (void)initNavigate {
    UIView *navTitleView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 150, 30)];
    titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 5, navTitleView.frame.size.width-5, 20)];
    titleLabel.textAlignment = NSTextAlignmentCenter;
    titleLabel.textColor = [UIColor whiteColor];
    titleLabel.text = @"内容简介";
    titleLabel.font = [UIFont systemFontOfSize:20.0];
    [navTitleView addSubview:titleLabel];
    self.navigationItem.titleView = navTitleView;
    self.navigationController.navigationBar.backgroundColor = [UIColor clearColor];
    
    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    button.frame = CGRectMake(0,0,53,44);
    [button setImage:[UIImage imageNamed:@"navbar_back"] forState:UIControlStateNormal];
    [button setImageEdgeInsets:UIEdgeInsetsMake(0, -40, 0, 0)];
    [button addTarget:self action:@selector(popBack) forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem *barButtonItem = [[UIBarButtonItem alloc] initWithCustomView:button];
    [self.navigationItem setLeftBarButtonItem:barButtonItem];
    
}
#pragma mark -- init/Layout
- (void)initLayout {
    [CustomHUD createHudCustomShowContent:@"请稍等..."];
    
    self.view.backgroundColor = [UIColor colorWithRed:240/255.0 green:240/255.0 blue:240/255.0 alpha:1.0];
    self.webView.frame = CGRectMake(self.webView.frame.origin.x, self.webView.frame.origin.y, self.webView.frame.size.width, self.webView.frame.size.height);
    self.webView.scalesPageToFit = NO;
    self.webView.delegate = self;
    NSString *lastUrl = [self.PhotoTextMax_URL isEqualToString:@""] ? @"https://www.baidu.com" : self.PhotoTextMax_URL;
    [self.webView loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:lastUrl]]];
    
}
#pragma mark - webView Delegate
-(BOOL)webView:(UIWebView *)webView shouldStartLoadWithRequest:(NSURLRequest *)request navigationType:(UIWebViewNavigationType)navigationType {
    NSString *url = request.URL.absoluteString;
    debugLog(@"request = %@ == %@",request,url);
    
    return YES;
}
-(void)webViewDidFinishLoad:(UIWebView *)webView {
    [CustomHUD stopHidden];
    [super webViewDidFinishLoad:webView];
    self.jsContext  = [webView valueForKeyPath:@"documentView.webView.mainFrame.javaScriptContext"];
    self.jsContext[@"iOS"] = self;
    self.jsContext.exceptionHandler = ^(JSContext *context , JSValue *exceptionValue){
        context.exception = exceptionValue;
        NSLog(@"异常信息 = %@",exceptionValue);
    };
}

#pragma mark - Event
#pragma mark -- Event/返回
- (void)popBack {
  
    if ([AppDelegate getInstance].CurNavController.viewControllers.count<3) {
        [[AppDelegate getInstance].mainTabController showTabbarView];
    }
    [[AppDelegate getInstance].mainTabController showTabbarView];
    [[AppDelegate getInstance].CurNavController popToRootViewControllerAnimated:YES];
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}


@end
