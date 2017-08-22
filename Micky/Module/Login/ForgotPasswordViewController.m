//
//  ForgotPasswordViewController.m
//  MickyEasyCredit
//
//  Created by 张宁 on 2016/11/9.
//  Copyright © 2016年 apple. All rights reserved.
//

#import "ForgotPasswordViewController.h"
#import "AppDelegate.h"
#import "AFNetworking.h"
#import "SystemUtil.h"

#import "MZTimerLabel.h"
#import "RetrievePasswordViewController.h"


@interface ForgotPasswordViewController ()<UITextFieldDelegate,MZTimerLabelDelegate>
{
    UITapGestureRecognizer *tapGestureRecognizer;
    MZTimerLabel *_timerLabel;
    NSString *lost_code_string;
    UILabel *titleLabel;
}
@end

@implementation ForgotPasswordViewController
@synthesize ver_view;
@synthesize email_view;
@synthesize email_field;
@synthesize sumbit_Btn;
@synthesize getCodeBtn;
@synthesize verificationCode_Field;

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    self.navigationController.navigationBar.translucent = NO;
    [self.navigationController.navigationBar setBackgroundImage:[Gobal imageWithColor:BUTTON_COLOR_NORMA size:CGSizeMake(50, 50)] forBarMetrics:UIBarMetricsDefault];
    [[UIApplication sharedApplication] setStatusBarStyle:UIStatusBarStyleLightContent];
    self.navigationController.navigationBar.shadowImage = [[UIImage alloc] init];
}
- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = BACKGROUND_COLOR;
    self.navigationController.navigationBar.hidden = NO;
    [[UIApplication sharedApplication] setStatusBarStyle:UIStatusBarStyleLightContent];
       
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
    titleLabel.text = @"忘记密码";
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
#pragma mark -- init/layout
-(void)initLayout {

    UIView *line_1 = [Gobal drawSolidLinePointX:0 PointY:39 lineW:SCREEN_WIDTH-40 lineH:1 lineColor:@[@"50",@"50",@"50"] lineAlpha:1.0];
    [email_view addSubview:line_1];
    
    UIView *line_2 = [Gobal drawSolidLinePointX:0 PointY:39 lineW:SCREEN_WIDTH-40 lineH:1 lineColor:@[@"50",@"50",@"50"] lineAlpha:1.0];
    [ver_view addSubview:line_2];
    
    email_field.delegate = self;
    email_field.clearButtonMode = UITextFieldViewModeAlways;
    
    verificationCode_Field.delegate = self;
    verificationCode_Field.keyboardType = UIKeyboardTypeNumberPad;
    verificationCode_Field.clearButtonMode = UITextFieldViewModeAlways;

    getCodeBtn.layer.cornerRadius = 5;
    getCodeBtn.layer.masksToBounds = YES;
    
    sumbit_Btn.layer.cornerRadius = 40/2.0;
    sumbit_Btn.layer.masksToBounds = YES;
    sumbit_Btn.backgroundColor = [UIColor clearColor];
    [sumbit_Btn setBackgroundImage:[Gobal imageWithColor:BUTTON_COLOR_NORMA size:sumbit_Btn.frame.size]  forState:UIControlStateNormal];
    [sumbit_Btn setBackgroundImage:[Gobal imageWithColor:BUTTON_COLOR_HIGHT size:sumbit_Btn.frame.size]  forState:UIControlStateHighlighted];
    
    tapGestureRecognizer = [[UITapGestureRecognizer alloc]init];
    [tapGestureRecognizer addTarget:self action:@selector(keyboardRecyclingAction)];
    [self.view addGestureRecognizer:tapGestureRecognizer];
    
}
#pragma mark - 倒计时
- (void)setTimer{
    
    if (_timerLabel != nil) {
        _timerLabel = nil;
    }
    [getCodeBtn setTitle:@"" forState:UIControlStateNormal];
    _timerLabel = [[MZTimerLabel alloc] initWithLabel:_timerLabel andTimerType:MZTimerLabelTypeTimer];
    [_timerLabel setBackgroundColor:[UIColor clearColor]];
    _timerLabel.timeFormat = @"(ss)重新获取";
    
    _timerLabel.timeLabel.font = [UIFont systemFontOfSize:11];
    _timerLabel.timeLabel.textAlignment = NSTextAlignmentCenter;
    _timerLabel.timeLabel.textColor = [UIColor whiteColor];
    [_timerLabel setCountDownTime:60];
    _timerLabel.delegate = self;
    [_timerLabel start];
    [_timerLabel setFrame:CGRectMake(0, 0, getCodeBtn.frame.size.width, getCodeBtn.frame.size.height)];
    getCodeBtn.backgroundColor = BUTTON_COLOR_NORMA;
    [getCodeBtn addSubview:_timerLabel];
    getCodeBtn.enabled = NO;
    
}
#pragma mark - MZTimerLabel delegate
- (void)timerLabel:(MZTimerLabel*)timerLabel finshedCountDownTimerWithTime:(NSTimeInterval)countTime{
    
    [_timerLabel setHidden:YES];
    getCodeBtn.backgroundColor = [UIColor colorWithRed:105/255.0f green:124/255.0f blue:214/255.0f alpha:1.0f];
    [getCodeBtn setTitle:@"重新获取" forState:UIControlStateNormal];
    [getCodeBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    getCodeBtn.enabled = YES;
}
#pragma mark - Delegate
#pragma mark -- delegate/键盘回收
- (void)keyboardRecyclingAction {
    [email_field resignFirstResponder];
}
#pragma mark -- delegate/textfield
- (BOOL)textFieldShouldReturn:(UITextField *)textField {
    [email_field resignFirstResponder];
    return YES;
}
- (void)textFieldDidEndEditing:(UITextField *)textField {
    [email_field resignFirstResponder];
}
#pragma mark - Event
#pragma mark -- Event/提交
- (IBAction)sumbitBtnAction:(UIButton *)sender {
    [email_field resignFirstResponder];
    
//    [self sendCodeSubmitDataRequest];
    
    
    RetrievePasswordViewController *RPVC = [[RetrievePasswordViewController alloc]init];
    RPVC.email_string = email_field.text;
    [[AppDelegate getInstance].CurNavController pushViewController:RPVC animated:YES];

    
}
#pragma mark -- Event/获取验证码
- (IBAction)getCodeButtonAction:(UIButton *)sender {
    
    [self sendVerificationCodeDataRequest];
}
#pragma mark - Data
#pragma mark -- Data/发送验证码
- (void)sendVerificationCodeDataRequest {
    
    if ([Gobal isEmptyString:email_field.text]) {
        [CustomHUD createShowContent:@"请输入您的手机号" hiddenTime:2.4];
        return;
    }
    if ([email_field.text length]>11) {
        [CustomHUD createShowContent:@"请输入正确的手机号" hiddenTime:2.4];
        return;
    }
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    manager.responseSerializer.acceptableContentTypes = [NSSet setWithObject:@"text/plain"];
    NSDictionary *parameters = @{
                                 @"phone"    : email_field.text,
                                 };
    [manager POST:PUBLIC_URL(SENDLOSTCODE) parameters:parameters success:^(AFHTTPRequestOperation *operation,id responseObject) {
        NSLog(@"sendCode_success: %@", responseObject);
        
        if ([responseObject[@"status"] isEqualToString:@"100"]) {
            
            [self setTimer];
            lost_code_string = responseObject[@"code"];
            
        }else {
            [CustomHUD createShowContent:responseObject[@"message"] hiddenTime:2.4];
        }
        
    }failure:^(AFHTTPRequestOperation *operation,NSError *error) {
        [CustomHUD createShowContent:@"网络链接失败,请检查是否链接网络" hiddenTime:2.4];
    }];
}
#pragma mark -- Data/提交
- (void)sendCodeSubmitDataRequest {

    if ([Gobal isEmptyString:email_field.text]) {
        [CustomHUD createShowContent:@"请输入您的手机号" hiddenTime:2.4];
        return;
    }
    if ([email_field.text length]>11) {
        [CustomHUD createShowContent:@"请输入正确的手机号" hiddenTime:2.4];
        return;
    }
    if ([Gobal isEmptyString:verificationCode_Field.text]) {
        [CustomHUD createShowContent:@"请输入您的验证码" hiddenTime:2.4];
        return;
    }
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    manager.responseSerializer.acceptableContentTypes = [NSSet setWithObject:@"text/plain"];
    NSDictionary *parameters = @{
                                 @"phone"    : email_field.text,
                                 @"code"     : verificationCode_Field.text,
                                 };
    [manager POST:PUBLIC_URL(SENDCODESUBMIT) parameters:parameters success:^(AFHTTPRequestOperation *operation,id responseObject) {
        NSLog(@"sendCode_success: %@", responseObject);
        
        if ([responseObject[@"status"] isEqualToString:@"100"]) {
            
            RetrievePasswordViewController *RPVC = [[RetrievePasswordViewController alloc]init];
            RPVC.email_string = email_field.text;
            [[AppDelegate getInstance].CurNavController pushViewController:RPVC animated:YES];

        }else {
            [CustomHUD createShowContent:responseObject[@"message"] hiddenTime:2.4];
        }
        
    }failure:^(AFHTTPRequestOperation *operation,NSError *error) {
        [CustomHUD createShowContent:@"网络链接失败,请检查是否链接网络" hiddenTime:2.4];
    }];
}

#pragma mark -- Event/返回
-(void)popBack {
    [[AppDelegate getInstance].mainTabController hideTabbarView];
    [[AppDelegate getInstance].CurNavController popViewControllerAnimated:YES];
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

@end
