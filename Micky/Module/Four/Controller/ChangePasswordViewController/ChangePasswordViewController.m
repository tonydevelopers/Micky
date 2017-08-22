//
//  ChangePasswordViewController.m
//  MickyEasyCredit
//
//  Created by 张宁 on 2017/4/7.
//  Copyright © 2017年 apple. All rights reserved.
//

#import "ChangePasswordViewController.h"
#import "AFNetworking.h"
#import "AppDelegate.h"

#import "ChangePasswordTableCell.h"


@interface ChangePasswordViewController ()<UITableViewDelegate,UITableViewDataSource,UITextFieldDelegate>
{
    UILabel *titleLabel;
    NSMutableArray *data_A;
    UITableView *ChangePassword_Table;
    UITapGestureRecognizer *tapGestureRecognizer;
    
    UITextField *parentTextField;
    
    UIView *footer_View;
    UIButton *confirm_Btn;
    
    NSString *old_password;
    NSString *new_password;
    NSString *again_password;

}
@end

@implementation ChangePasswordViewController

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    NAVIGATIONBAR_COLOR_STYLE(BUTTON_COLOR_NORMA,UIStatusBarStyleLightContent);
}
- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = BACKGROUND_COLOR;
    self.navigationController.navigationBar.hidden = NO;
    [[UIApplication sharedApplication] setStatusBarStyle:UIStatusBarStyleLightContent];
    
    [self initData];
    [self initNavigate];
    [self initTable];
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
    titleLabel.text = @"修改密码";
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
#pragma mark -- init/Table
- (void)initTable {
    
    ChangePassword_Table = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT-64-50) style:UITableViewStylePlain];
    ChangePassword_Table.delegate = self;
    ChangePassword_Table.dataSource = self;
    ChangePassword_Table.showsVerticalScrollIndicator = NO;
    ChangePassword_Table.showsHorizontalScrollIndicator = NO;
    ChangePassword_Table.backgroundColor = BACKGROUND_COLOR;
    ChangePassword_Table.separatorStyle = UITableViewCellSeparatorStyleNone;
    [self.view addSubview:ChangePassword_Table];
    tapGestureRecognizer = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapGestureAction)];
    [ChangePassword_Table addGestureRecognizer:tapGestureRecognizer];

    [self initFooter];
}
#pragma mark -- init/Footer
- (void)initFooter {
    
    footer_View = [[UIView alloc]init];
    footer_View.backgroundColor = [UIColor clearColor];
    footer_View.frame = CGRectMake(0, 0, SCREEN_WIDTH, 80);
    ChangePassword_Table.tableFooterView = footer_View;
    
    confirm_Btn = [UIButton buttonWithType:UIButtonTypeCustom];
    confirm_Btn.frame = CGRectMake(20, CGRectGetHeight(footer_View.frame)-45, SCREEN_WIDTH-40, 45);
    [confirm_Btn setTitle:@"确认" forState:UIControlStateNormal];
    [confirm_Btn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [confirm_Btn setBackgroundImage:[Gobal imageWithColor:BUTTON_COLOR_NORMA size:confirm_Btn.frame.size] forState:UIControlStateNormal];
    [confirm_Btn setBackgroundImage:[Gobal imageWithColor:BUTTON_COLOR_HIGHT size:confirm_Btn.frame.size] forState:UIControlStateHighlighted];
    [confirm_Btn addTarget:self action:@selector(confirmBtnAction) forControlEvents:UIControlEventTouchUpInside];
    confirm_Btn.layer.cornerRadius = 5;
    confirm_Btn.layer.masksToBounds = YES;
    [footer_View addSubview:confirm_Btn];
    
}

#pragma mark - delegate
#pragma mark -- delegate/table
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 3;
}
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    return 0;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 50;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *oneCell = @"oneCell";
    ChangePasswordTableCell *cell = [tableView dequeueReusableCellWithIdentifier:oneCell];
    if (!cell) {
        cell = [[ChangePasswordTableCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:oneCell];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        NSArray *holder_A = @[@"请输入旧密码",@"请输入新密码(6~16位数字字母组合)",@"请再次确认您的密码"];
        [cell setFieldPlaceholder:holder_A[indexPath.row]];
        cell.field.tag = indexPath.row;
        cell.field.delegate = self;
    }
    return cell;
}
- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    return [Gobal drawSolidLinePointX:0 PointY:0 lineW:SCREEN_WIDTH lineH:20 lineColor:@[@"240",@"240",@"240"] lineAlpha:1.0];
}
#pragma mark -- delegate/field
- (BOOL)textFieldShouldReturn:(UITextField *)textField{
    [textField resignFirstResponder];
    return YES;
}
- (void)textFieldDidBeginEditing:(UITextField *)textField{
    parentTextField = textField;
}
- (void)textFieldDidEndEditing:(UITextField *)textField{
    [parentTextField resignFirstResponder];
    if ([textField.placeholder isEqualToString:@"请输入旧密码"]) {
         old_password = textField.text;//旧密码
    }else if ([textField.placeholder isEqualToString:@"请输入新密码(6~16位数字字母组合)"]){
        new_password = textField.text;//新密码
    }else if ([textField.placeholder isEqualToString:@"请再次确认您的密码"]){
        again_password = textField.text;//确认密码
    }
}

#pragma mark - Event
#pragma mark -- Event/确认修改
- (void)confirmBtnAction {
    [parentTextField resignFirstResponder];
    [self changePasswordDataRequest];
}
#pragma mark -- Event/回收键盘
- (void)tapGestureAction {
    [parentTextField resignFirstResponder];
}
#pragma mark - Data
#pragma mark -- Data/修改密码
- (void)changePasswordDataRequest {
    
    if ([Gobal isEmptyString:old_password]) {
        [CustomHUD createShowContent:@"请输入您的旧密码" hiddenTime:2.4];
        return;
    }
    if ([Gobal isEmptyString:new_password]) {
        [CustomHUD createShowContent:@"请输入您的新密码" hiddenTime:2.4];
        return;
    }
    if ([Gobal isEmptyString:again_password]) {
        [CustomHUD createShowContent:@"请再次输入您的新密码" hiddenTime:2.4];
        return;
    }
    if (![new_password isEqualToString:again_password]) {
        [CustomHUD createShowContent:@"两次密码不一致,请重新填写" hiddenTime:2.4];
        return;
    }
    
    NSString *user_Id = [Gobal loadAppSetting:BASE_KEY_memberId];
    NSDictionary *parameters = @{
                                 @"userId" : [Gobal isEmptyString:user_Id]?@"":user_Id,
                                 @"pwd"    : [SystemUtil customer_md5:old_password].lowercaseString,
                                 @"newPwd" : [SystemUtil customer_md5:new_password].lowercaseString
                                 };
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    manager.responseSerializer.acceptableContentTypes = [NSSet setWithObject:@"text/plain"];
    [manager POST:PUBLIC_URL(UPDATEPWD) parameters:parameters success:^(AFHTTPRequestOperation *operation,id responseObject) {
        NSLog(@"updatePwd_success: %@", responseObject);
        if ([responseObject[@"status"] isEqualToString:@"100"]) {
            
            [CustomHUD createShowContent:responseObject[@"message"] hiddenTime:2.4];
            self.navigationController.navigationBar.hidden = YES;
            [[AppDelegate getInstance].mainTabController showTabbarView];
            [[AppDelegate getInstance].CurNavController popToRootViewControllerAnimated:YES];

        }        
    }failure:^(AFHTTPRequestOperation *operation,NSError *error) {
        [CustomHUD createShowContent:@"网络链接失败,请检查是否链接网络" hiddenTime:2.4];
    }];
}



#pragma mark -- Event/back
-(void)popBack {
    [[AppDelegate getInstance].mainTabController hideTabbarView];
    [[AppDelegate getInstance].CurNavController popViewControllerAnimated:YES];
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}
@end
