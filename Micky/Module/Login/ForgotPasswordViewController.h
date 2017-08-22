//
//  ForgotPasswordViewController.h
//  MickyEasyCredit
//
//  Created by 张宁 on 2016/11/9.
//  Copyright © 2016年 apple. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ForgotPasswordViewController : UIViewController

@property (weak, nonatomic) IBOutlet UIView *ver_view;
@property (weak, nonatomic) IBOutlet UIView *email_view;
@property (weak, nonatomic) IBOutlet UITextField *email_field;
@property (weak, nonatomic) IBOutlet UIButton *sumbit_Btn;
- (IBAction)sumbitBtnAction:(UIButton *)sender;
@property (weak, nonatomic) IBOutlet UITextField *verificationCode_Field;
@property (weak, nonatomic) IBOutlet UIButton *getCodeBtn;
- (IBAction)getCodeButtonAction:(UIButton *)sender;

@end
