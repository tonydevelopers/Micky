//
//  CouponViewController.m
//  MickyEasyCredit
//
//  Created by 张宁 on 2017/5/11.
//  Copyright © 2017年 apple. All rights reserved.
//

#import "CouponViewController.h"
#import "AFNetworking.h"
#import "AppDelegate.h"

#import "NO_Data_View.h"
#import "CouponModel.h"

#import "CouponTableOneCell.h"
#import "CouponTableTwoCell.h"
#import "CouponTableThreeCell.h"


typedef enum {
    
    CouponStateStyleNotUse,      //未使用
    CouponStateStyleCompleted,   //已使用
    CouponStateStyleExpired,   //已过期
    
}CouponStateStyle;


@interface CouponViewController ()<UITableViewDelegate,UITableViewDataSource>
{
    UILabel *titleLabel;
    UITableView *coupon_Table;
    NSMutableArray *data_A;
    NO_Data_View *noDataView;
    FCXRefreshFooterView *footerView;
    
    UIView   *headerView;
    UIView   *underline;
    UIButton *left_Btn;
    UIButton *center_Btn;
    UIButton *right_Btn;
    CouponStateStyle couponStateStyle;
}
@end

@implementation CouponViewController
- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    self.navigationController.navigationBar.hidden = NO;
    NAVIGATIONBAR_COLOR_STYLE(BUTTON_COLOR_NORMA,UIStatusBarStyleLightContent);
    [self couponDataRequest:@"0"];
}
- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = BACKGROUND_COLOR;
    self.navigationController.navigationBar.hidden = NO;

    [self initData];
    [self initHeader];
    [self initNavigate];
    [self initTable];
}
#pragma mark - init
#pragma mark -- init/Data
- (void)initData {
    [self couponDataRequest:@"0"];
    
}
#pragma mark -- init/header
- (void)initHeader {
    headerView = [[UIView alloc]init];
    headerView.frame = CGRectMake(0, 0, SCREEN_WIDTH, 50);
    headerView.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:headerView];
    
    CGFloat btn_Width = SCREEN_WIDTH/3.0;
    
    left_Btn = [UIButton buttonWithType:UIButtonTypeCustom];
    left_Btn.frame = CGRectMake(0, 0, btn_Width, 50);
    [left_Btn setTitle:@"未使用(0)" forState:UIControlStateNormal];
    [left_Btn setTitleColor:TITLE_FONT_COLOR forState:UIControlStateNormal];
    [left_Btn setTitleColor:BUTTON_COLOR_NORMA forState:UIControlStateSelected];
    [left_Btn addTarget:self action:@selector(selectCouponAction:) forControlEvents:UIControlEventTouchUpInside];
    left_Btn.titleLabel.font = [UIFont systemFontOfSize:15];
    [headerView addSubview:left_Btn];
    
    center_Btn = [UIButton buttonWithType:UIButtonTypeCustom];
    center_Btn.frame = CGRectMake(btn_Width, 0, btn_Width, 50);
    [center_Btn setTitle:@"已使用(0)" forState:UIControlStateNormal];
    [center_Btn setTitleColor:TITLE_FONT_COLOR forState:UIControlStateNormal];
    [center_Btn setTitleColor:BUTTON_COLOR_NORMA forState:UIControlStateSelected];
    [center_Btn addTarget:self action:@selector(selectCouponAction:) forControlEvents:UIControlEventTouchUpInside];
    center_Btn.titleLabel.font = [UIFont systemFontOfSize:15];
    [headerView addSubview:center_Btn];
    
    right_Btn = [UIButton buttonWithType:UIButtonTypeCustom];
    right_Btn.frame = CGRectMake(2*btn_Width, 0, btn_Width, 50);
    [right_Btn setTitle:@"已过期(0)" forState:UIControlStateNormal];
    [right_Btn setTitleColor:TITLE_FONT_COLOR forState:UIControlStateNormal];
    [right_Btn setTitleColor:BUTTON_COLOR_NORMA forState:UIControlStateSelected];
    [right_Btn addTarget:self action:@selector(selectCouponAction:) forControlEvents:UIControlEventTouchUpInside];
    right_Btn.titleLabel.font = [UIFont systemFontOfSize:15];
    [headerView addSubview:right_Btn];

    underline = [[UIView alloc]init];
    underline.frame = CGRectMake((btn_Width-70)/2.0, 40, 70, 1);
    underline.backgroundColor = BUTTON_COLOR_NORMA;
    [headerView addSubview:underline];
    
    left_Btn.tag = 1;
    center_Btn.tag = 2;
    right_Btn.tag = 3;
    left_Btn.selected = YES;
    center_Btn.selected = NO;
    right_Btn.selected = NO;
    couponStateStyle = CouponStateStyleNotUse;

}
#pragma mark -- init/navigate
- (void)initNavigate {
    
    UIView *navTitleView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 150, 30)];
    titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 5, navTitleView.frame.size.width-5, 20)];
    titleLabel.textAlignment = NSTextAlignmentCenter;
    titleLabel.textColor = [UIColor whiteColor];
    titleLabel.text = @"我的优惠券";
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
#pragma mark -- init/Layout
- (void)initTable {
    
    coupon_Table = [[UITableView alloc]initWithFrame:CGRectMake(0, 60, SCREEN_WIDTH, SCREEN_HEIGHT-64-60) style:UITableViewStylePlain];
    coupon_Table.delegate = self;
    coupon_Table.dataSource = self;
    coupon_Table.showsVerticalScrollIndicator = NO;
    coupon_Table.showsHorizontalScrollIndicator = NO;
    coupon_Table.backgroundColor = BACKGROUND_COLOR;
    coupon_Table.separatorStyle = UITableViewCellSeparatorStyleNone;
    [self.view addSubview:coupon_Table];
    [self initNoDataView];
}
#pragma mark - delegate
#pragma mark -- delegate/table
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return data_A.count;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 90;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    switch (couponStateStyle) {
        case CouponStateStyleNotUse: {
            static NSString *oneCell = @"oneCell";
            CouponTableOneCell *cell = [tableView dequeueReusableCellWithIdentifier:oneCell];
            if (!cell) {
                cell = [[CouponTableOneCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:oneCell];
            }
            [cell setCouponNotUserModel:data_A[indexPath.row]];
            return cell;
        }
            break;
        case CouponStateStyleCompleted: {
            static NSString *twoCell = @"twoCell";
            CouponTableTwoCell *cell = [tableView dequeueReusableCellWithIdentifier:twoCell];
            if (!cell) {
                cell = [[CouponTableTwoCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:twoCell];
                cell.selectionStyle = UITableViewCellSelectionStyleNone;
            }
            [cell setCouponCompletedModel:data_A[indexPath.row]];
            return cell;
        }
            break;
        case CouponStateStyleExpired: {
            static NSString *threeCell = @"threeCell";
            CouponTableThreeCell *cell = [tableView dequeueReusableCellWithIdentifier:threeCell];
            if (!cell) {
                cell = [[CouponTableThreeCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:threeCell];
                cell.selectionStyle = UITableViewCellSelectionStyleNone;
            }
            [cell setCouponExpiredModel:data_A[indexPath.row]];
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
    
    switch (couponStateStyle) {
        case CouponStateStyleNotUse: {
            CouponModel *model = data_A[indexPath.row];
            if ([self.delegate respondsToSelector:@selector(selectCouponModel:)]) {
                [self.delegate selectCouponModel:model];
            }
            if (_isPopBack) {
                [[AppDelegate getInstance].mainTabController hideTabbarView];
                [[AppDelegate getInstance].CurNavController popViewControllerAnimated:YES];
            }
        }
            break;
        case CouponStateStyleCompleted: {
            [CustomHUD createShowContent:@"您的优惠券已被使用" hiddenTime:2.4];
        }
            break;
        case CouponStateStyleExpired: {
            [CustomHUD createShowContent:@"您的优惠券已过期" hiddenTime:2.4];
        }
            break;
        default:
            break;
    }
}
#pragma mark - Event
#pragma mark -- Event/选择优惠券
- (void)selectCouponAction:(UIButton *)sender {
    CGFloat btn_Width = SCREEN_WIDTH/3.0;
    data_A = [NSMutableArray new];
    switch (sender.tag) {
        case 1: {
            left_Btn.selected = YES;
            center_Btn.selected = NO;
            right_Btn.selected = NO;
            couponStateStyle = CouponStateStyleNotUse;
            [self couponDataRequest:@"0"];
        }
            break;
        case 2: {
            left_Btn.selected = NO;
            center_Btn.selected = YES;
            right_Btn.selected = NO;
            couponStateStyle = CouponStateStyleCompleted;
            [self couponDataRequest:@"1"];
        }
            break;
        case 3: {
            left_Btn.selected = NO;
            center_Btn.selected = NO;
            right_Btn.selected = YES;
            couponStateStyle = CouponStateStyleExpired;
            [self couponDataRequest:@"2"];
        }
            break;
        default:
            break;
    }
    [UIView animateWithDuration:0.3 animations:^{
        underline.frame = CGRectMake((btn_Width-70)/2.0+btn_Width*(sender.tag-1), 40, 70, 1);
    }];
    [coupon_Table reloadData];
}
#pragma mark - Data
#pragma mark -- Data/消息中心
- (void)couponDataRequest:(NSString *)couponStyle {
    [CustomHUD createHudCustomShowContent:@"请稍等..."];
    NSString *user_Id = [Gobal loadAppSetting:BASE_KEY_memberId];
    
    NSDictionary *parameters = @{
                                 @"userId" : [Gobal isEmptyString:user_Id]?@"":user_Id,
                                 @"type" : couponStyle,
                                 };
    
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    manager.responseSerializer.acceptableContentTypes = [NSSet setWithObject:@"text/plain"];
    [manager POST:PUBLIC_URL(COUPON) parameters:parameters success:^(AFHTTPRequestOperation *operation,id responseObject) {
        [CustomHUD stopHidden];
        NSLog(@"coupon_success: %@", responseObject);
        NSMutableArray *data_Arr = [NSMutableArray new];
        NSMutableArray *data_Array = [NSMutableArray new];
        NSString *l_str = [NSString stringWithFormat:@"未使用(%@)",responseObject[@"noCount"]];
        NSString *c_str = [NSString stringWithFormat:@"已使用(%@)",responseObject[@"yesCount"]];
        NSString *r_str = [NSString stringWithFormat:@"已过期(%@)",responseObject[@"expiredCount"]];
        [left_Btn setTitle:l_str forState:UIControlStateNormal];
        [center_Btn setTitle:c_str forState:UIControlStateNormal];
        [right_Btn setTitle:r_str forState:UIControlStateNormal];
        if ([responseObject[@"status"] isEqualToString:@"100"]) {
           
            data_Arr = [NSMutableArray arrayWithArray:responseObject[@"data"]];
            for (int i = 0; i < data_Arr.count ; i++) {
                CouponModel *model = [CouponModel dataWithJsonDictionary:data_Arr[i]];
                [data_Array addObject:model];
            }
        }
        if (data_A) {
            data_A = nil;
        }
        data_A = [NSMutableArray arrayWithArray:data_Array];
        [noDataView noDataViewUpdate:data_A];
        [coupon_Table reloadData];

    }failure:^(AFHTTPRequestOperation *operation,NSError *error) {
        [CustomHUD createShowContent:@"网络链接失败,请检查是否链接网络" hiddenTime:2.4];
    }];
}
#pragma mark -- Data/页面默认图
- (void)initNoDataView{
    
    noDataView = [[NO_Data_View alloc]initWithFrame:CGRectMake(0, 0, coupon_Table.frame.size.width, coupon_Table.frame.size.height)];
    [coupon_Table addSubview:noDataView];
}
#pragma mark -- popBack
- (void)popBack {
    if (_isPopBack) {
        [[AppDelegate getInstance].mainTabController hideTabbarView];
        [[AppDelegate getInstance].CurNavController popViewControllerAnimated:YES];
    }else {
        self.navigationController.navigationBar.hidden = YES;
        [[AppDelegate getInstance].mainTabController showTabbarView];
        [[AppDelegate getInstance].CurNavController popToRootViewControllerAnimated:YES];
    }
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}
@end



