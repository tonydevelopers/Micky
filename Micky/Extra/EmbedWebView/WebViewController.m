//
//  WebViewController.m
//  NewStock
//
//  Created by Willey on 16/8/11.
//  Copyright © 2016年 Willey. All rights reserved.
//

#import "WebViewController.h"
#import "AppDelegate.h"
#import "UrlRedirectAction.h"


@implementation WebViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view.
//    self.title = _mytitle;
//    [_navBar setTitle:self.title];
//    
//    [_scrollView mas_updateConstraints:^(MASConstraintMaker *make) {
//        make.edges.equalTo(self.view).with.insets(UIEdgeInsetsMake(STATUS_AND_NAVIGATION_HEIGHT, 0, 0, 0));
//    }];
//    
//    [_scrollView updateConstraints];
//    [_scrollView layoutIfNeeded];
//    
//    _webView = [[UIWebView alloc] init];
//    [_webView setUserInteractionEnabled: YES ];	 //是否支持交互
//    [_webView setDelegate:self];	 //委托
//    [_webView setOpaque:YES];	 //透明
//    _webView.scrollView.bounces = NO;
//    [_mainView addSubview:_webView];	 //加载到自己的view
//    [_webView mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.edges.equalTo(_webView.superview).with.insets(UIEdgeInsetsMake(0,0,0,0));
//        
//    }];
    
    _progressProxy = [[NJKWebViewProgress alloc] init];
    _webView.delegate = _progressProxy;
    _progressProxy.webViewProxyDelegate = self;
    _progressProxy.progressDelegate = self;
//    
//    CGFloat progressBarHeight = 2.f;
//    _progressView = [[NJKWebViewProgressView alloc] init];
//    _progressView.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleTopMargin;
//    [_mainView addSubview:_progressView];
//    [_progressView mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.top.left.right.equalTo(_progressView.superview);
//        make.height.mas_equalTo(progressBarHeight);
//    }];
    
    //NSString *urlStr = [_myUrl stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    NSURL *url = [[NSURL alloc] initWithString:_myUrl];
    [_webView loadRequest:[NSURLRequest requestWithURL:url]];
    
}


-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
}

#pragma mark - NJKWebViewProgressDelegate
-(void)webViewProgress:(NJKWebViewProgress *)webViewProgress updateProgress:(float)progress
{
    [_progressView setProgress:progress animated:YES];
    self.title = [_webView stringByEvaluatingJavaScriptFromString:@"document.title"];
//    [_navBar setTitle:self.title];

}


- (BOOL)webView:(UIWebView *)webView shouldStartLoadWithRequest:(NSURLRequest *)request navigationType:(UIWebViewNavigationType)navigationType
{
    [UrlRedirectAction sharedUrlRedirectAction].delegate = self;
    return [UrlRedirectAction redirectActionWithUrl:request.URL from:self.myUrl navigationType:navigationType];
}


-(void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    if (alertView.tag == 1001)
    {
        //[self.navigationController popViewControllerAnimated:YES];
        
        [_webView reload];
        
    }
}

@end
