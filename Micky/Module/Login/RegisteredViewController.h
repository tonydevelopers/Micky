//
//  RegisteredViewController.h
//  MickyEasyCredit
//
//  Created by 张宁 on 2016/11/8.
//  Copyright © 2016年 apple. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface RegisteredViewController : UIViewController

@property (weak, nonatomic) IBOutlet UITextField *phone_Field;
@property (weak, nonatomic) IBOutlet UITextField *password_Field;
@property (weak, nonatomic) IBOutlet UITextField *againPassword_Field;
@property (weak, nonatomic) IBOutlet UITextField *verification_Field;
@property (weak, nonatomic) IBOutlet UITextField *recommend_Field;
@property (weak, nonatomic) IBOutlet UIButton *getCode_Btn;
- (IBAction)getVerificationCodeAction:(UIButton *)sender;

@property (weak, nonatomic) IBOutlet UIButton *register_Btn;
- (IBAction)registeredBtnAction:(UIButton *)sender;

@property (weak, nonatomic) IBOutlet UIButton *login_Btn;
- (IBAction)loginBtnAction:(UIButton *)sender;

@property (weak, nonatomic) IBOutlet UIButton *look_password_Btn;
- (IBAction)lookPasswordBtnAction:(UIButton *)sender;

@property (weak, nonatomic) IBOutlet UIButton *selectAgree_Btn;
- (IBAction)selectAgreeBtnAction:(UIButton *)sender;

@property (weak, nonatomic) IBOutlet UIButton *registrateAgreement_Btn;
- (IBAction)registrationAgreementBtnAction:(UIButton *)sender;


@end
