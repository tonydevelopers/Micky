//
//  ExternalLinksViewController.m
//  MickyEasyCredit
//
//  Created by 张宁 on 2017/3/3.
//  Copyright © 2017年 apple. All rights reserved.
//

#import "ExternalLinksViewController.h"
#import <JavaScriptCore/JavaScriptCore.h>
#import "AppDelegate.h"

#import "BorrowDetailsViewController.h"


@interface ExternalLinksViewController ()<UIWebViewDelegate,UIAlertViewDelegate>
{
    UILabel *titleLabel;
}

@property(nonatomic,strong)UIButton  *rightButton;
@property (nonatomic, strong) NSString *json_Str;
@property (nonatomic, strong) JSContext *jsContext;

@end

@implementation ExternalLinksViewController
- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    self.navigationController.navigationBar.hidden = NO;
    NAVIGATIONBAR_COLOR_STYLE(BUTTON_COLOR_NORMA,UIStatusBarStyleLightContent);
}
- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = BACKGROUND_COLOR;
    self.navigationController.navigationBar.hidden = NO;

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
    titleLabel.text = _class_name;
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
    NSString *lastUrl = [self.externalLink_url isEqualToString:@""] ? @"https://www.baidu.com" : self.externalLink_url;
    [self.webView loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:lastUrl]]];
    
}
#pragma mark - webView Delegate
-(BOOL)webView:(UIWebView *)webView shouldStartLoadWithRequest:(NSURLRequest *)request navigationType:(UIWebViewNavigationType)navigationType {
    debugLog(@"request = %@",request);
    
    NSString *url = request.URL.absoluteString;
    [super webView:webView shouldStartLoadWithRequest:request navigationType:navigationType];

    if ([url rangeOfString:@"personalSaveStatus?status=success"].location != NSNotFound) {
        [self popBack];
    }
    if ([url rangeOfString:@"educationSaveStatus?status=success"].location != NSNotFound) {
        [self popBack];
    }
    if ([url rangeOfString:@"contactSaveStatus?status=success"].location != NSNotFound) {
        [self popBack];
    }
    if ([url rangeOfString:@"toJkDetailSaveStatus?status=success"].location != NSNotFound) {
        [self popBack];
    }
    if ([url rangeOfString:@"whiteCollarSaveStatus?status=success"].location != NSNotFound) {
        [self popBack];
    }
    if ([url rangeOfString:@"hkSaveStatus?status=success"].location != NSNotFound) {
        [webView reload];
        UIAlertView *alert = [[UIAlertView alloc]initWithTitle:@"温馨提示" message:@"还款成功,请查询还款记录" delegate:self cancelButtonTitle:@"好" otherButtonTitles: nil];
        [alert show];
    }
    if ([url rangeOfString:@"loanQuery?id"].location != NSNotFound) {
        [[AppDelegate getInstance].mainTabController hideTabbarView];
        BorrowDetailsViewController *ELVC = [[BorrowDetailsViewController alloc]init];
        ELVC.class_name = @"借款详情";
        ELVC.externalLink_url = [NSString stringWithFormat:@"%@",url];
        [[AppDelegate getInstance].CurNavController pushViewController:ELVC animated:YES];
        [self.webView reload];
    }
    if ([url rangeOfString:@"toResetPhone?userId"].location != NSNotFound) {
        [[AppDelegate getInstance].mainTabController hideTabbarView];
        BorrowDetailsViewController *ELVC = [[BorrowDetailsViewController alloc]init];
        ELVC.class_name = @"重置服务密码";
        ELVC.externalLink_url = [NSString stringWithFormat:@"%@",url];
        [[AppDelegate getInstance].CurNavController pushViewController:ELVC animated:YES];
        [self.webView reload];
    }
    
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
- (void)alertView:(UIAlertView *)alertView didDismissWithButtonIndex:(NSInteger)buttonIndex {
    [self popBack];
}
#pragma mark - Event
#pragma mark -- Event/返回
- (void)popBack {
    if (_isRooterEnter) {
        if (_is_show_header) {
            if ([AppDelegate getInstance].CurNavController.viewControllers.count<3) {
                [[AppDelegate getInstance].mainTabController showTabbarView];
            }
            [[AppDelegate getInstance].mainTabController showTabbarView];
            [[AppDelegate getInstance].CurNavController popToRootViewControllerAnimated:YES];
        }else {
            if ([AppDelegate getInstance].CurNavController.viewControllers.count<3) {
                [[AppDelegate getInstance].mainTabController showTabbarView];
            }
            self.navigationController.navigationBar.hidden = YES;
            [[AppDelegate getInstance].mainTabController showTabbarView];
            [[AppDelegate getInstance].CurNavController popToRootViewControllerAnimated:YES];
        }
    }else {
        [[AppDelegate getInstance].mainTabController hideTabbarView];
        [[AppDelegate getInstance].CurNavController popViewControllerAnimated:YES];
    }
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}
@end
