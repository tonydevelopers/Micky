//
//  BankViewController.m
//  MickyEasyCredit
//
//  Created by 张宁 on 2017/5/9.
//  Copyright © 2017年 apple. All rights reserved.
//

#import "BankViewController.h"
#import "AFNetworking.h"
#import "AppDelegate.h"

#import "BankListModel.h"
#import "BankTableCell.h"
#import "ExternalLinksViewController.h"

@interface BankViewController ()<UITableViewDelegate,UITableViewDataSource>
{
    UILabel *titleLabel;
    UITableView *bank_Table;
    NSMutableArray *data_A;
    UIButton *add_Bank_Btn;
    NO_Data_View *noDataView;
    FCXRefreshFooterView *footerView;
}


@end

@implementation BankViewController
- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    self.navigationController.navigationBar.hidden = NO;
    NAVIGATIONBAR_COLOR_STYLE(BUTTON_COLOR_NORMA,UIStatusBarStyleLightContent);
    [self bankCardDataRequest];
}
- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = BACKGROUND_COLOR;
    self.navigationController.navigationBar.hidden = NO;
    
    [self initData];
    [self initNavigate];
    [self initTable];
}
#pragma mark - init
#pragma mark -- init/Data
- (void)initData {
    [self bankCardDataRequest];
    
}
#pragma mark -- init/navigate
- (void)initNavigate {
    
    UIView *navTitleView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 150, 30)];
    titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 5, navTitleView.frame.size.width-5, 20)];
    titleLabel.textAlignment = NSTextAlignmentCenter;
    titleLabel.textColor = [UIColor whiteColor];
    titleLabel.text = @"我的银行卡";
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
    
    bank_Table = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT-64-50) style:UITableViewStylePlain];
    bank_Table.delegate = self;
    bank_Table.dataSource = self;
    bank_Table.showsVerticalScrollIndicator = NO;
    bank_Table.showsHorizontalScrollIndicator = NO;
    bank_Table.backgroundColor = BACKGROUND_COLOR;
    bank_Table.separatorStyle = UITableViewCellSeparatorStyleNone;
    [self.view addSubview:bank_Table];

    [self initFooter];
}
#pragma mark -- init/footer
- (void)initFooter {
    UIView *show = [[UIView alloc]init];
    show.frame = CGRectMake(0, 0, SCREEN_WIDTH, 80);
    show.backgroundColor = [UIColor clearColor];
    bank_Table.tableFooterView = show;

    add_Bank_Btn = [UIButton buttonWithType:UIButtonTypeCustom];
    add_Bank_Btn.frame = CGRectMake(10, 25, SCREEN_WIDTH-20, 55);
    [add_Bank_Btn setTitle:@"+ 添加银行卡" forState:UIControlStateNormal];
    [add_Bank_Btn setTitleColor:BUTTON_COLOR_NORMA forState:UIControlStateNormal];
    [add_Bank_Btn setTitleColor:[UIColor whiteColor] forState:UIControlStateHighlighted];
    [add_Bank_Btn setBackgroundImage:[Gobal imageWithColor:[UIColor clearColor] size:add_Bank_Btn.frame.size] forState:UIControlStateNormal];
    [add_Bank_Btn setBackgroundImage:[Gobal imageWithColor:BUTTON_COLOR_HIGHT size:add_Bank_Btn.frame.size] forState:UIControlStateHighlighted];
    [add_Bank_Btn addTarget:self action:@selector(addBankBtnAction:) forControlEvents:UIControlEventTouchUpInside];
    add_Bank_Btn.layer.cornerRadius = 5;
    add_Bank_Btn.layer.masksToBounds = YES;
    add_Bank_Btn.layer.borderWidth = 1;
    add_Bank_Btn.layer.borderColor = BUTTON_COLOR_NORMA.CGColor;
    [show addSubview:add_Bank_Btn];
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
    
    CGFloat h = (145/355.0)*(SCREEN_WIDTH-20);
    return h;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *oneCell = @"oneCell";
    BankTableCell *cell = [tableView dequeueReusableCellWithIdentifier:oneCell];
    if (!cell) {
        cell = [[BankTableCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:oneCell];
    }
    [cell setBankListModel:data_A[indexPath.row]];
    return cell;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    BankListModel *model = data_A[indexPath.row];
    if ([self.delegate respondsToSelector:@selector(selectBankInfoModel:)]) {
        [self.delegate selectBankInfoModel:model];
    }
    if (_isBankBack) {
        [[AppDelegate getInstance].mainTabController hideTabbarView];
        [[AppDelegate getInstance].CurNavController popViewControllerAnimated:YES];
    }
   
}

#pragma mark - Event
#pragma mark -- Event/添加银行卡
- (void)addBankBtnAction:(UIButton *)sender {
    [[AppDelegate getInstance].mainTabController hideTabbarView];
    ExternalLinksViewController *ELVC = [[ExternalLinksViewController alloc]init];
    ELVC.class_name = @"银行卡信息";
    ELVC.externalLink_url = [NSString stringWithFormat:@"%@?userId=%@",PUBLIC_WEBURL(WEB_TOBINDCARD),[Gobal loadAppSetting:BASE_KEY_memberId]];
    [[AppDelegate getInstance].CurNavController pushViewController:ELVC animated:YES];
}
#pragma mark - Data
#pragma mark -- Data/银行卡列表
- (void)bankCardDataRequest {
    
    NSString *user_Id = [Gobal loadAppSetting:BASE_KEY_memberId];
    
    NSDictionary *parameters = @{
                                 @"userId" : [Gobal isEmptyString:user_Id]?@"":user_Id,
                                 };
    
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    manager.responseSerializer.acceptableContentTypes = [NSSet setWithObject:@"text/plain"];
    [manager POST:PUBLIC_URL(BANKCARD) parameters:parameters success:^(AFHTTPRequestOperation *operation,id responseObject) {
        NSLog(@"bankCard_success: %@", responseObject);
        NSMutableArray *data_Arr = [NSMutableArray new];
        NSMutableArray *data_Array = [NSMutableArray new];
        data_A = [NSMutableArray new];
        if ([responseObject[@"status"] isEqualToString:@"100"]) {
            data_Arr = [NSMutableArray arrayWithArray:responseObject[@"data"]];
            for (int i = 0; i<data_Arr.count; i++) {
                BankListModel *model = [BankListModel dataWithJsonDictionary:data_Arr[i]];
                [data_Array addObject:model];
            }
            if (data_A) {
                data_A = nil;
            }
            data_A = [NSMutableArray arrayWithArray:data_Array];
            [bank_Table reloadData];
        }
        
    }failure:^(AFHTTPRequestOperation *operation,NSError *error) {
        [CustomHUD createShowContent:@"网络链接失败,请检查是否链接网络" hiddenTime:2.4];
    }];
}
#pragma mark -- Event/back
-(void)popBack {
    
    if (_isBankBack) {
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
