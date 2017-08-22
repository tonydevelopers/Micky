//
//  ECPClientOrderViewCtrl.h
//  ECPayMobileSDK iOS Example
//
//  Created by 歐付寶 on 2014/11/3.
//  Copyright (c) 2014年 歐付寶. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol ECPWebViewCtrlDelegate <NSObject>

@optional
-(void)getExpressMap:(NSDictionary *)aDict;
@end

@interface ECPWebViewCtrl : UIViewController <UIWebViewDelegate>

@property (nonatomic) NSString *url;

@property (weak, nonatomic) id<ECPWebViewCtrlDelegate>delegate;
@property (weak, nonatomic) IBOutlet UIWebView *webView;
@property (weak, nonatomic) IBOutlet UIActivityIndicatorView *activityIndicator;

- (instancetype)initWithAttributes:(NSDictionary *)attributes;

// ---------------------------
// * 顯示WebView
// ---------------------------
+(instancetype)getWebViewWithURL:(NSString * )url attributes:(NSDictionary *)attributes;

+(instancetype)getWebViewWithDelegate:(id<ECPWebViewCtrlDelegate>)delegate URL:(NSString * )url attributes:(NSDictionary *)attributes;
//取得 rootViewController (UI 顯示用）
+(UIViewController *)getRootViewController;


+ (NSDictionary *)dictionaryWithQueryString:(NSString *)queryString;


@end

