//
//  RetrievePasswordViewController.m
//  MickyEasyCredit
//
//  Created by 张宁 on 2016/11/9.
//  Copyright © 2016年 apple. All rights reserved.
//

#import "RetrievePasswordViewController.h"
#import "AppDelegate.h"
#import "AFNetworking.h"
#import "SystemUtil.h"
#import "InternationalCintrol.h"
#import "LoginViewController.h"

@interface RetrievePasswordViewController ()<UITextFieldDelegate>
{
    UITapGestureRecognizer *tapGestureRecognizer;
    BOOL is_change_text;
    UILabel *titleLabel;
}
@end

@implementation RetrievePasswordViewController
@synthesize  password_view;
@synthesize  againPassword_view;
@synthesize  password_field;
@synthesize  againPassword_field;
@synthesize  confirm_Btn;

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
    [password_view addSubview:line_1];
    
    UIView *line_2 = [Gobal drawSolidLinePointX:0 PointY:39 lineW:SCREEN_WIDTH-40 lineH:1 lineColor:@[@"50",@"50",@"50"] lineAlpha:1.0];
    [againPassword_view addSubview:line_2];
    
    password_field.placeholder = @"请输入新密码";
    password_field.delegate = self;
    password_field.secureTextEntry = YES;
    password_field.clearButtonMode = UITextFieldViewModeAlways;
    
    againPassword_field.placeholder =  @"请再次确认密码";
    againPassword_field.delegate = self;
    againPassword_field.secureTextEntry = YES;
    againPassword_field.clearButtonMode = UITextFieldViewModeAlways;
    
    
    [confirm_Btn setTitle:@"确定" forState:UIControlStateNormal];
    confirm_Btn.layer.cornerRadius = 40/2.0;
    confirm_Btn.layer.masksToBounds = YES;
    confirm_Btn.backgroundColor = [UIColor clearColor];
    [confirm_Btn setBackgroundImage:[Gobal imageWithColor:BUTTON_COLOR_NORMA size:confirm_Btn.frame.size]  forState:UIControlStateNormal];
    [confirm_Btn setBackgroundImage:[Gobal imageWithColor:BUTTON_COLOR_NORMA size:confirm_Btn.frame.size]  forState:UIControlStateHighlighted];
    
    tapGestureRecognizer = [[UITapGestureRecognizer alloc]init];
    [tapGestureRecognizer addTarget:self action:@selector(keyboardRecyclingAction)];
    [self.view addGestureRecognizer:tapGestureRecognizer];
    
}
#pragma mark - Delegate
#pragma mark -- delegate/键盘回收
- (void)keyboardRecyclingAction {
    [password_field resignFirstResponder];
    [againPassword_field resignFirstResponder];
}
#pragma mark -- delegate/textfield
- (BOOL)textFieldShouldReturn:(UITextField *)textField {
    [password_field resignFirstResponder];
    [againPassword_field resignFirstResponder];
    return YES;
}
- (void)textFieldDidEndEditing:(UITextField *)textField {
    [password_field resignFirstResponder];
    [againPassword_field resignFirstResponder];
}
#pragma mark - Event
#pragma mark -- Event/提交注册
- (IBAction)confirmBtnAction:(UIButton *)sender {
    [password_field resignFirstResponder];
    [againPassword_field resignFirstResponder];

    [self retrievePasswordDataRequest];
}
#pragma mark - Data
#pragma mark -- Data/找回密码
- (void)retrievePasswordDataRequest {
    
    if ([Gobal isEmptyString:password_field.text]) {
        [CustomHUD createShowContent:@"请设置密码" hiddenTime:2.4];
        return;
    }
    if ([Gobal isEmptyString:againPassword_field.text]) {
        [CustomHUD createShowContent:@"请在次确认密码" hiddenTime:2.4];
        return;
    }
    if (![password_field.text isEqualToString:againPassword_field.text]) {
        [CustomHUD createShowContent:@"两次密码不一致,请重新确认" hiddenTime:2.4];
        return;
    }
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    manager.responseSerializer.acceptableContentTypes = [NSSet setWithObject:@"text/plain"];
    NSDictionary *parameters = @{
                                 @"phone"   : _email_string,
                                 @"pwd"     : [SystemUtil customer_md5:password_field.text].lowercaseString,
                                 };
    [manager POST:PUBLIC_URL(SENDCODECONFIRM) parameters:parameters success:^(AFHTTPRequestOperation *operation,id responseObject) {
        NSLog(@"sendCode_success: %@", responseObject);
        
        if ([responseObject[@"status"] isEqualToString:@"100"]) {
            
            [self.navigationController popToViewController:self.navigationController.childViewControllers[1] animated:YES];
            
        }else {
            [CustomHUD createShowContent:responseObject[@"message"] hiddenTime:2.4];
        }
        
    }failure:^(AFHTTPRequestOperation *operation,NSError *error) {
        [CustomHUD createShowContent:@"网络链接失败,请检查是否链接网络" hiddenTime:2.4];
    }];
}
#pragma mark -- Event/成功找回密码
- (void)popBackAfterDelay {
    [CustomHUD createShowContent:@"密码找回成功" hiddenTime:3.0];
    LoginViewController *loginVC = [[LoginViewController alloc] init];
    [[AppDelegate getInstance].CurNavController pushViewController:loginVC animated:YES];
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
