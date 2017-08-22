//
//  LoginViewController.m
//  MickyEasyCredit
//
//  Created by 张宁 on 2016/11/7.
//  Copyright © 2016年 apple. All rights reserved.
//

#import "LoginViewController.h"
#import "AppDelegate.h"
#import "AFNetworking.h"
#import "SystemUtil.h"
#import "APINetworkConfig.h"
#import "SDiOSVersion.h"

#import "RegisteredViewController.h"
#import "ForgotPasswordViewController.h"


@interface LoginViewController ()<UITextFieldDelegate>
{
    UITapGestureRecognizer *tapGestureRecognizer;
    UILabel *titleLabel;
    UIButton *right_Button;
    NSString *password_token;
}
@end

@implementation LoginViewController
@synthesize  email_view;
@synthesize  password_view;
@synthesize  email_field;
@synthesize  password_field;
@synthesize  look_passwprd_Btn;
@synthesize  login_Btn;
@synthesize  forgotPassword_Btn;
@synthesize  register_Btn;

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    self.navigationController.navigationBar.hidden = YES;
    [[UIApplication sharedApplication] setStatusBarStyle:UIStatusBarStyleDefault];

}
- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = BACKGROUND_COLOR;
    self.navigationController.navigationBar.hidden = YES;
    [[UIApplication sharedApplication] setStatusBarStyle:UIStatusBarStyleDefault];

    [self initData];
    [self initLayout];
}
#pragma mark - init
#pragma mark -- init/Data
- (void)initData {
//    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
//    button.frame = CGRectMake(15, 12, 55, 44);
//    button.backgroundColor = [UIColor clearColor];
//    [button setImage:[UIImage imageNamed:@"navbar_back_ gray"] forState:UIControlStateNormal];
//    [button setImageEdgeInsets:UIEdgeInsetsMake(0, -40, 0, 0)];
//    [button addTarget:self action:@selector(popBack) forControlEvents:UIControlEventTouchUpInside];
//    [self.view addSubview:button];
}
#pragma mark -- init/layout
- (void)initLayout {
    
    UIView *line_1 = [Gobal drawSolidLinePointX:0 PointY:39 lineW:SCREEN_WIDTH-40 lineH:1.0 lineColor:@[@"50",@"50",@"50"] lineAlpha:1.0];
    [email_view addSubview:line_1];
    
    UIView *line_2 = [Gobal drawSolidLinePointX:0 PointY:39 lineW:SCREEN_WIDTH-40 lineH:1.0 lineColor:@[@"50",@"50",@"50"] lineAlpha:1.0];
    [password_view addSubview:line_2];

    email_field.placeholder = @"请输入您的手机号";
    email_field.delegate = self;
    email_field.keyboardType = UIKeyboardTypeNumberPad;
    email_field.clearButtonMode = UITextFieldViewModeAlways;
    
    password_field.placeholder = @"请输入密码";
    password_field.delegate = self;
    password_field.secureTextEntry = YES;
    password_field.clearButtonMode = UITextFieldViewModeAlways;

    [look_passwprd_Btn setImage:[UIImage imageNamed:@"my_eye_no"] forState:UIControlStateNormal];
    [look_passwprd_Btn setImage:[UIImage imageNamed:@"my_eye"] forState:UIControlStateSelected];
    
    login_Btn.layer.cornerRadius = 40/2.0;
    login_Btn.layer.masksToBounds = YES;
    [login_Btn setTitle:@"登录" forState:UIControlStateNormal];
    login_Btn.backgroundColor = [UIColor clearColor];
    [login_Btn setBackgroundImage:[Gobal imageWithColor:BUTTON_COLOR_NORMA size:login_Btn.frame.size]  forState:UIControlStateNormal];
    [login_Btn setBackgroundImage:[Gobal imageWithColor:BUTTON_COLOR_HIGHT size:login_Btn.frame.size]  forState:UIControlStateHighlighted];
   
    [forgotPassword_Btn setTitle:@"忘记密码?" forState:UIControlStateNormal];
    
    tapGestureRecognizer = [[UITapGestureRecognizer alloc]init];
    [tapGestureRecognizer addTarget:self action:@selector(keyboardRecyclingAction)];
    [self.view addGestureRecognizer:tapGestureRecognizer];
    
}

#pragma mark - delegate
#pragma mark -- Delegate/textfield
- (BOOL)textFieldShouldReturn:(UITextField *)textField {
    [email_field resignFirstResponder];
    [password_field resignFirstResponder];
    return YES;
}
- (void)textFieldDidEndEditing:(UITextField *)textField {
    [email_field resignFirstResponder];
    [password_field resignFirstResponder];
}
#pragma mark - Event
#pragma mark -- Event/快速注册
- (IBAction)registerdButtonAction:(UIButton *)sender {
    
    [email_field resignFirstResponder];
    [password_field resignFirstResponder];
    
    RegisteredViewController *RVC = [[RegisteredViewController alloc]init];
    [[AppDelegate getInstance].CurNavController pushViewController:RVC animated:YES];
    
}
#pragma mark -- Event/查看密码
- (IBAction)lookPasswordAction:(UIButton *)sender {
    [email_field resignFirstResponder];
    [password_field resignFirstResponder];
    look_passwprd_Btn.selected = !look_passwprd_Btn.selected;
    if (look_passwprd_Btn.selected) {
        password_field.secureTextEntry = NO;
    }else {
        password_field.secureTextEntry = YES;
    }
}
#pragma mark -- Event/登录
- (IBAction)loginBtnAction:(UIButton *)sender {
    [email_field resignFirstResponder];
    [password_field resignFirstResponder];
    [self loaginDataRequest];
}
#pragma mark -- Event/忘记密码
- (IBAction)forgotPasswordBtnAction:(id)sender {
    [email_field resignFirstResponder];
    [password_field resignFirstResponder];
    ForgotPasswordViewController *FPVC = [[ForgotPasswordViewController alloc]init];
    [[AppDelegate getInstance].CurNavController pushViewController:FPVC animated:YES];
}
#pragma mark -- Event/键盘回收
- (void)keyboardRecyclingAction {
    [email_field resignFirstResponder];
    [password_field resignFirstResponder];
}

#pragma mark - Data
#pragma mark -- Data/登录
- (void)loaginDataRequest {
    [CustomHUD createHudCustomShowContent:@"请稍等..."];
    if ([Gobal isEmptyString:email_field.text]) {
        [CustomHUD createShowContent:@"请输入您的手机号" hiddenTime:2.4];
        return;
    }
    if ([email_field.text length]>11) {
        [CustomHUD createShowContent:@"请输入正确的手机号" hiddenTime:2.4];
        return;
    }
    if ([Gobal isEmptyString:password_field.text]) {
        [CustomHUD createShowContent:@"请输入密码" hiddenTime:2.4];
        return;
    }
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    manager.responseSerializer.acceptableContentTypes = [NSSet setWithObject:@"text/plain"];
    NSDictionary *parameters = @{
                                 @"phone"    : email_field.text,
                                 @"pwd"      : [SystemUtil customer_md5:password_field.text].lowercaseString,
                                 };
    [manager POST:PUBLIC_URL(LOGIN) parameters:parameters success:^(AFHTTPRequestOperation *operation,id responseObject) {
        NSLog(@"login_success: %@", responseObject);
        if ([responseObject[@"status"] isEqualToString:@"100"]) {
            
            NSString *memberId_str = responseObject[@"data"][@"memberId"];
            NSString *myCode_str = responseObject[@"data"][@"myCode"];
            NSString *phone_str = responseObject[@"data"][@"phone"];
            [Gobal saveAppSetting:memberId_str Key:BASE_KEY_memberId];
            [Gobal saveAppSetting:myCode_str Key:BASE_KEY_myCode];
            [Gobal saveAppSetting:phone_str Key:BASE_KEY_phone];

            
            [CustomHUD createShowContent:@"登录成功" hiddenTime:2.4];
            [self popBack];
        }else {
            [CustomHUD createShowContent:responseObject[@"message"] hiddenTime:2.4];
        }
        
    }failure:^(AFHTTPRequestOperation *operation,NSError *error) {
        [CustomHUD createShowContent:@"网络链接失败,请检查是否链接网络" hiddenTime:2.4];
    }];

}
#pragma mark -- Event/返回
-(void)popBack {
    if (_is_Enter_login) {
        [[AppDelegate getInstance].mainTabController hideTabbarView];
        [[AppDelegate getInstance].CurNavController popViewControllerAnimated:YES];
    }else {
        [[AppDelegate getInstance].mainTabController showTabbarView];
        [[AppDelegate getInstance].CurNavController popToRootViewControllerAnimated:YES];
    }
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}


@end







