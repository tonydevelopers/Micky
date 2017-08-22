//
//  SettingViewController.m
//  MickyEasyCredit
//
//  Created by 张宁 on 2017/4/6.
//  Copyright © 2017年 apple. All rights reserved.
//

#import "SettingViewController.h"
#import "UIImageView+WebCache.h"
#import "AFNetworking.h"
#import "AppDelegate.h"

#import "SettingTableCell.h"
#import "ChangePasswordViewController.h"

@interface SettingViewController ()<UITableViewDelegate,UITextFieldDelegate,UITableViewDataSource,UIActionSheetDelegate,UIAlertViewDelegate,UINavigationControllerDelegate,UIImagePickerControllerDelegate,SettingTableDelegate>
{
    UILabel *titleLabel;
    UITableView *setting_Table;
    NSMutableArray *data_A;
    
    UIView *footer_View;
    UIImage *photo_Image;
    NSString *photo_url_Img;
    UIButton *launch_login_Btn;
    UIActionSheet *photo_sheet;
    UITextField *parent_field;
    UITapGestureRecognizer *tapGestureRecognizer;
    
}


@end

@implementation SettingViewController

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
    titleLabel.text = @"账号信息";
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
    
    setting_Table = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT-64-50) style:UITableViewStylePlain];
    setting_Table.delegate = self;
    setting_Table.dataSource = self;
    setting_Table.showsVerticalScrollIndicator = NO;
    setting_Table.showsHorizontalScrollIndicator = NO;
    setting_Table.backgroundColor = BACKGROUND_COLOR;
    setting_Table.separatorStyle = UITableViewCellSeparatorStyleNone;
    [self.view addSubview:setting_Table];
    
    tapGestureRecognizer = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(tapGestureRecognizerAction)];
    [setting_Table addGestureRecognizer:tapGestureRecognizer];
    
    [self initFooter];
}
#pragma mark -- init/Footer
- (void)initFooter {

    footer_View = [[UIView alloc]init];
    footer_View.backgroundColor = [UIColor clearColor];
    footer_View.frame = CGRectMake(0, 0, SCREEN_WIDTH, 100);
    setting_Table.tableFooterView = footer_View;
    
    launch_login_Btn = [UIButton buttonWithType:UIButtonTypeCustom];
    launch_login_Btn.frame = CGRectMake(20, CGRectGetHeight(footer_View.frame)-45, SCREEN_WIDTH-40, 45);
    [launch_login_Btn setTitle:@"退出登录" forState:UIControlStateNormal];
    [launch_login_Btn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [launch_login_Btn setBackgroundImage:[Gobal imageWithColor:BUTTON_COLOR_NORMA size:launch_login_Btn.frame.size] forState:UIControlStateNormal];
    [launch_login_Btn setBackgroundImage:[Gobal imageWithColor:BUTTON_COLOR_HIGHT size:launch_login_Btn.frame.size] forState:UIControlStateHighlighted];
    [launch_login_Btn addTarget:self action:@selector(outLoginBtnAction) forControlEvents:UIControlEventTouchUpInside];
    launch_login_Btn.layer.cornerRadius = 5;
    launch_login_Btn.layer.masksToBounds = YES;
    [footer_View addSubview:launch_login_Btn];

}

#pragma mark - delegate
#pragma mark -- delegate/table
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 4;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {

    if (indexPath.row == 0) {
        return 80;
    }else {
        return 45;
    }
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *oneCell = @"oneCell";
    SettingTableCell *cell = [tableView dequeueReusableCellWithIdentifier:oneCell];
    if (!cell) {
        cell = [[SettingTableCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:oneCell];
        if (indexPath.row != 3) {
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
        }
        cell.nick_name.delegate = self;
        cell.nick_name.tag = 111222;
        cell.deleagte = self;
    }

    NSArray *title_A = @[@"头像",@"昵称",@"账号",@"修改密码"];
    [cell setTitleLabel:title_A[indexPath.row] indexPathRow:indexPath.row];
    
    if (photo_url_Img != nil) {
        [cell.photo sd_setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@%@",IMGURLIP,photo_url_Img]] placeholderImage:[UIImage imageNamed:@"header_photo"]];
    }else{
        if (![Gobal isEmptyString:_photo_url]) {
            [cell.photo sd_setImageWithURL:[NSURL URLWithString:_photo_url] placeholderImage:[UIImage imageNamed:@"header_photo"]];
        }else{
            cell.photo.image = [UIImage imageNamed:@"header_photo"];
        }
    }
    switch (indexPath.row) {
        case 1:{
            cell.nick_name.text = [Gobal isEmptyString:_name_str]?@"--":_name_str;
        }
            break;
        case 2:{
            cell.right_label.text = [Gobal isEmptyString:_phone_str]?@"--":_phone_str;
        }
            break;
        default:
            break;
    }
    return cell;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    NSLog(@"didSelectRowAtIndexPath == %ld",indexPath.row);
    
    switch (indexPath.row) {
        case 0:{
            photo_sheet = [[UIActionSheet alloc]initWithTitle:nil delegate:self cancelButtonTitle:@"取消" destructiveButtonTitle:nil otherButtonTitles:@"从相机拍下照片",@"从手机图片库取照片", nil];
            [photo_sheet showInView:self.view];
        }
            break;
        case 3:{
            
            [[AppDelegate getInstance].mainTabController hideTabbarView];
            ChangePasswordViewController *CPVC = [[ChangePasswordViewController alloc]init];
            [[AppDelegate getInstance].CurNavController pushViewController:CPVC animated:YES];
        }
            break;

        default:
            break;
    }
}
#pragma mark -- delegate/field
- (BOOL)textFieldShouldReturn:(UITextField *)textField {
    [textField resignFirstResponder];
    return YES;
}
-(void)textFieldDidBeginEditing:(UITextField *)textField {
    parent_field = textField;
}
-(void)textFieldDidEndEditing:(UITextField *)textField {
    [self changenicknameDataRequest:textField.text];
}
- (void)tapGestureRecognizerAction {
    [parent_field resignFirstResponder];
}
- (void)clickSelectChangePassword:(NSInteger)indexTag {
    
    NSLog(@"didSelectRowAtIndexPath == %ld",indexTag);

    switch (indexTag) {
        case 0:{
            photo_sheet = [[UIActionSheet alloc]initWithTitle:nil delegate:self cancelButtonTitle:@"取消" destructiveButtonTitle:nil otherButtonTitles:@"从相机拍下照片",@"从手机图片库取照片", nil];
            [photo_sheet showInView:self.view];
        }
            break;
        case 3:{
            
            [[AppDelegate getInstance].mainTabController hideTabbarView];
            ChangePasswordViewController *CPVC = [[ChangePasswordViewController alloc]init];
            [[AppDelegate getInstance].CurNavController pushViewController:CPVC animated:YES];
        }
            break;
            
        default:
            break;
    }
}
#pragma mark - Event
#pragma mark -- Event/推出登录
- (void)outLoginBtnAction {
    
    UIAlertView *alert = [[UIAlertView alloc]initWithTitle:@"温馨提示" message:@"是否退出登录？" delegate:self cancelButtonTitle:@"取消" otherButtonTitles:@"确认", nil];
    [alert show];

}
-(void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex {
    NSLog(@"clickedButtonAtIndex == %ld",(long)buttonIndex);
    switch (buttonIndex) {
        case 0: {
        }
            break;
        case 1: {
            
            [Gobal saveAppSetting:@"" Key:BASE_KEY_memberId];
            [Gobal saveAppSetting:@"" Key:BASE_KEY_faceImg];
            [Gobal saveAppSetting:@"" Key:BASE_KEY_myCode];
            [Gobal saveAppSetting:@"" Key:BASE_KEY_phone];
            [Gobal saveAppSetting:@"" Key:BASE_KEY_name];

            [self popBack];
            dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1.0 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                [[AppDelegate getInstance] callLoginView:NO];
            });
        }
            break;
        default:
            break;
    }
}
#pragma mark -- Event/上传照片
- (void)actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex {
    
    switch (buttonIndex) {
        case 0:
            [self pickPhoto:UIImagePickerControllerSourceTypeCamera];
            break;
        case 1:
            [self pickPhoto:UIImagePickerControllerSourceTypePhotoLibrary];
            break;
        default:
            break;
    }
    
}
- (void)pickPhoto:(UIImagePickerControllerSourceType)sourceType{
    
    UIImagePickerController *picker = [[UIImagePickerController alloc]init];
    picker.delegate = self;
    picker.sourceType = sourceType;
    picker.allowsEditing = YES;
    picker.videoQuality = UIImagePickerControllerQualityTypeLow;
    [self presentViewController:picker animated:YES completion:nil];
    
}
#pragma mark -- delegate/UIImagePickerControllerDelegate
-(void)imagePickerControllerDidCancel:(UIImagePickerController *)picker{
    [picker dismissViewControllerAnimated:YES completion:nil];
}
- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info{
    [picker dismissViewControllerAnimated:YES completion:nil];

    photo_Image = [info objectForKey:UIImagePickerControllerEditedImage];
    NSData *ImageData = UIImageJPEGRepresentation(photo_Image, 0.6);
    [self uploadFileDataRequest:ImageData];
    [setting_Table reloadData];
}
#pragma mark - Data
#pragma mark -- Data/我的基本信息
- (void)uploadFileDataRequest:(NSData *)imgData {
    [CustomHUD createHudCustomShowContent:@"请等待..."];
    NSString *user_Id = [Gobal loadAppSetting:BASE_KEY_memberId];
    //uploadType 1.用户头像上传
    NSDictionary *parameters = @{
                                 @"userId" : [Gobal isEmptyString:user_Id]?@"":user_Id,
                                 @"uploadType" :@"1",
                                 };
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    manager.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:
                                                         @"application/json",
                                                         @"text/html",
                                                         @"image/jpeg",
                                                         @"image/png",
                                                         @"application/octet-stream",
                                                         @"text/json",
                                                         @"text/plain",
                                                         nil];
    [manager POST:PUBLIC_URL(UPLOADFILE)  parameters:parameters constructingBodyWithBlock:^(id<AFMultipartFormData>  _Nonnull formData) {
        
        NSData *imageData = imgData;
        NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
        formatter.dateFormat =@"yyyyMMddHHmmss";
        NSString *str = [formatter stringFromDate:[NSDate date]];
        NSString *fileName = [NSString stringWithFormat:@"%@.jpg", str];
        [formData appendPartWithFileData:imageData
                                    name:@"file"
                                fileName:fileName
                                mimeType:@"image/jpeg"];
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nonnull responseObject) {
        NSLog(@"responseObject == %@",responseObject);
        if ([responseObject[@"status"] isEqualToString:@"100"]) {
            
            photo_url_Img = responseObject[@"data"] [@"url"];
            
            [CustomHUD createShowContent:responseObject[@"message"] hiddenTime:2.4];
            [setting_Table reloadData];
            
        }
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        [CustomHUD createShowContent:@"网络链接失败,请检查是否链接网络" hiddenTime:2.4];
    }];

}
#pragma mark -- Data/修改呢称
- (void)changenicknameDataRequest:(NSString *)nickName_str {
    
    if ([Gobal isEmptyString:nickName_str]) {
        [CustomHUD createShowContent:@"您的昵称不能为空" hiddenTime:2.4];
        return;
    }
    NSString *user_Id = [Gobal loadAppSetting:BASE_KEY_memberId];
    NSDictionary *parameters = @{
                                 @"userId" : [Gobal isEmptyString:user_Id]?@"":user_Id,
                                 @"nickName" : nickName_str
                                 };
    
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    manager.responseSerializer.acceptableContentTypes = [NSSet setWithObject:@"text/plain"];
    [manager POST:PUBLIC_URL(UPDATENICKNAME) parameters:parameters success:^(AFHTTPRequestOperation *operation,id responseObject) {
        NSLog(@"updateNickName_success: %@", responseObject);
        if ([responseObject[@"status"] isEqualToString:@"100"]) {
            
            [CustomHUD createShowContent:@"修改成功" hiddenTime:2.4];
        }
    }failure:^(AFHTTPRequestOperation *operation,NSError *error) {
        [CustomHUD createShowContent:@"网络链接失败,请检查是否链接网络" hiddenTime:2.4];
    }];
}
#pragma mark -- Event/back
-(void)popBack {
    self.navigationController.navigationBar.hidden = YES;
    [[AppDelegate getInstance].mainTabController showTabbarView];
    [[AppDelegate getInstance].CurNavController popToRootViewControllerAnimated:YES];
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}
@end
