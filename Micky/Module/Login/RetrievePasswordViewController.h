//
//  RetrievePasswordViewController.h
//  MickyEasyCredit
//
//  Created by 张宁 on 2016/11/9.
//  Copyright © 2016年 apple. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface RetrievePasswordViewController : UIViewController
@property (strong, nonatomic) NSString *email_string;

@property (weak, nonatomic) IBOutlet UIView *password_view;
@property (weak, nonatomic) IBOutlet UIView *againPassword_view;

@property (weak, nonatomic) IBOutlet UITextField *password_field;
@property (weak, nonatomic) IBOutlet UITextField *againPassword_field;

@property (weak, nonatomic) IBOutlet UIButton *confirm_Btn;
- (IBAction)confirmBtnAction:(UIButton *)sender;

@end
