//
//  AuthenticationViewController.m
//  MickyEasyCredit
//
//  Created by 张宁 on 2017/4/8.
//  Copyright © 2017年 apple. All rights reserved.
//

#import "AuthenticationViewController.h"
#import "AFNetworking.h"
#import "AppDelegate.h"

#import "AuthenticationModel.h"
#import "AuthenticationTableCell.h"
#import "ExternalLinksViewController.h"
#import "PhotoCertificationViewController.h"

@interface AuthenticationViewController ()<UITableViewDelegate,UITableViewDataSource,UITextFieldDelegate>
{
    UILabel *titleLabel;
    NSMutableArray *data_A;
    UITableView *Authentication_Table;
    
    UIView *header_View;
    UIImageView *header_imgV;
    
}
@property(nonatomic,strong)AuthenticationModel *authenticateModel;
@end

@implementation AuthenticationViewController

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    self.navigationController.navigationBar.hidden = NO;
    NAVIGATIONBAR_COLOR_STYLE(BUTTON_COLOR_NORMA,UIStatusBarStyleLightContent);
    //查看资料信息
    [self memberDataRequest];
}
- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = BACKGROUND_COLOR;
    
    [self initData];
    [self initNavigate];
    [self initTable];
}
#pragma mark - init
#pragma mark -- init/Data
- (void)initData {
    //查看资料信息
    [self memberDataRequest];
}
#pragma mark -- init/navigate
- (void)initNavigate {
    
    UIView *navTitleView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 150, 30)];
    titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 5, navTitleView.frame.size.width-5, 20)];
    titleLabel.textAlignment = NSTextAlignmentCenter;
    titleLabel.textColor = [UIColor whiteColor];
    titleLabel.text = @"我的资料";
    titleLabel.font = [UIFont systemFontOfSize:20.0];
    [navTitleView addSubview:titleLabel];
    self.navigationItem.titleView = navTitleView;
    self.navigationController.navigationBar.backgroundColor = [UIColor clearColor];
    
    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    button.frame = CGRectMake(0,0,53,44);
    button.backgroundColor = [UIColor clearColor];
    [button setImage:[UIImage imageNamed:@"navbar_back"] forState:UIControlStateNormal];
    [button setImageEdgeInsets:UIEdgeInsetsMake(0, -40, 0, 0)];
    [button addTarget:self action:@selector(popBack) forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem *barButtonItem = [[UIBarButtonItem alloc] initWithCustomView:button];
    [self.navigationItem setLeftBarButtonItem:barButtonItem];
    
}
#pragma mark -- init/Table
- (void)initTable {
    
    Authentication_Table = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT-64) style:UITableViewStylePlain];
    Authentication_Table.delegate = self;
    Authentication_Table.dataSource = self;
    Authentication_Table.showsVerticalScrollIndicator = NO;
    Authentication_Table.showsHorizontalScrollIndicator = NO;
    Authentication_Table.backgroundColor = BACKGROUND_COLOR;
    Authentication_Table.separatorStyle = UITableViewCellSeparatorStyleNone;
    [self.view addSubview:Authentication_Table];
    
    [self initFooter];
}
#pragma mark -- init/Footer
- (void)initFooter {
    
    UIView *show = [[UIView alloc]init];
    show.frame = CGRectMake(0, 0, SCREEN_WIDTH, 80);
    show.backgroundColor = [UIColor clearColor];
    Authentication_Table.tableFooterView = show;
    
    UILabel *content_label = [[UILabel alloc]init];
    content_label.font = [UIFont systemFontOfSize:13];
//    content_label.text = @"*提示：个人信息、教育背景、照片认证、联系人信息、学信网认证、手机认证必须认证通过才能借款;互联网认证是非必需认证项,但互联网认证成功能加快你的借款审核。";
    content_label.text = @"*提示：个人信息、工作单位、照片认证、联系人信息、手机认证必须认证通过才能借款;互联网认证是非必需认证项,但互联网认证成功能加快你的借款审核。";
    content_label.textColor = TITLE_FONT_COLOR;
    content_label.textAlignment = NSTextAlignmentLeft;
    content_label.backgroundColor = [UIColor clearColor];
    content_label.frame = CGRectMake(10, 5, SCREEN_WIDTH-20, 60);
    content_label.numberOfLines = 0;
    [show addSubview:content_label];
}
#pragma mark - delegate
#pragma mark -- delegate/table
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 6;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 44;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *oneCell = @"oneCell";
    AuthenticationTableCell *cell = [tableView dequeueReusableCellWithIdentifier:oneCell];
    if (!cell) {
        cell = [[AuthenticationTableCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:oneCell];
    }
//    NSArray *holder_A = @[@"个人信息",@"教育背景",@"照片认证",@"联系人信息",@"学信网认证",@"手机认证",@"互联网认证"];
    NSArray *holder_A = @[@"个人信息",@"工作单位",@"照片认证",@"联系人信息",@"手机认证",@"互联网认证"];
    [cell setTitleLabel:holder_A[indexPath.row] indexPathRow:indexPath.row authenticationStr:_authenticateModel];
    return cell;
}
- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    return [Gobal drawSolidLinePointX:0 PointY:0 lineW:SCREEN_WIDTH lineH:20 lineColor:@[@"240",@"240",@"240"] lineAlpha:1.0];
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    switch (indexPath.row) {
        case 0:{//个人信息
            [[AppDelegate getInstance].mainTabController hideTabbarView];
            ExternalLinksViewController *ELVC = [[ExternalLinksViewController alloc]init];
            ELVC.class_name = @"个人信息";
            ELVC.externalLink_url = [NSString stringWithFormat:@"%@?userId=%@",PUBLIC_WEBURL(WEB_PERSONAL),[Gobal loadAppSetting:BASE_KEY_memberId]];
            [[AppDelegate getInstance].CurNavController pushViewController:ELVC animated:YES];
        }
            break;
        case 1:{//教育背景
            [[AppDelegate getInstance].mainTabController hideTabbarView];
            ExternalLinksViewController *ELVC = [[ExternalLinksViewController alloc]init];
            ELVC.class_name = @"工作单位";
            ELVC.externalLink_url = [NSString stringWithFormat:@"%@?userId=%@",PUBLIC_WEBURL(WEB_EDUCATION),[Gobal loadAppSetting:BASE_KEY_memberId]];
            [[AppDelegate getInstance].CurNavController pushViewController:ELVC animated:YES];
        }
            break;
        case 2:{//照片认证
            [[AppDelegate getInstance].mainTabController hideTabbarView];
            PhotoCertificationViewController *PCVC = [[PhotoCertificationViewController alloc]init];
            [[AppDelegate getInstance].CurNavController pushViewController:PCVC animated:YES];
        }
            break;
        case 3:{//联系人信息
            [[AppDelegate getInstance].mainTabController hideTabbarView];
            ExternalLinksViewController *ELVC = [[ExternalLinksViewController alloc]init];
            ELVC.class_name = @"联系人信息";
            ELVC.externalLink_url = [NSString stringWithFormat:@"%@?userId=%@",PUBLIC_WEBURL(WEB_CONTACT),[Gobal loadAppSetting:BASE_KEY_memberId]];
            [[AppDelegate getInstance].CurNavController pushViewController:ELVC animated:YES];
        }
            break;
//        case 4:{//学信网认证
//            [[AppDelegate getInstance].mainTabController hideTabbarView];
//            ExternalLinksViewController *ELVC = [[ExternalLinksViewController alloc]init];
//            ELVC.class_name = @"学信网认证";
//            if ([_authenticateModel.learnStatus isEqualToString:@"1"]) {
//                ELVC.externalLink_url = [NSString stringWithFormat:@"%@",PUBLIC_WEBURL(WEB_TOSUCCESS)];
//            }else{
//                ELVC.externalLink_url = [NSString stringWithFormat:@"%@?userId=%@",PUBLIC_WEBURL(WEB_TOXUEXINCERT),[Gobal loadAppSetting:BASE_KEY_memberId]];
//            }
//            [[AppDelegate getInstance].CurNavController pushViewController:ELVC animated:YES];
//            
//        }
//            break;
        case 4:{//手机认证
            [[AppDelegate getInstance].mainTabController hideTabbarView];
            ExternalLinksViewController *ELVC = [[ExternalLinksViewController alloc]init];
            ELVC.class_name = @"手机认证";
            if ([_authenticateModel.phoneStatus isEqualToString:@"1"]) {
                ELVC.externalLink_url = [NSString stringWithFormat:@"%@",PUBLIC_WEBURL(WEB_TOSUCCESS)];
            }else{
                ELVC.externalLink_url = [NSString stringWithFormat:@"%@?userId=%@",PUBLIC_WEBURL(WEB_PHONECRET),[Gobal loadAppSetting:BASE_KEY_memberId]];
            }
            [[AppDelegate getInstance].CurNavController pushViewController:ELVC animated:YES];
            
        }
            break;
        case 5:{//互联网认证
            [[AppDelegate getInstance].mainTabController hideTabbarView];
            ExternalLinksViewController *ELVC = [[ExternalLinksViewController alloc]init];
            ELVC.class_name = @"互联网认证";
            if ([_authenticateModel.internetStatus isEqualToString:@"1"]) {
                ELVC.externalLink_url = [NSString stringWithFormat:@"%@",PUBLIC_WEBURL(WEB_TOSUCCESS)];
            }else{
                ELVC.externalLink_url = [NSString stringWithFormat:@"%@?userId=%@",PUBLIC_WEBURL(WEB_JDCERT),[Gobal loadAppSetting:BASE_KEY_memberId]];
            }
            [[AppDelegate getInstance].CurNavController pushViewController:ELVC animated:YES];
        }
            break;
        default:
            break;
    }

}
#pragma mark - Data
#pragma mark -- Data/资料认证
- (void)memberDataRequest {
    
    NSString *user_Id = [Gobal loadAppSetting:BASE_KEY_memberId];
    NSDictionary *parameters = @{
                                 @"userId" : [Gobal isEmptyString:user_Id]?@"":user_Id,
                                 };
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    manager.responseSerializer.acceptableContentTypes = [NSSet setWithObject:@"text/plain"];
    [manager POST:PUBLIC_URL(MEMBERDATA) parameters:parameters success:^(AFHTTPRequestOperation *operation,id responseObject) {
        NSLog(@"memberData_success: %@", responseObject);
        if ([responseObject[@"status"] isEqualToString:@"100"]) {

            _authenticateModel = [AuthenticationModel dataWithJsonDictionary:responseObject[@"data"]];
            
            [Authentication_Table reloadData];
            
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
