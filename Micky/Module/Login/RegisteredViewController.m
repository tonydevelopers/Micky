//
//  RegisteredViewController.m
//  MickyEasyCredit
//
//  Created by 张宁 on 2016/11/8.
//  Copyright © 2016年 apple. All rights reserved.
//

#import "RegisteredViewController.h"
#import "AppDelegate.h"
#import "AFNetworking.h"
#import "SystemUtil.h"

#import "MZTimerLabel.h"
#import "ExternalLinksViewController.h"
#import "NSDictionary+String.h"
#import "NSString+MD5.h"

@interface RegisteredViewController ()<UITextFieldDelegate,UIActionSheetDelegate,MZTimerLabelDelegate>
{
    CGRect Frame;
    CGRect curFrame;
    BOOL is_select;
    NSString *code_string;
    MZTimerLabel *_timerLabel;
    UITapGestureRecognizer *tapGestureRecognizer;
}
@end

@implementation RegisteredViewController
@synthesize phone_Field;
@synthesize password_Field;
@synthesize verification_Field;
@synthesize recommend_Field;
@synthesize getCode_Btn;
@synthesize register_Btn;
@synthesize login_Btn;
@synthesize againPassword_Field;
@synthesize look_password_Btn;
@synthesize selectAgree_Btn;

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
    is_select = YES;
    Frame = [UIScreen mainScreen].bounds;

}
#pragma mark -- init/layout
-(void)initLayout {
    
    phone_Field.delegate = self;
    phone_Field.keyboardType = UIKeyboardTypeNumberPad;
    phone_Field.clearButtonMode = UITextFieldViewModeAlways;
    
    password_Field.delegate = self;
    password_Field.secureTextEntry = YES;
    password_Field.clearButtonMode = UITextFieldViewModeAlways;
    
    againPassword_Field.delegate = self;
    againPassword_Field.secureTextEntry = YES;
    againPassword_Field.clearButtonMode = UITextFieldViewModeAlways;
    
    verification_Field.delegate = self;
    verification_Field.keyboardType = UIKeyboardTypeNumberPad;
    verification_Field.clearButtonMode = UITextFieldViewModeAlways;
    
    recommend_Field.delegate = self;
    recommend_Field.keyboardType = UIKeyboardTypeNumberPad;
    recommend_Field.clearButtonMode = UITextFieldViewModeAlways;
    
    [look_password_Btn setImage:[UIImage imageNamed:@"my_eye_no"] forState:UIControlStateNormal];
    [look_password_Btn setImage:[UIImage imageNamed:@"my_eye"] forState:UIControlStateSelected];
    
    getCode_Btn.layer.cornerRadius = 5;
    getCode_Btn.layer.masksToBounds = YES;
    
    register_Btn.layer.cornerRadius = 40/2.0;
    register_Btn.layer.masksToBounds = YES;
    register_Btn.backgroundColor = [UIColor clearColor];
    [register_Btn setBackgroundImage:[Gobal imageWithColor:BUTTON_COLOR_NORMA size:register_Btn.frame.size]  forState:UIControlStateNormal];
    [register_Btn setBackgroundImage:[Gobal imageWithColor:BUTTON_COLOR_HIGHT size:register_Btn.frame.size]  forState:UIControlStateHighlighted];
    
    [selectAgree_Btn setBackgroundImage:[UIImage imageNamed:@"select_agree_Y"] forState:UIControlStateNormal];
    [selectAgree_Btn setBackgroundImage:[UIImage imageNamed:@"select_agree_N"] forState:UIControlStateSelected];

    
    tapGestureRecognizer = [[UITapGestureRecognizer alloc]init];
    [tapGestureRecognizer addTarget:self action:@selector(keyboardRecyclingAction)];
    [self.view addGestureRecognizer:tapGestureRecognizer];

}
#pragma mark -- init/倒计时
#pragma mark - 倒计时
- (void)setTimer{
    
    if (_timerLabel != nil) {
        _timerLabel = nil;
    }
    [getCode_Btn setTitle:@"" forState:UIControlStateNormal];
    _timerLabel = [[MZTimerLabel alloc] initWithLabel:_timerLabel andTimerType:MZTimerLabelTypeTimer];
    [_timerLabel setBackgroundColor:[UIColor clearColor]];
    _timerLabel.timeFormat = @"(ss)重新获取";
    
    _timerLabel.timeLabel.font = [UIFont systemFontOfSize:11];
    _timerLabel.timeLabel.textAlignment = NSTextAlignmentCenter;
    _timerLabel.timeLabel.textColor = [UIColor whiteColor];
    [_timerLabel setCountDownTime:60];
    _timerLabel.delegate = self;
    [_timerLabel start];
    [_timerLabel setFrame:CGRectMake(0, 0, getCode_Btn.frame.size.width, getCode_Btn.frame.size.height)];
    getCode_Btn.backgroundColor = BUTTON_COLOR_NORMA;
    [getCode_Btn addSubview:_timerLabel];
    getCode_Btn.enabled = NO;
    
}
#pragma mark - MZTimerLabel delegate
- (void)timerLabel:(MZTimerLabel*)timerLabel finshedCountDownTimerWithTime:(NSTimeInterval)countTime{
    
    [_timerLabel setHidden:YES];
    getCode_Btn.backgroundColor = [UIColor colorWithRed:105/255.0f green:124/255.0f blue:214/255.0f alpha:1.0f];
    [getCode_Btn setTitle:@"重新获取" forState:UIControlStateNormal];
    [getCode_Btn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    getCode_Btn.enabled = YES;
}
#pragma mark - Delegate
#pragma mark -- delegate/键盘回收
- (void)keyboardRecyclingAction {
    [phone_Field resignFirstResponder];
    [password_Field resignFirstResponder];
    [recommend_Field resignFirstResponder];
    [verification_Field resignFirstResponder];
    [againPassword_Field resignFirstResponder];
}
#pragma mark -- delegate/textfield
- (BOOL)textFieldShouldReturn:(UITextField *)textField {
    [phone_Field resignFirstResponder];
    [password_Field resignFirstResponder];
    [recommend_Field resignFirstResponder];
    [verification_Field resignFirstResponder];
    [againPassword_Field resignFirstResponder];
    return YES;
}
- (void)textFieldDidBeginEditing:(UITextField *)textField {
    curFrame=Frame;
    if (textField == verification_Field) {
        [UIView animateWithDuration:0.3f animations:^{
            curFrame.origin.y -= 100;
            self.view.frame = curFrame;
        }];
    }
    if (textField == recommend_Field) {
        [UIView animateWithDuration:0.3f animations:^{
            curFrame.origin.y -= 150;
            self.view.frame = curFrame;
        }];
    }

}
- (void)textFieldDidEndEditing:(UITextField *)textField {
    [phone_Field resignFirstResponder];
    [password_Field resignFirstResponder];
    [recommend_Field resignFirstResponder];
    [verification_Field resignFirstResponder];
    [againPassword_Field resignFirstResponder];

    if (Frame.origin.y-curFrame.origin.y == 100) {
        [UIView animateWithDuration:0.3f animations:^{
            self.view.frame=Frame;
        }];
    }
    if (Frame.origin.y-curFrame.origin.y == 150) {
        [UIView animateWithDuration:0.3f animations:^{
            self.view.frame=Frame;
        }];
    }

}
#pragma mark - Event
#pragma mark -- Event/查看密码
- (IBAction)lookPasswordBtnAction:(UIButton *)sender {
    [phone_Field resignFirstResponder];
    [password_Field resignFirstResponder];
    [recommend_Field resignFirstResponder];
    [verification_Field resignFirstResponder];
    [againPassword_Field resignFirstResponder];
    look_password_Btn.selected = !look_password_Btn.selected;
    if (look_password_Btn.selected) {
        password_Field.secureTextEntry = NO;
    }else {
        password_Field.secureTextEntry = YES;
    }
}
#pragma mark -- Event/立即登录
- (IBAction)loginBtnAction:(UIButton *)sender {
    [self popBack];
}
#pragma mark -- Event/获取验证码
- (IBAction)getVerificationCodeAction:(UIButton *)sender {
    [phone_Field resignFirstResponder];
    [password_Field resignFirstResponder];
    [recommend_Field resignFirstResponder];
    [verification_Field resignFirstResponder];
    [againPassword_Field resignFirstResponder];

    [self getVerificationCodeData];
}
#pragma mark -- Event/提交注册
- (IBAction)registeredBtnAction:(UIButton *)sender {
    [phone_Field resignFirstResponder];
    [password_Field resignFirstResponder];
    [recommend_Field resignFirstResponder];
    [verification_Field resignFirstResponder];
    [againPassword_Field resignFirstResponder];
    [self registerDataRequest];
}
- (IBAction)selectAgreeBtnAction:(UIButton *)sender {
    [phone_Field resignFirstResponder];
    [password_Field resignFirstResponder];
    [recommend_Field resignFirstResponder];
    [verification_Field resignFirstResponder];
    [againPassword_Field resignFirstResponder];
    
    sender.selected = !sender.selected;
    if (sender.selected == YES) {
        is_select = NO;
    }else {
        is_select = YES;
    }

}
- (IBAction)registrationAgreementBtnAction:(UIButton *)sender {
    [phone_Field resignFirstResponder];
    [password_Field resignFirstResponder];
    [recommend_Field resignFirstResponder];
    [verification_Field resignFirstResponder];
    [againPassword_Field resignFirstResponder];
    
    [[AppDelegate getInstance].mainTabController hideTabbarView];
    ExternalLinksViewController *ELVC = [[ExternalLinksViewController alloc]init];
    ELVC.class_name = @"注册协议";
    ELVC.externalLink_url = WEBURL(WEB_REGISTER);
    [[AppDelegate getInstance].CurNavController pushViewController:ELVC animated:YES];
}
#pragma mark - Data
#pragma mark -- Data/获取验证码
- (void)getVerificationCodeData {

    if ([Gobal isEmptyString:phone_Field.text]) {
        [CustomHUD createShowContent:@"请输入您的手机号" hiddenTime:2.4];
        return;
    }
    if ([phone_Field.text length]>11) {
        [CustomHUD createShowContent:@"请输入正确的手机号" hiddenTime:2.4];
        return;
    }
    
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    manager.responseSerializer.acceptableContentTypes = [NSSet setWithObject:@"text/plain"];
    NSDictionary *parameters = @{
                                 @"phone"    : phone_Field.text,
                                };
    
    [manager POST:PUBLIC_URL(SENDCODE) parameters:parameters success:^(AFHTTPRequestOperation *operation,id responseObject) {
        NSLog(@"sendCode_success: %@", responseObject);
        
        if ([responseObject[@"status"] isEqualToString:@"100"]) {

            [self setTimer];
//            code_string = responseObject[@"data"][@"code"];
//            [CustomHUD createShowContent:code_string hiddenTime:2.4];
        }else {
            [CustomHUD createShowContent:responseObject[@"message"] hiddenTime:2.4];
        }
        
    }failure:^(AFHTTPRequestOperation *operation,NSError *error) {
        [CustomHUD createShowContent:@"网络链接失败,请检查是否链接网络" hiddenTime:2.4];
    }];
}
#pragma mark -- Data/注册
- (void)registerDataRequest {
    if (!is_select) {
        [CustomHUD createShowContent:@"请仔细阅读仟易贷注册协议" hiddenTime:2.4];
        return;
    }
    if ([Gobal isEmptyString:phone_Field.text]) {
        [CustomHUD createShowContent:@"请输入您的手机号" hiddenTime:2.4];
        return;
    }
    if ([phone_Field.text length]>11) {
        [CustomHUD createShowContent:@"请输入正确的手机号" hiddenTime:2.4];
        return;
    }
    if ([Gobal isEmptyString:password_Field.text]) {
        [CustomHUD createShowContent:@"请输入密码" hiddenTime:2.4];
        return;
    }
    if (![againPassword_Field.text isEqualToString:password_Field.text]) {
        [CustomHUD createShowContent:@"两次密码不一致,请重新输入" hiddenTime:2.4];
        return;
    }
    if ([Gobal isEmptyString:verification_Field.text]) {
        [CustomHUD createShowContent:@"请输入验证码" hiddenTime:2.4];
        return;
    }
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    manager.responseSerializer.acceptableContentTypes = [NSSet setWithObject:@"text/plain"];
    NSDictionary *parameters = @{
                                 @"phone"    : phone_Field.text,
                                 @"code"     : verification_Field.text,
                                 @"pwd"      : [SystemUtil customer_md5:password_Field.text].lowercaseString,
                                 @"joincode" : [Gobal isEmptyString:recommend_Field.text]?@"":recommend_Field.text,
                                 };
    
    NSString * urlParams = [parameters urlParams];
    NSString * md5Str = [urlParams md5];
    

    NSLog(@"params: %@", urlParams);
    
    [manager POST:PUBLIC_URL(REGISTER) parameters:parameters success:^(AFHTTPRequestOperation *operation,id responseObject) {
        NSLog(@"register_success: %@", responseObject);
        
        if ([responseObject[@"status"] isEqualToString:@"100"]) {
            [CustomHUD createShowContent:@"注册成功" hiddenTime:2.4];
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

    [[AppDelegate getInstance].mainTabController hideTabbarView];
    [[AppDelegate getInstance].CurNavController popViewControllerAnimated:YES];
    
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}
@end
