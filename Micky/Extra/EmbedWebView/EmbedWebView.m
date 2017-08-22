//
//  EmbedWebViewController.m
//  NewStock
//
//  Created by Willey on 16/8/22.
//  Copyright © 2016年 Willey. All rights reserved.
//

#import "EmbedWebView.h"
#import "Masonry.h"
#import "WebViewController.h"
#import "AppDelegate.h"

@implementation EmbedWebView
@synthesize delegate;

- (id)initWithUrl:(NSString *)url
{
    self = [super init];
    if (self)
    {
    // Do any additional setup after loading the view.
    //    self.title = _mytitle;
    //    [_navBar setTitle:self.title];
    
        self.myUrl = url;
        
        _webView = [[UIWebView alloc] init];
        [_webView setUserInteractionEnabled: YES ];	 //是否支持交互
        [_webView setDelegate:self];	 //委托
        [_webView setOpaque:YES];	 //透明
        _webView.scrollView.scrollEnabled = NO;
        _webView.scrollView.bounces = NO;
        [self addSubview:_webView];	 //加载到自己的view
        [_webView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.edges.equalTo(_webView.superview).with.insets(UIEdgeInsetsMake(0,0,0,0));
            
        }];
        
        _progressProxy = [[NJKWebViewProgress alloc] init];
        _webView.delegate = _progressProxy;
        _progressProxy.webViewProxyDelegate = self;
        _progressProxy.progressDelegate = self;
        
        CGFloat progressBarHeight = 2.f;
        _progressView = [[NJKWebViewProgressView alloc] init];
        _progressView.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleTopMargin;
        [self addSubview:_progressView];
        [_progressView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.left.right.equalTo(_progressView.superview);
            make.height.mas_equalTo(progressBarHeight);
        }];
        
        NSString *urlStr = [_myUrl stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
        NSURL *url = [[NSURL alloc] initWithString:urlStr];
        [_webView loadRequest:[ NSURLRequest requestWithURL:url]];
    
    
    }
    
    return self;

}

- (void)setUrl:(NSString *)url
{
    self.myUrl = url;
    NSString *urlStr = [_myUrl stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    NSURL *newUrl = [[NSURL alloc] initWithString:urlStr];
    [_webView loadRequest:[ NSURLRequest requestWithURL:newUrl]];
}

//-(void)viewWillDisappear:(BOOL)animated
//{
//    [super viewWillDisappear:animated];
//
//    [_webView setDelegate:nil];
//
//}

#pragma mark - NJKWebViewProgressDelegate
-(void)webViewProgress:(NJKWebViewProgress *)webViewProgress updateProgress:(float)progress
{
    [_progressView setProgress:progress animated:YES];
    
}
- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    if([self.delegate respondsToSelector:@selector(scrollViewDidScroll:)])
    {
        [self.delegate scrollViewDidScroll:_webView.scrollView];
    }
}

- (void)webViewDidFinishLoad:(UIWebView *)wb
{
    NSInteger height = [[_webView stringByEvaluatingJavaScriptFromString:@"document.body.scrollHeight"] integerValue];
    NSLog(@"~~~~~~~contentSize width:%lf, height:%lf",wb.scrollView.contentSize.width,wb.scrollView.contentSize.height);

    if([self.delegate respondsToSelector:@selector(embedWebView:webViewHeight:)])
    {
        [self.delegate embedWebView:self webViewHeight:height];
    }

}

- (BOOL)webView:(UIWebView *)webView shouldStartLoadWithRequest:(NSURLRequest *)request navigationType:(UIWebViewNavigationType)navigationType
{
    //NSLog(@"%@",request.URL.relativeString);
    //NSLog(@"%@",request.URL.absoluteString);
    //NSLog(@"%@",request.URL.parameterString);
    //NSLog(@"%@",request.URL.path);
    //NSLog(@"%@",request.URL.relativePath);

    //    NSRange range = [self.myUrl rangeOfString:request.URL.path];
//    if (range.location ==NSNotFound)
//    {
//        
//        NSURL *url = request.URL;
//        WebViewController *viewController = [[WebViewController alloc] init];
//        viewController.myUrl = url.absoluteString;
//        AppDelegate *appDelegate = (AppDelegate *)[[UIApplication sharedApplication] delegate];
//        [appDelegate.navigationController pushViewController:viewController animated:YES];
//        
//        return NO;
//    }
//    else
//    {
//        return  YES;
//    }
    //NSLog(@"%ld",navigationType);
    
    //原生拦截hhh
    
    NSString *goods_Id = [request.URL.query substringFromIndex:3];
    NSString *url = request.URL.absoluteString;
    NSLog(@"request ==%@==%@<><><>%@",request.URL,request.URL.query,goods_Id);
    //首页跳转详情
    if([url rangeOfString:@"detail?"].location !=NSNotFound)
    {
        [self.delegate clickOnTheWeb:@"detail" GoodsDetailID:goods_Id];
    }
    //搜索
    if ([url rangeOfString:@"searchResult"].location != NSNotFound) {
        [self.delegate clickOnTheWeb:@"searchResult" GoodsDetailID:goods_Id];
    }
    //购物车--支付
    if ([url rangeOfString:@"order?"].location != NSNotFound) {
        [self.delegate clickOnTheWeb:@"order" GoodsDetailID:goods_Id];
    }

    
    
    
    [UrlRedirectAction sharedUrlRedirectAction].delegate = (id)self.delegate;
    return [UrlRedirectAction redirectActionWithUrl:request.URL from:self.myUrl navigationType:navigationType];
    
}

- (void)commentDidFinished
{
    [_webView reload];
}

@end
