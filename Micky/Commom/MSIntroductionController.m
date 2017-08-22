//
//  MSIntroductionController.m
//  MickyEasyCredit
//
//  Created by 张宁 on 2017/5/24.
//  Copyright © 2017年 apple. All rights reserved.
//

#import "MSIntroductionController.h"
#import "AppDelegate.h"
#import "Gobal.h"

@interface MSIntroductionController ()
{
    BOOL _statusBarHiddenInited;
    NSMutableArray* _permissions;
    NSMutableArray *_subTitleStyleArray;
    NSMutableArray *_descTitleStyleArray;
}

@end

@implementation MSIntroductionController
@synthesize autoScrollEnabled = _autoScrollEnabled;
@synthesize autoScrollLooping = _autoScrollLooping;
@synthesize autoScrollDurationOnPage = _autoScrollDurationOnPage;
@synthesize commonPageSubTitleStyle = _commonPageSubTitleStyle;
@synthesize commonPageDescriptionStyle = _commonPageDescriptionStyle;

- (id)initWithNibName:(NSString *)nibNameOrNil
               bundle:(NSBundle *)nibBundleOrNil{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self){
        _autoScrollEnabled = YES;
        _autoScrollLooping = YES;
        _autoScrollDurationOnPage = TUTORIAL_DEFAULT_DURATION_ON_PAGE;
    }
    return self;
}
- (id)initWithNibName:(NSString *)nibNameOrNil
               bundle:(NSBundle *)nibBundleOrNil
             andPages:(NSArray *)pages{
    self = [self initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self){
        _pages = pages;
    }
    return self;
}
- (id)initWithNibName:(NSString *)nibNameOrNil
               bundle:(NSBundle *)nibBundleOrNil
                pages:(NSArray *)pages
         button1Block:(ButtonBlock)block1
         button2Block:(ButtonBlock)block2{
    self = [self initWithNibName:nibNameOrNil bundle:nibBundleOrNil andPages:pages];
    if (self){
        _button1Block = block1;
        _button2Block = block2;
    }
    return self;
}
- (void)dealloc{
    _subTitleStyleArray = nil;
}

- (void)viewDidLoad {
    [super viewDidLoad];
//    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(sinaLogin:) name:LoginNotification_sina object:nil];
//    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(sinaLogin:) name:LoginNotification_qq object:nil];
    
//    _permissions = [NSArray arrayWithObjects:
//                    kOPEN_PERMISSION_GET_USER_INFO,
//                    kOPEN_PERMISSION_GET_SIMPLE_USER_INFO,
                    //                     kOPEN_PERMISSION_ADD_ALBUM,
                    //                     kOPEN_PERMISSION_ADD_IDOL,
                    //                     kOPEN_PERMISSION_ADD_ONE_BLOG,
                    //                     kOPEN_PERMISSION_ADD_PIC_T,
                    //                     kOPEN_PERMISSION_ADD_SHARE,
                    //                     kOPEN_PERMISSION_ADD_TOPIC,
                    //                     kOPEN_PERMISSION_CHECK_PAGE_FANS,
                    //                     kOPEN_PERMISSION_DEL_IDOL,
                    //                     kOPEN_PERMISSION_DEL_T,
                    //                     kOPEN_PERMISSION_GET_FANSLIST,
                    //                     kOPEN_PERMISSION_GET_IDOLLIST,
                    //                     kOPEN_PERMISSION_GET_INFO,
                    //                     kOPEN_PERMISSION_GET_OTHER_INFO,
                    //                     kOPEN_PERMISSION_GET_REPOST_LIST,
                    //                     kOPEN_PERMISSION_LIST_ALBUM,
                    //                     kOPEN_PERMISSION_UPLOAD_PIC,
                    //                     kOPEN_PERMISSION_GET_VIP_INFO,
                    //                     kOPEN_PERMISSION_GET_VIP_RICH_INFO,
                    //                     kOPEN_PERMISSION_GET_INTIMATE_FRIENDS_WEIBO,
                    //                     kOPEN_PERMISSION_MATCH_NICK_TIPS_WEIBO,
                    //nil];
//    _tencentOAuth = [[TencentOAuth alloc] initWithAppId:WiressTecentSDKAppKey
//                                            andDelegate:self];
    
//    _statusBarHiddenInited = [UIApplication sharedApplication].isStatusBarHidden;
//    // 隐藏状态栏
//        [[UIApplication sharedApplication] setStatusBarHidden:YES withAnimation:UIStatusBarAnimationFade];
    
    if ([[[UIDevice currentDevice] systemVersion] floatValue] >= 7.0)
    {
        [self setExtendedLayoutIncludesOpaqueBars:NO];
        [self setEdgesForExtendedLayout:UIRectEdgeBottom | UIRectEdgeLeft | UIRectEdgeRight];
    }
    [[self view] setBackgroundColor:[UIColor whiteColor]];
    
    _windowSize = [[UIScreen mainScreen] bounds].size;
    [self.view setFrame:CGRectMake(0, 0, _windowSize.width, _windowSize.height)];
    
    //setup view
    _frontLayerView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, _windowSize.width, _windowSize.height)];
    [_frontLayerView setBackgroundColor:[UIColor clearColor]];
    _frontLayerView.contentMode = UIViewContentModeScaleAspectFill;
    [self.view addSubview:_frontLayerView];
    
    _backLayerView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, _windowSize.width, _windowSize.height)];
    [_backLayerView setBackgroundColor:[UIColor clearColor]];
    _backLayerView.contentMode = UIViewContentModeScaleAspectFill;
    [self.view addSubview:_backLayerView];
    
    //    UIImageView *bgGradient = [[UIImageView alloc] initWithFrame:CGRectMake(0, _windowSize.height-200, _windowSize.width, 200)];
    //    [bgGradient setBackgroundColor:[UIColor clearColor]];
    //    [bgGradient setImage:[UIImage imageNamed:@"background-gradient.png"]];
    //    bgGradient.contentMode = UIViewContentModeCenter;
    //    [self.view addSubview:bgGradient];
    
    _scrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 0, _windowSize.width, _windowSize.height)];
    [_scrollView setBackgroundColor:[UIColor clearColor]];
    [_scrollView setScrollEnabled:YES];
    [_scrollView setPagingEnabled:YES];
    _scrollView.delegate = self;
    [_scrollView setShowsHorizontalScrollIndicator:NO];
    [_scrollView setShowsVerticalScrollIndicator:NO];
    [_scrollView setUserInteractionEnabled:YES];
    [_scrollView setBounces:YES];
    [_scrollView setBouncesZoom:YES];
    _scrollView.contentMode = UIViewContentModeScaleAspectFill;
    [self.view addSubview:_scrollView];
    
    _pageControl = [[UIPageControl alloc] initWithFrame:CGRectMake((_windowSize.width-39)/2.0, _windowSize.height-32, 39, 37)];
    _pageControl.currentPageIndicatorTintColor = BUTTON_COLOR_NORMA;
    _pageControl.pageIndicatorTintColor = [UIColor grayColor];
    _pageControl.contentMode = UIViewContentModeScaleToFill;
    _pageControl.contentHorizontalAlignment = UIControlContentHorizontalAlignmentCenter;
    _pageControl.contentVerticalAlignment = UIControlContentVerticalAlignmentCenter;
    [_pageControl addTarget:self action:@selector(didClickOnPageControl:) forControlEvents:UIControlEventValueChanged];
    [self.view addSubview:_pageControl];
    
    
    //    UIButton *endBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    //    [endBtn setFrame:CGRectMake(_windowSize.width/2-134/2+self.view.frame.size.width*3, _windowSize.height-39-60, 134, 39)];
    ////    [phoneLoginBtn setBackgroundImage:[UIImage imageNamed:@"Button-02.png"] forState:UIControlStateNormal];
    //    endBtn.backgroundColor = [UIColor whiteColor];
    //    [endBtn setTitle:@"END" forState:UIControlStateNormal];
    //    endBtn.titleLabel.textAlignment = UITextAlignmentCenter;
    //    endBtn.titleLabel.textColor = [UIColor blackColor];
    //    [endBtn.titleLabel setFont:[UIFont boldSystemFontOfSize:16]];
    //    endBtn.tag = 1;
    //    [endBtn addTarget:self action:@selector(didClickOnButton1:) forControlEvents:UIControlEventTouchUpInside];
    //    [_scrollView addSubview:endBtn];
    
    //    UIButton *phoneLoginBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    //    [phoneLoginBtn setFrame:CGRectMake((_windowSize.width/2-134)/2, _windowSize.height-39-60, 134, 39)];
    //    [phoneLoginBtn setBackgroundImage:[UIImage imageNamed:@"Button-02.png"] forState:UIControlStateNormal];
    //    [phoneLoginBtn setTitle:@"登录" forState:UIControlStateNormal];
    //    phoneLoginBtn.titleLabel.textAlignment = UITextAlignmentCenter;
    //    phoneLoginBtn.titleLabel.textColor = [UIColor whiteColor];
    //    [phoneLoginBtn.titleLabel setFont:[UIFont boldSystemFontOfSize:16]];
    //    phoneLoginBtn.tag = 1;
    //    [phoneLoginBtn addTarget:self action:@selector(didClickOnButton1:) forControlEvents:UIControlEventTouchUpInside];
    //    [self.view addSubview:phoneLoginBtn];
    //
    //    UIButton *registerBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    //    [registerBtn setFrame:CGRectMake((_windowSize.width/2-134)/2+_windowSize.width/2, _windowSize.height-39-60, 134, 39)];
    //    [registerBtn setBackgroundImage:[UIImage imageNamed:@"Button-02.png"] forState:UIControlStateNormal];
    //    [registerBtn setTitle:@"注冊" forState:UIControlStateNormal];
    //    registerBtn.titleLabel.textAlignment = UITextAlignmentCenter;
    //    registerBtn.titleLabel.textColor = [UIColor whiteColor];
    //    [registerBtn.titleLabel setFont:[UIFont boldSystemFontOfSize:16]];
    //    registerBtn.tag = 2;
    //    [registerBtn addTarget:self action:@selector(didClickOnButton1:) forControlEvents:UIControlEventTouchUpInside];
    //    [self.view addSubview:registerBtn];
    //
    //    UIImageView *qqImage = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"login_QQ"]];
    //    [qqImage setFrame:CGRectMake(CGRectGetMinX(phoneLoginBtn.frame)+30, CGRectGetMaxY(phoneLoginBtn.frame)+30, CGRectGetMaxX(qqImage.frame), CGRectGetMaxY(qqImage.frame))];
    //    [self.view addSubview:qqImage];
    //
    //    UIImageView *sinaImage = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"login_sina"]];
    //    [sinaImage setFrame:CGRectMake(CGRectGetMinX(registerBtn.frame)+30, CGRectGetMaxY(registerBtn.frame)+30, CGRectGetMaxX(sinaImage.frame), CGRectGetMaxY(sinaImage.frame))];
    //    [self.view addSubview:sinaImage];
    //
    //    UIButton *qqBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    //    [qqBtn setFrame:CGRectMake(CGRectGetMaxX(qqImage.frame)+20, CGRectGetMinY(qqImage.frame), 80, 30)];
    //    qqBtn.center = CGPointMake(qqBtn.center.x, CGRectGetMidY(qqImage.frame));
    //    [qqBtn setTitle:@"QQ 登录" forState:UIControlStateNormal];
    //    qqBtn.titleLabel.textAlignment = UITextAlignmentCenter;
    //    qqBtn.titleLabel.textColor = [UIColor whiteColor];
    //    [qqBtn.titleLabel setFont:[UIFont boldSystemFontOfSize:12]];
    //    qqBtn.tag = 3;
    ////    [qqBtn addTarget:self action:@selector(onClickTencentOAuth) forControlEvents:UIControlEventTouchUpInside];
    //    [self.view addSubview:qqBtn];
    //
    //    UIImageView *underline = [[UIImageView alloc] initWithFrame:CGRectMake(CGRectGetMinX(phoneLoginBtn.frame), CGRectGetMaxY(qqImage.frame)+5, CGRectGetWidth(phoneLoginBtn.frame), 1)];
    //    [underline setBackgroundColor:[UIColor whiteColor]];
    //    [self.view addSubview:underline];
    //
    //    UIImageView *rightline = [[UIImageView alloc] initWithFrame:CGRectMake(CGRectGetMidX(phoneLoginBtn.frame), CGRectGetMinY(qqImage.frame)+1, 1, 8)];
    //    [rightline setImage:[UIImage imageNamed:@"login_rightline"]];
    //    [self.view addSubview:rightline];
    //
    //    UIButton *sinaBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    //    [sinaBtn setFrame:CGRectMake(CGRectGetMaxX(sinaImage.frame)+20, CGRectGetMinY(sinaImage.frame), 80, 30)];
    //    sinaBtn.center = CGPointMake(sinaBtn.center.x, CGRectGetMidY(sinaImage.frame));
    //    [sinaBtn setTitle:@"微博登录" forState:UIControlStateNormal];
    //    sinaBtn.titleLabel.textAlignment = UITextAlignmentCenter;
    //    sinaBtn.titleLabel.textColor = [UIColor whiteColor];
    //    [sinaBtn.titleLabel setFont:[UIFont boldSystemFontOfSize:12]];
    //    sinaBtn.tag = 4;
    //    [sinaBtn addTarget:self action:@selector(ssoButtonPressed) forControlEvents:UIControlEventTouchUpInside];
    //    [self.view addSubview:sinaBtn];
    //
    //    UIImageView *underline2 = [[UIImageView alloc] initWithFrame:CGRectMake(CGRectGetMinX(registerBtn.frame), CGRectGetMaxY(sinaImage.frame)+5, CGRectGetWidth(registerBtn.frame), 1)];
    //    [underline2 setBackgroundColor:[UIColor whiteColor]];
    //    [self.view addSubview:underline2];
    //
    //    UIImageView *rightline2 = [[UIImageView alloc] initWithFrame:CGRectMake(CGRectGetMidX(registerBtn.frame), CGRectGetMinY(sinaImage.frame)+1, 1, 8)];
    //    [rightline2 setImage:[UIImage imageNamed:@"login_rightline"]];
    //    [self.view addSubview:rightline2];
    //
    //    if ([[UIApplication sharedApplication] canOpenURL:[NSURL URLWithString:@"mqq://"]]){
    //        qqImage.hidden = NO;
    //        qqBtn.hidden = NO;
    //        rightline.hidden = NO;
    //        underline.hidden = NO;
    //        [qqBtn addTarget:self action:@selector(onClickTencentOAuth) forControlEvents:UIControlEventTouchUpInside];
    //    }
    //    else{
    //        qqImage.hidden = YES;
    //        qqBtn.hidden = YES;
    //        rightline.hidden = YES;
    //        underline.hidden = YES;
    //        [qqBtn addTarget:self action:@selector(webQQAuthClick) forControlEvents:UIControlEventTouchUpInside];
    //
    //        sinaImage.hidden = NO;
    //        sinaBtn.hidden = NO;
    //        rightline2.hidden = NO;
    //        underline2.hidden = NO;
    //
    //    }
    
    // ScrollView configuration.
    [_scrollView setContentSize:CGSizeMake([self numberOfPages] * _windowSize.width+_windowSize.width,
                                           _scrollView.contentSize.height)];
    [_scrollView setPagingEnabled:YES];
    
    // PageControl configuration.
    [_pageControl setNumberOfPages:[self numberOfPages]];
    [_pageControl setCurrentPage:0];
    
    for (int i=0; i<_pages.count; i++) {
        MSIntroductionPage *layer = [_pages objectAtIndex:i];
        UIImageView *imageview = [[UIImageView alloc] initWithImage:[UIImage imageNamed:layer.pictureName]];
        imageview.frame = CGRectMake(i*_windowSize.width, 0, _windowSize.width, _windowSize.height);
        [_scrollView addSubview:imageview];
        
        if (i==2) {
            imageview.userInteractionEnabled = YES;
            
            //            UIButton *phoneLoginBtn = [UIButton buttonWithType:UIButtonTypeCustom];
            //            [phoneLoginBtn setFrame:CGRectMake((_windowSize.width/2-134)/2, _windowSize.height-39-20, 134, 39)];
            //            [phoneLoginBtn setBackgroundImage:[Gobal imageWithColor:[UIColor whiteColor] size:phoneLoginBtn.frame.size] forState:UIControlStateNormal];
            //            [phoneLoginBtn setTitle:@"注冊登录" forState:UIControlStateNormal];
            //            phoneLoginBtn.titleLabel.textAlignment = UITextAlignmentCenter;
            //            [phoneLoginBtn setTitleColor:[UIColor colorWithRed:126/255.0f green:205/255.0f blue:245/255.0f alpha:1.0f] forState:UIControlStateNormal];
            //            [phoneLoginBtn.titleLabel setFont:[UIFont boldSystemFontOfSize:16]];
            //            phoneLoginBtn.layer.cornerRadius = 5.0;
            //            phoneLoginBtn.clipsToBounds = YES;
            //            phoneLoginBtn.tag = 1;
            //            [phoneLoginBtn addTarget:self action:@selector(didClickOnButton1:) forControlEvents:UIControlEventTouchUpInside];
            //            [imageview addSubview:phoneLoginBtn];
            //
            //            UIButton *registerBtn = [UIButton buttonWithType:UIButtonTypeCustom];
            //            [registerBtn setFrame:CGRectMake(_windowSize.width/2-134/2, _windowSize.height-39-30, 134, 39)];
            //            [registerBtn setBackgroundImage:[Gobal imageWithColor:[UIColor whiteColor] size:registerBtn.frame.size] forState:UIControlStateNormal];
            //            [registerBtn setTitle:@"马上体验" forState:UIControlStateNormal];
            //            registerBtn.titleLabel.textAlignment = UITextAlignmentCenter;
            //            [registerBtn setTitleColor:[UIColor colorWithRed:109/255.0f green:214/255.0f blue:209/255.0f alpha:1.0f] forState:UIControlStateNormal];
            //            [registerBtn.titleLabel setFont:[UIFont boldSystemFontOfSize:16]];
            //            registerBtn.layer.cornerRadius = 5.0;
            //            registerBtn.clipsToBounds = YES;
            //            registerBtn.tag = 2;
            //            [registerBtn addTarget:self action:@selector(didClickOnButton1:) forControlEvents:UIControlEventTouchUpInside];
            //            [imageview addSubview:registerBtn];
        }
    }
    
    //    // Overlays.
    //    [self setOverlayTexts];
    //    
    //    // Preset the origin state.
    //    [self setOriginLayersState];
    //
    //    // Run the auto-scrolling.
    ////    [self autoScrollToNextPage];
}
- (void)viewDidUnload{
    [[NSNotificationCenter defaultCenter] removeObserver:self name:LoginNotification_sina object:nil];
    [super viewDidUnload];
}
- (void)viewsDisappear{
    [Gobal saveAppSetting:@"1" Key:appsetting_briefApp];
    [UIApplication sharedApplication].statusBarHidden = _statusBarHiddenInited;
    [self dismissViewControllerAnimated:NO completion:^{
        
    }];
    //        [self.view removeFromSuperview];
    //        [self removeFromParentViewController];
}
#pragma mark - Actions
- (void)setButton1Block:(ButtonBlock)block{
    _button1Block = block;
}

- (void)setButton2Block:(ButtonBlock)block{
    _button2Block = block;
}

- (void)setQQBtnBlock:(ButtonBlock)block{
    _qqBtnBlock = block;
}

- (void)setSinaBtnBlock:(ButtonBlock)block{
    _sinaBtnBlock = block;
}
- (IBAction)didClickOnButton1:(id)sender{
    switch (((UIButton*)sender).tag) {
        case 1:{
            _button1Block(sender);
            //            LoginViewController *loginController = [[LoginViewController alloc] initWithNibName:@"LoginViewController" bundle:nil];
            //            [AppDelegate getInstance].LoginNavController = [[UINavigationController alloc] initWithNibName:nil bundle:nil];
            //            [[AppDelegate getInstance].LoginNavController.navigationBar setBackgroundColor:[UIColor clearColor]];
            //            [[AppDelegate getInstance].LoginNavController.navigationBar setBackgroundImage:[UIImage imageNamed:@"NavigationBarBg"] forBarMetrics:UIBarMetricsDefault];
            //            [[AppDelegate getInstance].LoginNavController initWithRootViewController:loginController];
            //            [self presentModalViewController:[AppDelegate getInstance].LoginNavController animated:YES];
        }
            break;
            
        case 2:
        {
            _button2Block(sender);
            //            RegisterViewController *registerController = [[RegisterViewController alloc] initWithNibName:nil bundle:nil];
            //            [AppDelegate getInstance].RegisterNavController = [[UINavigationController alloc] initWithNibName:nil bundle:nil];
            //            [[AppDelegate getInstance].RegisterNavController.navigationBar setBackgroundColor:[UIColor clearColor]];
            //            [[AppDelegate getInstance].RegisterNavController.navigationBar setBackgroundImage:[UIImage imageNamed:@"NavigationBarBg"] forBarMetrics:UIBarMetricsDefault];
            //            [[AppDelegate getInstance].RegisterNavController initWithRootViewController:registerController];
            //            [self presentModalViewController:[AppDelegate getInstance].RegisterNavController animated:YES];
        }
            break;
            
        case 3:
        {
            //            RegisterViewController *registerController = [[RegisterViewController alloc] initWithNibName:nil bundle:nil];
            //            [AppDelegate getInstance].RegisterNavController = [[UINavigationController alloc] initWithNibName:nil bundle:nil];
            //            [[AppDelegate getInstance].RegisterNavController.navigationBar setBackgroundColor:[UIColor clearColor]];
            //            [[AppDelegate getInstance].RegisterNavController.navigationBar setBackgroundImage:[UIImage imageNamed:@"NavigationBarBg"] forBarMetrics:UIBarMetricsDefault];
            //            [[AppDelegate getInstance].RegisterNavController initWithRootViewController:registerController];
            //            [self presentModalViewController:[AppDelegate getInstance].RegisterNavController animated:YES];
        }
            break;
            
        case 4:
        {
            //            RegisterViewController *registerController = [[RegisterViewController alloc] initWithNibName:nil bundle:nil];
            //            [AppDelegate getInstance].RegisterNavController = [[UINavigationController alloc] initWithNibName:nil bundle:nil];
            //            [[AppDelegate getInstance].RegisterNavController.navigationBar setBackgroundColor:[UIColor clearColor]];
            //            [[AppDelegate getInstance].RegisterNavController.navigationBar setBackgroundImage:[UIImage imageNamed:@"NavigationBarBg"] forBarMetrics:UIBarMetricsDefault];
            //            [[AppDelegate getInstance].RegisterNavController initWithRootViewController:registerController];
            //            [self presentModalViewController:[AppDelegate getInstance].RegisterNavController animated:YES];
        }
            break;
            
        default:
            break;
    }
}
- (IBAction)didClickOnPageControl:(UIPageControl *)sender {
    _currentState = ScrollingStateManual;
    // 滚动视图动画。
    [_scrollView setContentOffset:CGPointMake(sender.currentPage * _windowSize.width,0)
                         animated:YES];
    // Set the PageControl on the right page.
    [_pageControl setCurrentPage:sender.currentPage];
}

- (void)setSubTitleStyleArray:(NSArray *)array{
    if (_subTitleStyleArray!=nil)
        _subTitleStyleArray = nil;
    _subTitleStyleArray = [NSMutableArray arrayWithArray:array];
}

- (void)setDescStyleArray:(NSArray *)array{
    if (_descTitleStyleArray!=nil)
        _descTitleStyleArray = nil;
    _descTitleStyleArray = [NSMutableArray arrayWithArray:array];
}

#pragma mark - 3Party新浪
-(void)webSinaAuthClick{
//    SinaAuthWebView *webview = [[SinaAuthWebView alloc] initWithNibName:@"SinaAuthWebView" bundle:nil RootNavController:nil];
//    UINavigationController *controller = [[UINavigationController alloc] initWithRootViewController:webview];
//    [self presentViewController:controller animated:YES completion:^{
//        
//    }];
}
-(void)DidSinaAuthResult:(BOOL)result info:(NSDictionary *)info{
    if (result) {
        [Gobal saveAppSetting:@"2" Key:baseKey_loginMethod];    //1:phone ; 2:sina ; 3:qq
//        NSString *type = @"2";
//        NSString *accountid = [info objectForKey:@"sina_uid"];
//        NSString *devicetype = [Gobal getModel];
//        NSString *deviceid = @"";
//        [[AppDelegate getInstance] showProgressHUDWithMessage:@"登录中..."];
        
//        NSMutableDictionary     *postparams = [NSMutableDictionary dictionaryWithObjectsAndKeys:
//                                               HuaWeiToken,   @"access_token",
//                                               SINA_APP_KEY, @"source",
//                                               type,@"type",
//                                               accountid,@"accountid",
//                                               //                                           latitude,@"latitude",
//                                               //                                           longitude,@"longitude",
//                                               devicetype,@"devicetype",
//                                               deviceid,@"deviceid",
//                                               nil];
//        
//        [[DLRequestManager getInstance] getD3UserAutoLogin:postparams delegate:self];
    }
    else{
//        [[AppDelegate getInstance] showProgressHUDCompleteMessage:@"授权失败"];
    }
}
/**
 * sinaOAuth
 */
- (void)ssoButtonPressed
{
//    WBAuthorizeRequest *request = [WBAuthorizeRequest request];
//    request.redirectURI = kSinaRedirectURI;
//    request.scope = @"all";
//    request.userInfo = @{@"SSO_From": @"MSIntroductionController",
//                         @"Other_Info_1": [NSNumber numberWithInt:123],
//                         @"Other_Info_2": @[@"obj1", @"obj2"],
//                         @"Other_Info_3": @{@"key1": @"obj1", @"key2": @"obj2"}};
//    [WeiboSDK sendRequest:request];
}

-(void)webQQAuthClick{
    //    OAuthWebView *webview = [[OAuthWebView alloc] initWithNibName:@"OAuthWebView" bundle:nil RootNavController:nil];
    //    UINavigationController *controller = [[UINavigationController alloc] initWithRootViewController:webview];
    //    [self presentViewController:controller animated:YES completion:^{
    //
    //    }];
}

/**
 * tencentOAuth
 */
- (void)onClickTencentOAuth {
    if ([[UIApplication sharedApplication] canOpenURL:[NSURL URLWithString:@"mqq://"]]) {
        //installed
//        [_tencentOAuth authorize:_permissions inSafari:NO];
    }else{
        //no install
        //reference http://wiki.open.qq.com/wiki/%E3%80%90QQ%E7%99%BB%E5%BD%95%E3%80%91%E4%BD%BF%E7%94%A8Implicit_Grant%E6%96%B9%E5%BC%8F%E8%8E%B7%E5%8F%96Access_Token
        //reference http://wiki.open.qq.com/wiki/%E3%80%90QQ%E7%99%BB%E5%BD%95%E3%80%91%E5%BC%80%E5%8F%91%E6%94%BB%E7%95%A5_Client-side
        NSLog(@"no---");
        //        OAuthWebView *loginController = [[OAuthWebView alloc] initWithNibName:@"OAuthWebView" bundle:nil];
        //        UINavigationController *navigationController = [[UINavigationController alloc] initWithNibName:nil bundle:nil];
        //        [navigationController.navigationBar setBackgroundColor:[UIColor clearColor]];
        //        [navigationController.navigationBar setBackgroundImage:[UIImage imageNamed:@"NavigationBarBg"] forBarMetrics:UIBarMetricsDefault];
        //        [navigationController initWithRootViewController:loginController];
        //        [self presentModalViewController:navigationController animated:YES];
    }
    //    [_tencentOAuth authorize:_permissions inSafari:NO];
}

/**
 * Called when the user successfully logged in.
 */
- (void)tencentDidLogin {
    [Gobal saveAppSetting:@"3" Key:baseKey_loginMethod];    //1:phone ; 2:sina ; 3:qq
//    
//    NSString *type = @"1";
//    NSString *accountid = _tencentOAuth.openId;
//    NSString *devicetype = [Gobal getModel];
//    NSString *deviceid = @"";
//    
//    [[AppDelegate getInstance] showProgressHUDWithMessage:@"登录中..."];
//    
//    NSMutableDictionary     *postparams = [NSMutableDictionary dictionaryWithObjectsAndKeys:
//                                           HuaWeiToken,   @"access_token",
//                                           SINA_APP_KEY, @"source",
//                                           type,@"type",
//                                           accountid,@"accountid",
//                                           //                                           latitude,@"latitude",
//                                           //                                           longitude,@"longitude",
//                                           devicetype,@"devicetype",
//                                           deviceid,@"deviceid",
//                                           nil];
//    
//    [[DLRequestManager getInstance] getD3UserAutoLogin:postparams delegate:self];
}

/**
 * tencentOAuthBySafari
 */
- (void)onClickTencentOAuthBySafari {
    //    _labelTitle.text = @"开始获取token";
    //    [_tencentOAuth authorize:_permissions inSafari:YES];
}

/**
 * Get user info.
 */
- (void)onClickGetUserInfo {
    //    _labelTitle.text = @"开始获取用户基本信息";
    //    if(![_tencentOAuth getUserInfo]){
    //        [self showInvalidTokenOrOpenIDMessage];
    //    }
}

- (void)showInvalidTokenOrOpenIDMessage{
    //    UIAlertView *alert = [[[UIAlertView alloc]initWithTitle:@"api调用失败" message:@"可能授权已过期，请重新获取" delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil, nil] autorelease];
    //    [alert show];
}

#pragma mark - Network Request
- (void)sinaLogin:(NSNotification *)notice{
//    [Gobal saveAppSetting:@"2" Key:baseKey_loginMethod];    //1:phone ; 2:sina ; 3:qq
//    WBBaseResponse *userinfo = [[notice userInfo] objectForKey:@"userinfo"];
//    
//    NSString *type = @"2";
//    NSString *accountid = [(WBAuthorizeResponse *)userinfo userID];
//    NSString *devicetype = [Gobal getModel];
//    NSString *deviceid = @"";
//    
//    [[AppDelegate getInstance] showProgressHUDWithMessage:@"登录中..."];
//    
//    NSMutableDictionary     *postparams = [NSMutableDictionary dictionaryWithObjectsAndKeys:
//                                           HuaWeiToken,   @"access_token",
//                                           SINA_APP_KEY, @"source",
//                                           type,@"type",
//                                           accountid,@"accountid",
//                                           //                                           latitude,@"latitude",
//                                           //                                           longitude,@"longitude",
//                                           devicetype,@"devicetype",
//                                           deviceid,@"deviceid",
//                                           nil];
//    
//    [[DLRequestManager getInstance] getD3UserAutoLogin:postparams delegate:self];
}

#pragma mark - Request Response
-(void)didGetResponse:(NSString *)datastring type:(int)request{
//    if (request==D3UserAutoLogin){
//        //        [[AppDelegate getInstance] loginSuccess];
//        //        return;
//        [[AppDelegate getInstance] hideProgressHUD:YES];
//        NSLog(@"D3UserAutoLogin is <%@>",datastring);
//        if (datastring.length>0){
//            NSDictionary *response = [datastring objectFromJSONString];
//            NSString *result = [response objectForKey:@"return"];
//            if ([result isEqualToString:@"SUCCESS"]) {
//                [[AppDelegate getInstance] showProgressHUDCompleteMessage:@"成功登录"];
//                HWUser *userProfile = [HWUser dataWithJsonDictionary:response];
//                if ([userProfile.username isEqual:[NSNull null]])
//                    [Gobal saveAppSetting:@"" Key:baseKey_userIDname];
//                else
//                    [Gobal saveAppSetting:userProfile.username Key:baseKey_userIDname];
//                if ([userProfile.nickname isEqual:[NSNull null]])
//                    [Gobal saveAppSetting:@"" Key:baseKey_nickname];
//                else
//                    [Gobal saveAppSetting:userProfile.nickname Key:baseKey_nickname];
//                //                if ([userProfile.city isEqual:[NSNull null]])
//                //                    [Gobal saveAppSetting:@"" Key:baseKey_city];
//                //                else
//                //                    [Gobal saveAppSetting:userProfile.city Key:baseKey_city];
//                if ([userProfile.email isEqual:[NSNull null]])
//                    [Gobal saveAppSetting:@"" Key:baseKey_email];
//                else
//                    [Gobal saveAppSetting:userProfile.email Key:baseKey_email];
//                if ([userProfile.mobile isEqual:[NSNull null]])
//                    [Gobal saveAppSetting:@"" Key:baseKey_mobile];
//                else
//                    [Gobal saveAppSetting:userProfile.mobile Key:baseKey_mobile];
//                [Gobal saveAppSetting:userProfile.uid Key:baseKey_Myuid];
//                [Gobal saveAppSetting:userProfile.password Key:baseKey_password];
//                if ([userProfile.job_position isEqual:[NSNull null]])
//                    [Gobal saveAppSetting:@"" Key:baseKey_job_position];
//                else
//                    [Gobal saveAppSetting:userProfile.job_position Key:baseKey_job_position];
//                if ([userProfile.interest_fields isEqual:[NSNull null]])
//                    [Gobal saveAppSetting:@"" Key:baseKey_interest_fields];
//                else
//                    [Gobal saveAppSetting:userProfile.interest_fields Key:baseKey_interest_fields];
//                if ([userProfile.sns_account isEqual:[NSNull null]])
//                    [Gobal saveAppSetting:@"" Key:baseKey_sns_account];
//                else
//                    [Gobal saveAppSetting:userProfile.sns_account Key:baseKey_sns_account];
//                if ([userProfile.sns_token isEqual:[NSNull null]])
//                    [Gobal saveAppSetting:@"" Key:baseKey_sns_token];
//                else
//                    [Gobal saveAppSetting:userProfile.sns_token Key:baseKey_sns_token];
//                if ([userProfile.sns_expire_date isEqual:[NSNull null]])
//                    [Gobal saveAppSetting:@"" Key:baseKey_sns_exptime];
//                else
//                    [Gobal saveAppSetting:userProfile.sns_expire_date Key:baseKey_sns_exptime];
//                if ([userProfile.avatar isEqual:[NSNull null]])
//                    [Gobal saveAppSetting:@"" Key:baseKey_avatarURL];
//                else
//                    [Gobal saveAppSetting:userProfile.avatar Key:baseKey_avatarURL];
//                if ([userProfile.rebate isEqual:[NSNull null]])
//                    [Gobal saveAppSetting:@"" Key:baseKey_Rebate];
//                else
//                    [Gobal saveAppSetting:userProfile.rebate Key:baseKey_Rebate];
//                if ([userProfile.signature isEqual:[NSNull null]])
//                    [Gobal saveAppSetting:@"" Key:baseKey_signature];
//                else
//                    [Gobal saveAppSetting:userProfile.signature Key:baseKey_signature];
//                if ([userProfile.bb_birthday isEqual:[NSNull null]])
//                    [Gobal cachePersonalData:@"" Key:baseKey_bb_birthday];
//                else
//                    [Gobal cachePersonalData:userProfile.bb_birthday Key:baseKey_bb_birthday];
//                
//                [UIView animateWithDuration:1.0f animations:^{
//                    [self.view setAlpha:0.0f];
//                } completion:^(BOOL finished) {
//                    [self dismissModalViewControllerAnimated:YES];
//                    if (![[Gobal loadPersonalDataFromCache:baseKey_bb_birthday] isEqual:[NSNull null]] && [Gobal loadPersonalDataFromCache:baseKey_bb_birthday] != nil) {
//                        NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
//                        [dateFormatter setDateFormat:@"yyyy-MM-dd"];
//                        NSDate *Date = [dateFormatter dateFromString:[Gobal loadPersonalDataFromCache:baseKey_bb_birthday]];
//                        if (!Date) {
//                            [NSTimer scheduledTimerWithTimeInterval:1 target:[AppDelegate getInstance] selector:@selector(userInitData) userInfo:nil repeats:NO];
//                        }
//                    }
//                    else{
//                        [NSTimer scheduledTimerWithTimeInterval:1 target:[AppDelegate getInstance] selector:@selector(userInitData) userInfo:nil repeats:NO];
//                    }
//                }];
//                
//                
//                [[NSNotificationCenter defaultCenter] postNotificationName:Notification_updateUserInfo object:nil];
//            }
//            else{
//                [Gobal showAlert:nil Content:[response objectForKey:@"reason"]];
//            }
//        }
//    }
}

#pragma mark - Pages
// Set the list of pages (MSIntroductionPage)
- (void)setPages:(NSArray *)pages{
    _pages = pages;
}

- (NSUInteger)numberOfPages{
    if (_pages)
        return [_pages count];
    
    return 0;
}

#pragma mark - Animations
- (void)animateScrolling{
    if (_currentState & ScrollingStateManual)
        return;
    
    // Jump to the next page...
    int nextPage = (int)_currentPageIndex + 1;
    if (nextPage == [self numberOfPages]){
        // ...stop the auto-scrolling or...
        if (!_autoScrollLooping){
            _currentState = ScrollingStateManual;
            return;
        }
        // ...jump to the first page.
        nextPage = 0;
        _currentState = ScrollingStateLooping;
        
        // Set alpha on layers.
        [self setLayersPrimaryAlphaWithPageIndex:0];
        [self setBackLayerPictureWithPageIndex:-1];
    } else {
        _currentState = ScrollingStateAuto;
    }
    
    // Make the scrollView animation.
    [_scrollView setContentOffset:CGPointMake(nextPage * _windowSize.width,0)
                         animated:YES];
    
    // Set the PageControl on the right page.
    [_pageControl setCurrentPage:nextPage];
    
    // Call the next animation after X seconds.
    [self autoScrollToNextPage];
}

// Call the next animation after X seconds.
- (void)autoScrollToNextPage{
    if (_autoScrollEnabled)
        [self performSelector:@selector(animateScrolling)
                   withObject:nil
                   afterDelay:_autoScrollDurationOnPage];
}

#pragma mark - Scrolling management
// Run it.
- (void)startScrolling{
    [self autoScrollToNextPage];
}

// Manually stop the scrolling
- (void)stopScrolling{
    _currentState = ScrollingStateManual;
}

#pragma mark - State management
// State.
- (ScrollingState)getCurrentState{
    return _currentState;
}

#pragma mark - Overlay management
// Setup the Title Label.
- (void)setOverlayTitle{
    // ...or change by an UIImageView if you need it.
    //    [_overlayTitle setText:@"Welcome"];
}

// Setup the SubTitle/Description style/text.
- (void)setOverlayTexts{
    int index = 0;
    for(MSIntroductionPage *page in _pages){
        // SubTitles.
        if ([[[page subTitle] text] length]){
            UILabel *subTitle = [self overlayLabelWithText:[[page subTitle] text]
                                                     layer:[page subTitle]
                                               commonStyle:[_subTitleStyleArray objectAtIndex:index]
                                                     index:index];
            [_scrollView addSubview:subTitle];
        }
        // Description.
        if ([[[page description] text] length]){
            UILabel *description = [self overlayLabelWithText:[[page description] text]
                                                        layer:[page description]
                                                  commonStyle:[_descTitleStyleArray objectAtIndex:index]
                                                        index:index];
            [_scrollView addSubview:description];
        }
        
        index++;
    }
}

- (UILabel *)overlayLabelWithText:(NSString *)text
                            layer:(MSIntroductionLabelStyle *)style
                      commonStyle:(MSIntroductionLabelStyle *)commonStyle
                            index:(NSUInteger)index{
    // SubTitles.
    UILabel *overlayLabel = [[UILabel alloc] initWithFrame:CGRectMake((index  * _windowSize.width),
                                                                      _windowSize.height - [commonStyle offset] -20,
                                                                      _windowSize.width,
                                                                      TUTORIAL_LABEL_HEIGHT*commonStyle.linesNumber)];
    if ([[[UIDevice currentDevice] systemVersion] floatValue] >= 6.0)
        [overlayLabel setTranslatesAutoresizingMaskIntoConstraints:NO];
    [overlayLabel setNumberOfLines:[commonStyle linesNumber]];
    [overlayLabel setBackgroundColor:[UIColor clearColor]];
    [overlayLabel setTextAlignment:NSTextAlignmentCenter];
    
    // Datas and style.
    [overlayLabel setText:text];
    [style font] ? [overlayLabel setFont:[style font]] :
    [overlayLabel setFont:[commonStyle font]];
    if ([style textColor])
        [overlayLabel setTextColor:[style textColor]];
    else
        [overlayLabel setTextColor:[commonStyle textColor]];
    
    [_scrollView addSubview:overlayLabel];
    return overlayLabel;
}

#pragma mark - Layers management
// Handle the background layer image switch.
- (void)setBackLayerPictureWithPageIndex:(NSInteger)index{
    [self setBackgroundImage:_backLayerView withIndex:index + 1];
}

// Handle the front layer image switch.
- (void)setFrontLayerPictureWithPageIndex:(NSInteger)index{
    [self setBackgroundImage:_frontLayerView withIndex:index];
}

// Handle page image's loading
- (void)setBackgroundImage:(UIImageView *)imageView withIndex:(NSInteger)index{
    if (index >= [_pages count]){
        [imageView setImage:nil];
        return;
    }
    
    NSString *imageName = [NSString stringWithFormat:@"%@",[[_pages objectAtIndex:index] pictureName]];
    [imageView setImage:[UIImage imageNamed:imageName]];
}

// Setup layer's alpha.
- (void)setLayersPrimaryAlphaWithPageIndex:(NSInteger)index{
    [_frontLayerView setAlpha:1];
    [_backLayerView setAlpha:0];
}

// Preset the origin state.
- (void)setOriginLayersState{
    _currentState = ScrollingStateAuto;
    [_backLayerView setBackgroundColor:[UIColor blackColor]];
    [_frontLayerView setBackgroundColor:[UIColor blackColor]];
    [self setLayersPicturesWithIndex:0];
}

// Setup the layers with the page index.
- (void)setLayersPicturesWithIndex:(NSInteger)index{
    _currentPageIndex = index;
    [self setLayersPrimaryAlphaWithPageIndex:index];
    [self setFrontLayerPictureWithPageIndex:index];
    [self setBackLayerPictureWithPageIndex:index];
}

// Animate the fade-in/out (Cross-disolve) with the scrollView translation.
- (void)disolveBackgroundWithContentOffset:(float)offset{
    if (_currentState & ScrollingStateLooping){
        // Jump from the last page to the first.
        [self scrollingToFirstPageWithOffset:offset];
    } else {
        // Or just scroll to the next/previous page.
        [self scrollingToNextPageWithOffset:offset];
    }
}

// Handle alpha on layers when the auto-scrolling is looping to the first page.
- (void)scrollingToFirstPageWithOffset:(float)offset{
    // Compute the scrolling percentage on all the page.
    offset = (offset * _windowSize.width) / (_windowSize.width * [self numberOfPages]);
    
    // Scrolling finished...
    if (offset == 0){
        // ...reset to the origin state.
        [self setOriginLayersState];
        return;
    }
    
    // Invert alpha for the back picture.
    float backLayerAlpha = (1 - offset);
    float frontLayerAlpha = offset;
    
    // Set alpha.
    [_backLayerView setAlpha:backLayerAlpha];
    [_frontLayerView setAlpha:frontLayerAlpha];
}

// Handle alpha on layers when we are scrolling to the next/previous page.
- (void)scrollingToNextPageWithOffset:(float)offset{
    // Current page index in scrolling.
    NSInteger page = (int)(offset);
    
    // Keep only the float value.
    float alphaValue = offset - (int)offset;
    
    // This is only when you scroll to the right on the first page.
    // That will fade-in black the first picture.
    if (alphaValue < 0 && _currentPageIndex == 0){
        [_backLayerView setImage:nil];
        [_frontLayerView setAlpha:(1 + alphaValue)];
        return;
    }
    
    // Switch pictures, and imageView alpha.
    if (page != _currentPageIndex)
        [self setLayersPicturesWithIndex:page];
    
    // Invert alpha for the front picture.
    float backLayerAlpha = alphaValue;
    float frontLayerAlpha = (1 - alphaValue);
    
    // Set alpha.
    [_backLayerView setAlpha:backLayerAlpha];
    [_frontLayerView setAlpha:frontLayerAlpha];
}

#pragma mark - ScrollView delegate
- (void)scrollViewDidScroll:(UIScrollView *)scrollView{
    // Get scrolling position, and send the alpha values.
    float scrollingPosition = scrollView.contentOffset.x / _windowSize.width;
    //method 1:(fade animation)
    //    [self disolveBackgroundWithContentOffset:scrollingPosition];
    //
    ////    if (_currentPageIndex+1 > [self numberOfPages]) {
    ////        self.view.alpha = ((_scrollView.frame.size.width*(float)[self numberOfPages])-_scrollView.contentOffset.x)/_scrollView.frame.size.width;
    ////    }
    //method 2:slide
    _currentPageIndex = (int)scrollingPosition;
    [_pageControl setCurrentPage:_currentPageIndex];
    
    if (_scrollView.isTracking)
        _currentState = ScrollingStateManual;
}

- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView{
    // Update the page index.
    [_pageControl setCurrentPage:_currentPageIndex];
    if (_currentPageIndex+1 > [self numberOfPages]){
        dispatch_async(dispatch_get_main_queue(), ^{
            [UIView animateWithDuration:0.5 animations:^{
                [AppDelegate getInstance].window.alpha = 0;
            } completion:^(BOOL finished) {
                [self viewsDisappear];
                dispatch_async(dispatch_get_main_queue(), ^{
                    [UIView animateWithDuration:0.5 animations:^{
                        [AppDelegate getInstance].window.alpha = 1;
                    }];
                });
            }];
        });
    }
}

- (void)show
{
    UIWindow *window = [UIApplication sharedApplication].keyWindow;
    [window addSubview:self.view];
    [window.rootViewController addChildViewController:self];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}
@end
