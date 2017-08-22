//
//  TwoViewController.m
//  MickyEasyCredit
//
//  Created by 张宁 on 16/10/26.
//  Copyright © 2016年 apple. All rights reserved.
//

#import "TwoViewController.h"
#import "AFNetworking.h"
#import "AppDelegate.h"


#import "NewsModel.h"
#import "NewsTableOneCell.h"

@interface TwoViewController ()<UITableViewDelegate,UITableViewDataSource>
{
    UILabel *titleLabel;
    UITableView *news_Table;
    NSMutableArray *data_A;
    NO_Data_View *noDataView;
    FCXRefreshFooterView *footerView;
    
}
@end

@implementation TwoViewController
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
    [self newsMessageDataRequest];
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
    [self newsMessageDataRequest];
    
}

#pragma mark -- init/navigate
- (void)initNavigate {
    
    UIView *navTitleView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 150, 30)];
    titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 5, navTitleView.frame.size.width-5, 20)];
    titleLabel.textAlignment = NSTextAlignmentCenter;
    titleLabel.textColor = [UIColor whiteColor];
    titleLabel.text = @"消息中心";
    titleLabel.font = [UIFont systemFontOfSize:20.0];
    [navTitleView addSubview:titleLabel];
    self.navigationItem.titleView = navTitleView;
    self.navigationController.navigationBar.backgroundColor = [UIColor clearColor];
}
#pragma mark -- init/Layout
- (void)initTable {
    
    news_Table = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT-64-50) style:UITableViewStylePlain];
    news_Table.delegate = self;
    news_Table.dataSource = self;
    news_Table.showsVerticalScrollIndicator = NO;
    news_Table.showsHorizontalScrollIndicator = NO;
    news_Table.backgroundColor = BACKGROUND_COLOR;
    news_Table.separatorStyle = UITableViewCellSeparatorStyleNone;
    [self.view addSubview:news_Table];
    [self initNoDataView];
    [self addRefreshView];
        
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
    
    NewsModel *model;
    if (data_A.count>0) {
        model = data_A[indexPath.row];
    }
    NSString *content_str = model.msgContent;
    CGFloat height = [Gobal heightWithText:content_str font:[UIFont systemFontOfSize:15] maxWidth:SCREEN_WIDTH-40];
    return 70+(height>20?height:20);
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *oneCell = @"oneCell";
    NewsTableOneCell *cell = [tableView dequeueReusableCellWithIdentifier:oneCell];
    if (!cell) {
        cell = [[NewsTableOneCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:oneCell];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
    }
    [cell setNewsModel:data_A[indexPath.row]];
    return cell;
}

#pragma mark - Data
#pragma mark -- Data/消息中心
- (void)newsMessageDataRequest {
    NSString *user_Id = [Gobal loadAppSetting:BASE_KEY_memberId];
    
    NSDictionary *parameters = @{
                                 @"userId" : [Gobal isEmptyString:user_Id]?@"":user_Id,
                                 @"pageNo" : @"0",
                                 @"pageSize" : @"10"
                                 };
    
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    manager.responseSerializer.acceptableContentTypes = [NSSet setWithObject:@"text/plain"];
    [manager POST:PUBLIC_URL(MSG) parameters:parameters success:^(AFHTTPRequestOperation *operation,id responseObject) {
        NSLog(@"msg_success: %@", responseObject);
        NSMutableArray *data_Arr = [NSMutableArray new];
        data_A = [NSMutableArray new];
        if ([responseObject[@"status"] isEqualToString:@"100"]) {
            
            data_Arr = [NSMutableArray arrayWithArray:responseObject[@"data"]];
            for (int i = 0; i < data_Arr.count ; i++) {
                NewsModel *model = [NewsModel dataWithJsonDictionary:data_Arr[i]];
                [data_A addObject:model];
            }
            [noDataView noDataViewUpdate:data_A];
            [news_Table reloadData];
        }else {
//            [CustomHUD createShowContent:responseObject[@"message"] hiddenTime:2.4];
        }
        
    }failure:^(AFHTTPRequestOperation *operation,NSError *error) {
        [CustomHUD createShowContent:@"网络链接失败,请检查是否链接网络" hiddenTime:2.4];
    }];
}
#pragma mark -- Data/加载更多消息中心
- (void)moreLoadNewsMessageDataRequest {
    
    NSInteger num = data_A.count;
    NSString *start = @"0";
    NSString *limit = [NSString stringWithFormat:@"%ld",(long)num+10];
    
    NSString *user_Id = [Gobal loadAppSetting:BASE_KEY_memberId];
    NSDictionary *parameters = @{
                                 @"userId" : [Gobal isEmptyString:user_Id]?@"":user_Id,
                                 @"pageNo" : start,
                                 @"pageSize" : limit
                                 };
    
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    manager.responseSerializer.acceptableContentTypes = [NSSet setWithObject:@"text/plain"];
    [manager POST:PUBLIC_URL(MSG) parameters:parameters success:^(AFHTTPRequestOperation *operation,id responseObject) {
        [footerView endRefresh];
        NSLog(@"msg_success: %@", responseObject);
        NSMutableArray *arr = [NSMutableArray new];
        NSArray *comments = [responseObject objectForKey:@"data"];
        for (int i=0; i<[comments count]; i++) {
            NewsModel *comment = [NewsModel dataWithJsonDictionary:[comments objectAtIndex:i]];
            [arr addObject:comment];
        }
        data_A = [NSMutableArray arrayWithArray:arr];
        [noDataView noDataViewUpdate:data_A];
        [news_Table reloadData];
    }failure:^(AFHTTPRequestOperation *operation,NSError *error) {
        [footerView endRefresh];
        [CustomHUD createShowContent:@"网络链接失败,请检查是否链接网络" hiddenTime:2.4];
    }];
}
#pragma mark -- Data/页面默认图
- (void)initNoDataView{
    
    noDataView = [[NO_Data_View alloc]initWithFrame:CGRectMake(0, 0, news_Table.frame.size.width, news_Table.frame.size.height)];
    [news_Table addSubview:noDataView];
}
#pragma mark -- Data/下拉刷新数据
- (void)addRefreshView {
    __block TwoViewController *weakSelf = self;
    footerView = [news_Table addFooterWithRefreshHandler:^(FCXRefreshBaseView *refreshView) {
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1.5 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            [weakSelf moreLoadNewsMessageDataRequest];
        });
    }];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}
@end










