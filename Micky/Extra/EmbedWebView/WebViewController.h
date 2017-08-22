//
//  WebViewController.h
//  NewStock
//
//  Created by Willey on 16/8/11.
//  Copyright © 2016年 Willey. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "NJKWebViewProgress.h"
#import "NJKWebViewProgressView.h"
#import "UrlRedirectAction.h"
#import "BlurCommentView.h"

typedef NS_ENUM(NSInteger, WEB_VIEW_TYPE) {
    WEB_VIEW_TYPE_NOR,
    WEB_VIEW_TYPE_COMMENT,
    WEB_VIEW_TYPE_OTHER
};

@interface WebViewController : UIViewController<UIWebViewDelegate,NJKWebViewProgressDelegate,UrlRedirectActionDelegate,BlurCommentViewDelegate>
{
    UIWebView *_webView;
    NJKWebViewProgressView *_progressView;
    NJKWebViewProgress *_progressProxy;

    NSString *_sid;
    NSString *_commentNum;
    NSString *_fid;
    BOOL _hcd;//是否已收藏
}
@property(nonatomic,strong)NSString *mytitle;//标题
@property(nonatomic,strong)NSString *myUrl;//网页的连接
@property(nonatomic,assign)WEB_VIEW_TYPE type;//种类
@end
