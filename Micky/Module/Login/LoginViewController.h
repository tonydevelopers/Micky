//
//  LoginViewController.h
//  MickyEasyCredit
//
//  Created by 张宁 on 2016/11/7.
//  Copyright © 2016年 apple. All rights reserved.
//

#import <UIKit/UIKit.h>
@interface LoginViewController : UIViewController

@property (strong, nonatomic) UIView *left_line;
@property (strong, nonatomic) UIView *right_line;

@property (weak, nonatomic) IBOutlet UIView *email_view;
@property (weak, nonatomic) IBOutlet UIView *password_view;
@property (weak, nonatomic) IBOutlet UITextField *email_field;
@property (weak, nonatomic) IBOutlet UITextField *password_field;
@property (weak, nonatomic) IBOutlet UIButton *look_passwprd_Btn;
- (IBAction)lookPasswordAction:(UIButton *)sender;
@property (weak, nonatomic) IBOutlet UIButton *login_Btn;
- (IBAction)loginBtnAction:(UIButton *)sender;
@property (weak, nonatomic) IBOutlet UIButton *forgotPassword_Btn;
- (IBAction)forgotPasswordBtnAction:(id)sender;

@property (weak, nonatomic) IBOutlet UIButton *register_Btn;
- (IBAction)registerdButtonAction:(UIButton *)sender;

@property(nonatomic,assign)BOOL is_Enter_login;

@end
