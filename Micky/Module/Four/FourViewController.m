//
//  FourViewController.m
//  MickyEasyCredit
//
//  Created by 张宁 on 16/10/26.
//  Copyright © 2016年 apple. All rights reserved.
//

#import "FourViewController.h"
#import "AppDelegate.h"
#import "AFNetworking.h"
#import "UIImageView+WebCache.h" 

#import "UserInfoModel.h"
#import "AuthenticationModel.h"
#import "ShareViewController.h"
#import "LoginViewController.h"
#import "BorrowViewController.h"
#import "SettingViewController.h"
#import "AuthenticationViewController.h"
#import "ExternalLinksViewController.h"

#import "BankViewController.h"
#import "CouponViewController.h"



@implementation UserTableOneCell
@synthesize BGView;
@synthesize left_label;
@synthesize left_imageV;
@synthesize right_imageV;
- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        self.contentView.backgroundColor = BASE_COLOR_LINE;
        BGView = [[UIView alloc]init];
        BGView.backgroundColor = [UIColor whiteColor];
        BGView.frame = CGRectMake(0, 0, SCREEN_WIDTH, 43.5);
        [self.contentView addSubview:BGView];
        
        left_imageV = [[UIImageView alloc]init];
        left_imageV.image = [UIImage imageNamed:@""];
        left_imageV.frame = CGRectMake(10, (43.5-16)/2.0, 16, 16);
        [BGView addSubview:left_imageV];
        
        left_label = [[UILabel alloc]init];
        left_label.frame = CGRectMake(36, 0, SCREEN_WIDTH-140, 44.5);
        left_label.backgroundColor = [UIColor clearColor];
        left_label.text = @"--";
        left_label.textColor = WORD_FONT_COLOR;
        left_label.font = [UIFont systemFontOfSize:15];
        left_label.textAlignment = NSTextAlignmentLeft;
        [BGView addSubview:left_label];
        
        right_imageV = [[UIImageView alloc]init];
        right_imageV.image = [UIImage imageNamed:@"my_right"];
        right_imageV.frame = CGRectMake(SCREEN_WIDTH-26, (44.5-16)/2.0, 16, 16);
        [BGView addSubview:right_imageV];

    }
    return self;
}
- (void)setOneDataImage:(NSInteger)index_image labelData:(NSString *)labelTitle {
    NSArray *image_A = @[@"my_data_icon",@"my_borrow_icon",@"my_query_icon",@"my_reimburse_icon",@"user_bank_icon",@"my_coupon_icon",@"my_share_icon"];
    left_label.text = labelTitle;
    switch (index_image) {
        case 0:{
            left_imageV.frame = CGRectMake(10, (43.5-18)/2.0, 14, 18);
            left_imageV.image = [UIImage imageNamed:image_A[index_image]];
        }
            break;
        case 1:{
            left_imageV.frame = CGRectMake(10, (43.5-15)/2.0, 15, 15);
            left_imageV.image = [UIImage imageNamed:image_A[index_image]];
        }
            break;
        case 2:{
            left_imageV.frame = CGRectMake(10, (43.5-16)/2.0, 16, 16);
            left_imageV.image = [UIImage imageNamed:image_A[index_image]];
        }
            break;
        case 3:{
            left_imageV.frame = CGRectMake(10, (43.5-16)/2.0, 16, 16);
            left_imageV.image = [UIImage imageNamed:image_A[index_image]];
        }
            break;
        case 4:{
            left_imageV.frame = CGRectMake(10, (43.5-12)/2.0, 17, 13);
            left_imageV.image = [UIImage imageNamed:image_A[index_image]];
        }
            break;
        case 5:{
            left_imageV.frame = CGRectMake(10, (43.5-12)/2.0, 17, 13);
            left_imageV.image = [UIImage imageNamed:image_A[index_image]];
        }
            break;
        case 6:{
            left_imageV.frame = CGRectMake(10, (43.5-16)/2.0, 16, 16);
            left_imageV.image = [UIImage imageNamed:image_A[index_image]];
        }
            break;
        default:
            break;
    }
    
}

@end


@implementation UserTableTwoCell
@synthesize BGView;
@synthesize left_label;
@synthesize left_imageV;
@synthesize right_imageV;
- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        self.contentView.backgroundColor = BASE_COLOR_LINE;
        BGView = [[UIView alloc]init];
        BGView.backgroundColor = [UIColor whiteColor];
        BGView.frame = CGRectMake(0, 0, SCREEN_WIDTH, 44.5);
        [self.contentView addSubview:BGView];
        
        left_imageV = [[UIImageView alloc]init];
        left_imageV.image = [UIImage imageNamed:@""];
        left_imageV.frame = CGRectMake(10, (45.5-16)/2.0, 16, 16);
        [BGView addSubview:left_imageV];
        
        left_label = [[UILabel alloc]init];
        left_label.frame = CGRectMake(32, 0, SCREEN_WIDTH-140, 44.5);
        left_label.backgroundColor = [UIColor clearColor];
        left_label.text = @"--";
        left_label.textColor = WORD_FONT_COLOR;
        left_label.font = [UIFont systemFontOfSize:15];
        left_label.textAlignment = NSTextAlignmentLeft;
        [BGView addSubview:left_label];
        
        right_imageV = [[UIImageView alloc]init];
        right_imageV.image = [UIImage imageNamed:@"my_right"];
        right_imageV.frame = CGRectMake(SCREEN_WIDTH-26, (44.5-16)/2.0, 16, 16);
        [BGView addSubview:right_imageV];
        
    }
    return self;
}
- (void)setTwoDataImage:(NSString *)imageName labelData:(NSString *)labelTitle {
    left_imageV.image = [UIImage imageNamed:imageName];
    left_label.text = labelTitle;
}
@end

@implementation UserTableThreeCell
@synthesize BGView;
@synthesize left_label;
@synthesize left_imageV;
@synthesize right_imageV;
- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        self.contentView.backgroundColor = BASE_COLOR_LINE;
        BGView = [[UIView alloc]init];
        BGView.backgroundColor = [UIColor whiteColor];
        BGView.frame = CGRectMake(0, 0, SCREEN_WIDTH, 44.5);
        [self.contentView addSubview:BGView];
        
        left_imageV = [[UIImageView alloc]init];
        left_imageV.image = [UIImage imageNamed:@""];
        left_imageV.frame = CGRectMake(10, (45.5-16)/2.0, 16, 16);
        [BGView addSubview:left_imageV];
        
        left_label = [[UILabel alloc]init];
        left_label.frame = CGRectMake(32, 0, SCREEN_WIDTH-140, 44.5);
        left_label.backgroundColor = [UIColor clearColor];
        left_label.text = @"--";
        left_label.textColor = WORD_FONT_COLOR;
        left_label.font = [UIFont systemFontOfSize:15];
        left_label.textAlignment = NSTextAlignmentLeft;
        [BGView addSubview:left_label];
        
        right_imageV = [[UIImageView alloc]init];
        right_imageV.image = [UIImage imageNamed:@"my_right"];
        right_imageV.frame = CGRectMake(SCREEN_WIDTH-26, (44.5-16)/2.0, 16, 16);
        [BGView addSubview:right_imageV];
        
    }
    return self;
}
- (void)setThreeDataImage:(NSString *)imageName labelData:(NSString *)labelTitle {
    left_imageV.image = [UIImage imageNamed:imageName];
    left_label.text = labelTitle;
}
@end

#pragma mark - 
#pragma mark -

@interface FourViewController ()<UITableViewDelegate,UITableViewDataSource,UIAlertViewDelegate>
{
    UITableView *myTable;
    UIImageView *header_imageV;
    UITapGestureRecognizer *tapGestureRecognizer;
    
    NSString *phone_number;  //客服电话
    NSString *phone_string;
    NSString *segmentation_str;
    NSString *about_us_url;
    
    UILabel *titleLabel;
    UILabel *nameLabel;
    UILabel *bonusLabel;
    UILabel *creditLabel;
    UILabel *money_label;
    UILabel *lines_label;
    UIButton *setting_Btn;
    UIImageView *header_photo;
    UserInfoModel *Info_Model;

}
@property(nonatomic,strong)AuthenticationModel *authenticateModel;
@end

@implementation FourViewController
@synthesize rootNavController;
- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil RootNavController:(UINavigationController *)Controller {
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        rootNavController = Controller;
    }
    return self;
}
- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
    self.navigationController.navigationBar.hidden = YES;
    self.navigationController.view.backgroundColor = [UIColor whiteColor];
    [[UIApplication sharedApplication] setStatusBarStyle:UIStatusBarStyleLightContent];
    [self myBasicInformationDataRequest];
}
- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = BACKGROUND_COLOR;
    self.navigationController.navigationBar.hidden = YES;
    self.navigationController.view.backgroundColor = [UIColor whiteColor];
    [[UIApplication sharedApplication] setStatusBarStyle:UIStatusBarStyleLightContent];

    [self initData];
    [self initHeader];
}
#pragma mark - init
#pragma mark -- init/Data
- (void)initData {
    [self myBasicInformationDataRequest];
}
#pragma mark -- init/header
- (void)initHeader {
    
    header_imageV = [[UIImageView alloc]init];
    header_imageV.frame = CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_WIDTH*(12/25.0));
    header_imageV.image = [UIImage imageNamed:@"my_header_photo"];
    header_imageV.contentMode = UIViewContentModeScaleAspectFit;
    [self.view addSubview:header_imageV];
    
    //设置
    setting_Btn = [UIButton buttonWithType:UIButtonTypeCustom];
    setting_Btn.frame = CGRectMake(SCREEN_WIDTH-45, 30, 24, 24);
    setting_Btn.backgroundColor = [UIColor clearColor];
    [setting_Btn setBackgroundImage:[UIImage imageNamed:@"setting"] forState:UIControlStateNormal];
    [setting_Btn addTarget:self action:@selector(settingsBtnAction) forControlEvents:UIControlEventTouchUpInside];
    [header_imageV addSubview:setting_Btn];

    //头像
    header_photo = [[UIImageView alloc]init];
    header_photo.image = [UIImage imageNamed:@"my_photo"];
    if (SCREEN_WIDTH>350) {
        header_photo.frame = CGRectMake((SCREEN_WIDTH-90)/2.0, 40, 90, 90);
    }else {
        header_photo.frame = CGRectMake((SCREEN_WIDTH-90)/2.0, 30, 90, 90);
    }
    header_photo.layer.cornerRadius = header_photo.frame.size.height/2.0;
    header_photo.layer.masksToBounds = YES;
    [header_imageV addSubview:header_photo];
    header_imageV.userInteractionEnabled = YES;
    header_photo.userInteractionEnabled = YES;

    tapGestureRecognizer = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(clickPhotoAction)];
    [header_photo addGestureRecognizer:tapGestureRecognizer];

    //用户名
    nameLabel = [[UILabel alloc]init];
    nameLabel.text = @"--";
    if (SCREEN_WIDTH>350) {
        nameLabel.frame = CGRectMake(50, CGRectGetMaxY(header_photo.frame)+10, SCREEN_WIDTH-100, 20);
    }else {
        nameLabel.frame = CGRectMake(50, CGRectGetMaxY(header_photo.frame), SCREEN_WIDTH-100, 20);
    }
    nameLabel.backgroundColor = [UIColor clearColor];
    nameLabel.font = [UIFont systemFontOfSize:15];
    nameLabel.textColor = [UIColor whiteColor];
    nameLabel.textAlignment = NSTextAlignmentCenter;
    [header_imageV addSubview:nameLabel];

    
//    UIButton *bonus_Btn = [UIButton buttonWithType:UIButtonTypeCustom];
//    bonus_Btn.frame = CGRectMake(0, CGRectGetHeight(header_imageV.frame)-55, SCREEN_WIDTH/2.0, 55);
//    [bonus_Btn addTarget:self action:@selector(myCouponBtnAction) forControlEvents:UIControlEventTouchUpInside];
//    [header_imageV addSubview:bonus_Btn];
//    
//    //我的奖金
//    bonusLabel = [[UILabel alloc]init];
//    bonusLabel.text = @"我的优惠券";
//    if (SCREEN_WIDTH>350) {
//        bonusLabel.frame = CGRectMake(0, CGRectGetHeight(header_imageV.frame)-55, SCREEN_WIDTH/2.0, 55);
//    }else {
//        bonusLabel.frame = CGRectMake(0, CGRectGetHeight(header_imageV.frame)-50, SCREEN_WIDTH/2.0, 50);
//    }
//    bonusLabel.backgroundColor = [UIColor clearColor];
//    bonusLabel.font = [UIFont systemFontOfSize:18];
//    bonusLabel.textColor = [UIColor whiteColor];
//    bonusLabel.textAlignment = NSTextAlignmentCenter;
//    [header_imageV addSubview:bonusLabel];
    
//    NSMutableAttributedString *title = [[NSMutableAttributedString alloc] initWithString:@"我的免息券"];
//    NSRange titleRange = {0,[title length]};
//    [title addAttribute:NSUnderlineStyleAttributeName value:[NSNumber numberWithInteger:NSUnderlineStyleSingle] range:titleRange];
//    bonusLabel.attributedText = title;
    
    
//    //信用额度
//    creditLabel = [[UILabel alloc]init];
//    creditLabel.text = @"信用额度";
//    creditLabel.frame = CGRectMake(SCREEN_WIDTH/2.0, CGRectGetHeight(header_imageV.frame)-25, SCREEN_WIDTH/2.0, 20);
//    creditLabel.backgroundColor = [UIColor clearColor];
//    creditLabel.font = [UIFont systemFontOfSize:13];
//    creditLabel.textColor = [UIColor whiteColor];
//    creditLabel.textAlignment = NSTextAlignmentCenter;
//    [header_imageV addSubview:creditLabel];

//    //我的奖金
//    money_label = [[UILabel alloc]init];
//    if (SCREEN_WIDTH>350) {
//        money_label.font = [UIFont systemFontOfSize:24];
//        money_label.frame = CGRectMake(CGRectGetMinX(bonusLabel.frame), CGRectGetHeight(header_imageV.frame)-55, CGRectGetWidth(bonusLabel.frame), 30);
//    }else {
//        money_label.font = [UIFont systemFontOfSize:18];
//        money_label.frame = CGRectMake(CGRectGetMinX(bonusLabel.frame), CGRectGetHeight(header_imageV.frame)-50, CGRectGetWidth(bonusLabel.frame), 25);
//    }
//    money_label.textColor = [UIColor whiteColor];
//    money_label.textAlignment = NSTextAlignmentCenter;
//    money_label.backgroundColor = [UIColor clearColor];
//    [header_imageV addSubview:money_label];

//    //我的额度
//    lines_label = [[UILabel alloc]init];
//    if (SCREEN_WIDTH>350) {
//        lines_label.font = [UIFont systemFontOfSize:24];
//        lines_label.frame = CGRectMake(CGRectGetMinX(creditLabel.frame), CGRectGetHeight(header_imageV.frame)-55, CGRectGetWidth(creditLabel.frame), 30);
//    }else {
//        lines_label.font = [UIFont systemFontOfSize:18];
//        lines_label.frame = CGRectMake(CGRectGetMinX(creditLabel.frame), CGRectGetHeight(header_imageV.frame)-50, CGRectGetWidth(creditLabel.frame), 25);
//    }
//    lines_label.textColor = [UIColor whiteColor];
//    lines_label.textAlignment = NSTextAlignmentCenter;
//    lines_label.backgroundColor = [UIColor clearColor];
//    [header_imageV addSubview:lines_label];

//    NSString *money_str = @"0元";
//    NSMutableAttributedString *money_AS = [[NSMutableAttributedString alloc] initWithString:money_str];
//    NSRange titleRange = {[money_AS length]-1,1};
//    [money_AS addAttribute:NSFontAttributeName value:[UIFont systemFontOfSize:10] range:titleRange];
//    money_label.attributedText = money_AS;
    
//    NSString *lines_AS = @"0.00元";
//    NSMutableAttributedString *lines_str = [[NSMutableAttributedString alloc] initWithString:lines_AS];
//    NSRange linesRange = {[lines_AS length]-1,1};
//    [lines_str addAttribute:NSFontAttributeName value:[UIFont systemFontOfSize:10] range:linesRange];
//    lines_label.attributedText = lines_str;

    [self initTable];
}
#pragma mark -- init/Table
- (void)initTable {

    myTable = [[UITableView alloc]initWithFrame:CGRectMake(0, CGRectGetMaxY(header_imageV.frame), SCREEN_WIDTH, SCREEN_HEIGHT-CGRectGetMaxY(header_imageV.frame)-50) style:UITableViewStylePlain];
    myTable.delegate = self;
    myTable.dataSource = self;
    myTable.showsVerticalScrollIndicator = NO;
    myTable.showsHorizontalScrollIndicator = NO;
    myTable.backgroundColor = BACKGROUND_COLOR;
    myTable.separatorStyle = UITableViewCellSeparatorStyleNone;
    [self.view addSubview:myTable];
}
#pragma mark - delegate
#pragma mark -- delegate/Table
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 7;
}
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    return 10;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 44;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    static NSString *one = @"oneCell";
    UserTableOneCell *cell = [tableView dequeueReusableCellWithIdentifier:one];
    if (!cell) {
        cell = [[UserTableOneCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:one];
    }
    if (indexPath.row == 1) {
        cell.left_imageV.frame = CGRectMake(10, (44.5-15)/2.0, 20, 15);
    }
    NSArray *title_B= @[@"资料认证",@"我要借款",@"借款查询",@"我要还款",@"我的银行卡",@"我的优惠券",@"分享获优惠券"];
    [cell setOneDataImage:indexPath.row labelData:title_B[indexPath.row]];
    return cell;

}
- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    UIView *view = [[UIView alloc]init];
    view.backgroundColor = BACKGROUND_COLOR;
    return view;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    if ([Gobal isEmptyString:[Gobal loadAppSetting:BASE_KEY_memberId]]) {
        [[AppDelegate getInstance] callLoginView:NO];
        return;
    }
    switch (indexPath.row) {
        case 0:{//资料认证
            [self lockUserDataRequest];
        }
            break;
        case 1:{//我要借款
            [self memberDataRequest];
        }
            break;
        case 2:{//借款查询
            [[AppDelegate getInstance].mainTabController hideTabbarView];
            ExternalLinksViewController *ELVC = [[ExternalLinksViewController alloc]init];
            ELVC.class_name = @"借款查询";
            ELVC.isRooterEnter = YES;
            ELVC.externalLink_url = [NSString stringWithFormat:@"%@?userId=%@",PUBLIC_WEBURL(WEB_TOLOAN),[Gobal loadAppSetting:BASE_KEY_memberId]];
            [[AppDelegate getInstance].CurNavController pushViewController:ELVC animated:YES];
        }
            break;
        case 3:{//我要还款
            [[AppDelegate getInstance].mainTabController hideTabbarView];
            ExternalLinksViewController *ELVC = [[ExternalLinksViewController alloc]init];
            ELVC.class_name = @"我要还款";
            ELVC.isRooterEnter = YES; 
            ELVC.externalLink_url = [NSString stringWithFormat:@"%@?userId=%@",PUBLIC_WEBURL(WEB_TOREPAYMENT),[Gobal loadAppSetting:BASE_KEY_memberId]];
            [[AppDelegate getInstance].CurNavController pushViewController:ELVC animated:YES];
        }
            break;
        case 4:{//我的银行卡
            
            [[AppDelegate getInstance].mainTabController hideTabbarView];
            BankViewController *bvc = [[BankViewController alloc]init];
            [[AppDelegate getInstance].CurNavController pushViewController:bvc animated:YES];
        }
            break;
        case 5:{//我的优惠券
            [[AppDelegate getInstance].mainTabController hideTabbarView];
            CouponViewController *bvc = [[CouponViewController alloc]init];
            [[AppDelegate getInstance].CurNavController pushViewController:bvc animated:YES];
        }
            break;
        case 6:{//分享获取现金奖励
            [[AppDelegate getInstance].mainTabController hideTabbarView];
            ShareViewController *avc = [[ShareViewController alloc]init];
            [[AppDelegate getInstance].CurNavController pushViewController:avc animated:YES];
        }
            break;
        default:
            break;
    }
}

#pragma mark - Event
#pragma mark -- Event/设置
- (void)settingsBtnAction {
    if ([Gobal isEmptyString:[Gobal loadAppSetting:BASE_KEY_memberId]]) {
        [[AppDelegate getInstance] callLoginView:NO];
        return;
    }
    [[AppDelegate getInstance].mainTabController hideTabbarView];
    SettingViewController *settingVC = [[SettingViewController alloc]init];
    settingVC.photo_url = Info_Model.faceImg;
    settingVC.phone_str = Info_Model.phone;
    settingVC.name_str = Info_Model.name;
    [[AppDelegate getInstance].CurNavController pushViewController:settingVC animated:YES];
}
#pragma mark -- Event/点击图像
- (void)clickPhotoAction {
    
    if ([Gobal isEmptyString:[Gobal loadAppSetting:BASE_KEY_memberId]]) {
        [[AppDelegate getInstance] callLoginView:NO];
        return;
    }
    [[AppDelegate getInstance].mainTabController hideTabbarView];
    SettingViewController *settingVC = [[SettingViewController alloc]init];
    settingVC.photo_url = Info_Model.faceImg;
    settingVC.phone_str = Info_Model.phone;
    settingVC.name_str = Info_Model.name;
    [[AppDelegate getInstance].CurNavController pushViewController:settingVC animated:YES];
}
#pragma mark -- Event/我的优惠券
- (void)myCouponBtnAction {
    [[AppDelegate getInstance].mainTabController hideTabbarView];
    ExternalLinksViewController *ELVC = [[ExternalLinksViewController alloc]init];
    ELVC.class_name = @"我的优惠券";
    ELVC.externalLink_url = [NSString stringWithFormat:@"%@?userId=%@",PUBLIC_WEBURL(WEB_COUPON),[Gobal loadAppSetting:BASE_KEY_memberId]];
    ELVC.isRooterEnter = YES;
    [[AppDelegate getInstance].CurNavController pushViewController:ELVC animated:YES];

}
#pragma mark - Data
#pragma mark -- Data/我的基本信息
- (void)myBasicInformationDataRequest {
    
    NSString *user_Id = [Gobal loadAppSetting:BASE_KEY_memberId];
    NSDictionary *parameters = @{
                                 @"userId" : [Gobal isEmptyString:user_Id]?@"":user_Id,
                                 };
    
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    manager.responseSerializer.acceptableContentTypes = [NSSet setWithObject:@"text/plain"];
    [manager POST:PUBLIC_URL(USERMESSAGE) parameters:parameters success:^(AFHTTPRequestOperation *operation,id responseObject) {
        NSLog(@"userMessage_success: %@", responseObject);
        if ([responseObject[@"status"] isEqualToString:@"100"]) {
            
            Info_Model = [UserInfoModel dataWithJsonDictionary:responseObject[@"data"]];
            [Gobal saveAppSetting:Info_Model.faceImg Key:BASE_KEY_faceImg];
            [Gobal saveAppSetting:Info_Model.name Key:BASE_KEY_name];
            
            [header_photo sd_setImageWithURL:[NSURL URLWithString:Info_Model.faceImg] placeholderImage:[UIImage imageNamed:@"my_photo"]];
            nameLabel.text = [Gobal isEmptyString:Info_Model.name]?@"--":Info_Model.name;

            NSString *money_str = [NSString stringWithFormat:@"%@元",[Gobal isEmptyString:Info_Model.bonusAmout]?@"0":Info_Model.bonusAmout];
            NSMutableAttributedString *money_AS = [[NSMutableAttributedString alloc] initWithString:money_str];
            NSRange titleRange = {[money_AS length]-1,1};
            [money_AS addAttribute:NSFontAttributeName value:[UIFont systemFontOfSize:10] range:titleRange];
            money_label.attributedText = money_AS;
            
            NSString *lines_AS = [NSString stringWithFormat:@"%@元",[Gobal isEmptyString:Info_Model.creditesFee]?@"0":Info_Model.creditesFee];
            NSMutableAttributedString *lines_str = [[NSMutableAttributedString alloc] initWithString:lines_AS];
            NSRange linesRange = {[lines_AS length]-1,1};
            [lines_str addAttribute:NSFontAttributeName value:[UIFont systemFontOfSize:10] range:linesRange];
            lines_label.attributedText = lines_str;

            [myTable reloadData];
        }else {
            
            [header_photo sd_setImageWithURL:[NSURL URLWithString:@""] placeholderImage:[UIImage imageNamed:@"my_photo"]];
            nameLabel.text = @"--";
            
            NSString *money_str = [NSString stringWithFormat:@"%@元",@"0"];
            NSMutableAttributedString *money_AS = [[NSMutableAttributedString alloc] initWithString:money_str];
            NSRange titleRange = {[money_AS length]-1,1};
            [money_AS addAttribute:NSFontAttributeName value:[UIFont systemFontOfSize:10] range:titleRange];
            money_label.attributedText = money_AS;
            
            NSString *lines_AS = [NSString stringWithFormat:@"%@元",@"0"];
            NSMutableAttributedString *lines_str = [[NSMutableAttributedString alloc] initWithString:lines_AS];
            NSRange linesRange = {[lines_AS length]-1,1};
            [lines_str addAttribute:NSFontAttributeName value:[UIFont systemFontOfSize:10] range:linesRange];
            lines_label.attributedText = lines_str;
            
            [myTable reloadData];
        }
        
    }failure:^(AFHTTPRequestOperation *operation,NSError *error) {
        [CustomHUD createShowContent:@"网络链接失败,请检查是否链接网络" hiddenTime:2.4];
    }];
    
}
#pragma mark -- Data/资料判断
- (void)lockUserDataRequest {
    if ([Gobal isEmptyString:[Gobal loadAppSetting:BASE_KEY_memberId]]) {
        [[AppDelegate getInstance] callLoginView:NO];
        return;
    }
    
    NSString *user_Id = [Gobal loadAppSetting:BASE_KEY_memberId];
    NSDictionary *parameters = @{
                                 @"userId" : [Gobal isEmptyString:user_Id]?@"":user_Id,
                                 };
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    manager.responseSerializer.acceptableContentTypes = [NSSet setWithObject:@"text/plain"];
    [manager POST:PUBLIC_URL(LOCKUSER) parameters:parameters success:^(AFHTTPRequestOperation *operation,id responseObject) {
        NSLog(@"lockUserData_success: %@", responseObject);
        
        if ([responseObject[@"status"] isEqualToString:@"100"]) {
            
            [[AppDelegate getInstance].mainTabController hideTabbarView];
            AuthenticationViewController *avc = [[AuthenticationViewController alloc]init];
            [[AppDelegate getInstance].CurNavController pushViewController:avc animated:YES];
            
        }else if ([responseObject[@"status"] isEqualToString:@"300"]){
            
            UIAlertView *alert = [[UIAlertView alloc]initWithTitle:@"温馨提示" message:responseObject[@"message"] delegate:self cancelButtonTitle:@"取消" otherButtonTitles: nil];
            [alert show];
            
        }
        
    }failure:^(AFHTTPRequestOperation *operation,NSError *error) {
        [CustomHUD createShowContent:@"网络链接失败,请检查是否链接网络" hiddenTime:2.4];
    }];
}

#pragma mark -- Data/资料认证
- (void)memberDataRequest {
    if ([Gobal isEmptyString:[Gobal loadAppSetting:BASE_KEY_memberId]]) {
        [[AppDelegate getInstance] callLoginView:NO];
        return;
    }
    
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
            //&&[_authenticateModel.learnStatus isEqualToString:@"1"]
            if ([_authenticateModel.personalStatus isEqualToString:@"1"]&&[_authenticateModel.educationStatus isEqualToString:@"1"]&&[_authenticateModel.contactStatus isEqualToString:@"1"]&&[_authenticateModel.photoStatus isEqualToString:@"1"]&&[_authenticateModel.phoneStatus isEqualToString:@"1"]) {
                
                [[AppDelegate getInstance].mainTabController hideTabbarView];
                BorrowViewController *bvc = [[BorrowViewController alloc]init];
                [[AppDelegate getInstance].CurNavController pushViewController:bvc animated:YES];
                
            }else{
                
                UIAlertView *alert = [[UIAlertView alloc]initWithTitle:@"温馨提示" message:@"您的资料未完成,是否去填写?" delegate:self cancelButtonTitle:@"取消" otherButtonTitles:@"确认", nil];
                [alert show];
                
            }
            
        }
//                else if ([responseObject[@"status"] isEqualToString:@"300"]){
//
//                    UIAlertView *alert = [[UIAlertView alloc]initWithTitle:@"温馨提示" message:responseObject[@"message"] delegate:self cancelButtonTitle:@"取消" otherButtonTitles: nil];
//                    [alert show];
//                    
//                }


    }failure:^(AFHTTPRequestOperation *operation,NSError *error) {
        [CustomHUD createShowContent:@"网络链接失败,请检查是否链接网络" hiddenTime:2.4];
    }];
}
- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex {
    switch (buttonIndex) {
        case 0: {
        }
            break;
        case 1: {
            [[AppDelegate getInstance].mainTabController hideTabbarView];
            AuthenticationViewController *bvc = [[AuthenticationViewController alloc]init];
            [[AppDelegate getInstance].CurNavController pushViewController:bvc animated:YES];
        }
            break;
        default:
            break;
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}
@end
