//
//  ThreeViewController.m
//  MickyEasyCredit
//
//  Created by 张宁 on 16/10/26.
//  Copyright © 2016年 apple. All rights reserved.
//

#import "ThreeViewController.h"
#import "AFNetworking.h"
#import "AppDelegate.h"

#import "WXApi.h"

#import "customeTableOneCell.h"
#import "customerTableTwoCell.h"
#import "ExternalLinksViewController.h"

@interface ThreeViewController ()<UITableViewDelegate,UITableViewDataSource,UIActionSheetDelegate,WXApiDelegate,CustomeTableOneDelegate>
{
    UILabel *titleLabel;
    UITableView *customer_Table;
    UIButton *customer_Btn;
    UIButton *QQ_Btn;
    UIButton *WX_Btn;
    UIImageView *WX_imgV;
    
}
@end

@implementation ThreeViewController
@synthesize rootNavController;
- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil RootNavController:(UINavigationController *)Controller {
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        rootNavController = Controller;
    }
    return self;
}
- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    NAVIGATIONBAR_COLOR_STYLE(BUTTON_COLOR_NORMA,UIStatusBarStyleLightContent);
    
}
- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = BACKGROUND_COLOR;
    
    [self initData];
    [self initTable];
    [self initNavigate];
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
    titleLabel.text = @"客服中心";
    titleLabel.font = [UIFont systemFontOfSize:20.0];
    [navTitleView addSubview:titleLabel];
    self.navigationItem.titleView = navTitleView;
    self.navigationController.navigationBar.backgroundColor = [UIColor clearColor];
    
}
#pragma mark -- init/Table
- (void)initTable {
    customer_Table = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT) style:UITableViewStylePlain];
    customer_Table.delegate = self;
    customer_Table.dataSource = self;
    customer_Table.backgroundColor = BACKGROUND_COLOR;
    customer_Table.separatorStyle = UITableViewCellSeparatorStyleNone;
    [self.view addSubview:customer_Table];
}
#pragma mark - delegate
#pragma mark -- delegate/table
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 2;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    switch (section) {
        case 0:{
            return 1;
        }
            break;
        case 1:{
            return 4;
        }
            break;
        default:
            break;
    }
    return 3;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    switch (indexPath.section) {
        case 0:{
            return 240;
        }
            break;
        case 1:{
            return 45;
        }
            break;
        default:
            break;
    }
    return 45;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    switch (indexPath.section) {
        case 0:{
            static NSString *pool = @"onePool";
            customeTableOneCell *cell = [tableView dequeueReusableCellWithIdentifier:pool];
            if (!cell) {
                cell = [[customeTableOneCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:pool];
                cell.selectionStyle = UITableViewCellSelectionStyleNone;
                cell.delegate = self;
            }
            [cell setRecommended:nil];
            return cell;
        }
            break;
        case 1:{
            static NSString *twopool = @"twoPool";
            customerTableTwoCell *cell = [tableView dequeueReusableCellWithIdentifier:twopool];
            if (!cell) {
                cell = [[customerTableTwoCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:twopool];
            }
            NSArray *title_A = @[@"联系客服:021-51061914",@"微信:zxwd001",@"QQ:3479579307",@"帮助中心"];
            NSArray *image_A = @[@"customerService",@"weixin",@"QQ",@"hlep"];
            [cell setTitleLabel:title_A[indexPath.row] iconImage:image_A[indexPath.row] indexPathRow:indexPath.row];
            return cell;
        }
            break;
        default:
            break;
    }
    return nil;
    
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    switch (indexPath.section) {
        case 1:{
            switch (indexPath.row) {
                case 0:{
                    NSString *num = [[NSString alloc]initWithFormat:@"telprompt://%@",@"021-51061914"];
                    [[UIApplication sharedApplication] openURL:[NSURL URLWithString:num]]; //拨号
                }
                    break;
                case 1:{
                    UIPasteboard *pab = [UIPasteboard generalPasteboard];
                    NSString *string = @"zxwd001";
                    [pab setString:string];
                    NSURL *url = [NSURL URLWithString:@"weixin://"];
                    if([[UIApplication sharedApplication] canOpenURL:url]){
                        [[UIApplication sharedApplication] openURL:url];
                    } else {
                        UIAlertView*ale=[[UIAlertView alloc] initWithTitle:@"提示" message:@"您没有安装手机微信，请安装手机微信后重试，或用PC进行操作。" delegate:self cancelButtonTitle:nil otherButtonTitles:@"确定", nil];
                        [ale show];
                    }
                }
                    break;
                case 2:{
                    UIPasteboard *pab = [UIPasteboard generalPasteboard];
                    NSString *string = @"3479579307";
                    [pab setString:string];
                    NSURL *url = [NSURL URLWithString:@"mqq://"];
                    if([[UIApplication sharedApplication] canOpenURL:url]){
                        [[UIApplication sharedApplication] openURL:url];
                    } else {
                        UIAlertView*ale=[[UIAlertView alloc] initWithTitle:@"提示" message:@"您没有安装手机QQ，请安装手机QQ后重试，或用PC进行操作。" delegate:self cancelButtonTitle:nil otherButtonTitles:@"确定", nil];
                        [ale show];
                    }
                }
                    break;
                case 3:{
                    [[AppDelegate getInstance].mainTabController hideTabbarView];
                    ExternalLinksViewController *ELVC = [[ExternalLinksViewController alloc]init];
                    ELVC.class_name = @"帮助中心";
                    ELVC.externalLink_url = WEBURL(WEB_HELP);
                    ELVC.isRooterEnter = YES;
                    ELVC.is_show_header = YES;
                    [[AppDelegate getInstance].CurNavController pushViewController:ELVC animated:YES];
                }
                    break;
                default:
                    break;
            }
        }
            break;
            
        default:
            break;
    }
}
#pragma mark -- delegate/CustomeTableOneDelegate
- (void)longPressQRcodeAccordingToTheRecognition {
//    UIActionSheet *sheet = [[UIActionSheet alloc]initWithTitle:@"温馨提示" delegate:self cancelButtonTitle:@"取消" destructiveButtonTitle:nil otherButtonTitles:@"识别二维码", nil];
//    [sheet showInView:customer_Table];
}
- (void)actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex {
    
    JumpToBizProfileReq *req = [JumpToBizProfileReq new];
    req.username = @"gh_6e62eb3e461f";
    req.profileType = WXBizProfileType_Normal;
    req.extMsg = @"";
    [WXApi sendReq:req];
    
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

@end
