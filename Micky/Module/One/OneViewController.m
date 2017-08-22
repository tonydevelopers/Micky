//
//  OneTabViewController.m
//  MickyEasyCredit
//
//  Created by 张宁 on 16/10/26.
//  Copyright © 2016年 apple. All rights reserved.
//

#import "OneViewController.h"
#import "AFNetworking.h"
#import "AppDelegate.h"
#import "AdvertModel.h"

#import "BorrowBannerModel.h"
#import "AuthenticationModel.h"
#import "BorrowViewController.h"
#import "BHInfiniteScrollView.h"
#import "PhotoTextMaxViewController.h"
#import "ExternalLinksViewController.h"
#import "AuthenticationViewController.h"

#import "OneCollectionViewCell.h"
#import "TwoCollectionViewCell.h"
#import "ThreeCollectionViewCell.h"
#import "FourCollectionViewCell.h"


@interface OneViewController ()<BHInfiniteScrollViewDelegate,FourCollectionDelegate,UICollectionViewDelegate,UICollectionViewDataSource,UIAlertViewDelegate> {
    
    BHInfiniteScrollView *infinitePageView;
    UICollectionView *collection;
    NSMutableArray *photo_Array;
    NSMutableArray *content_Array;
    NSMutableArray *title_data_A;
    UILabel *titleLabel;
    UIWebView *webView;
}
@property(nonatomic,strong)AuthenticationModel *authenticateModel;
@property(nonatomic,strong)BorrowBannerModel *borrowBannerModel;
@end

@implementation OneViewController
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
    self.navigationController.navigationBar.hidden = NO;
    NAVIGATIONBAR_COLOR_STYLE(BUTTON_COLOR_NORMA,UIStatusBarStyleLightContent);
    [self initData];
}
- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = BACKGROUND_COLOR;
    self.navigationController.navigationBar.hidden = NO;

    [self initData];
    [self initNavigate];
    [self initHeader];
}
#pragma mark - init
#pragma mark -- init/Data
- (void)initData {
    if ([Gobal isEmptyString:[Gobal loadAppSetting:BASE_KEY_memberId]]) {
        [[AppDelegate getInstance] callLoginView:NO];
        return;
    }
    photo_Array  = [NSMutableArray new];
    content_Array = [NSMutableArray new];
    [self shufflingFigureDataRequest];
}
#pragma mark -- init/navigate
- (void)initNavigate {
    UIView *navTitleView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 150, 30)];
    titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 5, navTitleView.frame.size.width-5, 20)];
    titleLabel.textAlignment = NSTextAlignmentCenter;
    titleLabel.textColor = [UIColor whiteColor];
    titleLabel.text = @"仟易贷";
    titleLabel.font = [UIFont systemFontOfSize:20.0];
    [navTitleView addSubview:titleLabel];
    self.navigationItem.titleView = navTitleView;
    self.navigationController.navigationBar.backgroundColor = [UIColor clearColor];
}
#pragma mark -- init/header
- (void)initHeader {
    
    UIImageView *place_hold = [[UIImageView alloc]init];
    place_hold.image = [UIImage imageNamed:@"header_photo"];
    place_hold.frame = CGRectMake(0, 0, SCREEN_WIDTH, (14/25.0)*SCREEN_WIDTH);
    [self.view addSubview:place_hold];
    
    [self initCollect];
}
#pragma mark -- init/collect
- (void)initCollect {
    
    UICollectionViewFlowLayout *collectLayput = [[UICollectionViewFlowLayout alloc]init];
    collectLayput.minimumInteritemSpacing = 0;
    collectLayput.minimumLineSpacing = 0;
    collectLayput.sectionInset = UIEdgeInsetsMake(0, 0, 0, 0);
    collectLayput.scrollDirection = UICollectionViewScrollDirectionVertical;
    
    collection = [[UICollectionView alloc]initWithFrame:CGRectMake(0, (14/25.0)*SCREEN_WIDTH, SCREEN_WIDTH, SCREEN_HEIGHT-(14/25.0)*SCREEN_WIDTH-64-50) collectionViewLayout:collectLayput];
    collection.backgroundColor = BACKGROUND_COLOR;
    collection.delegate = self;
    collection.dataSource = self;
    collection.showsVerticalScrollIndicator = NO;
    collection.showsHorizontalScrollIndicator = NO;
    [self.view addSubview:collection];
    
    [collection registerClass:[OneCollectionViewCell class] forCellWithReuseIdentifier:@"OneCollectionViewCellreuse"];
    [collection registerClass:[TwoCollectionViewCell class] forCellWithReuseIdentifier:@"TwoCollectionViewCellreuse"];
    [collection registerClass:[ThreeCollectionViewCell class] forCellWithReuseIdentifier:@"ThreeCollectionViewCellreuse"];
    [collection registerClass:[FourCollectionViewCell class] forCellWithReuseIdentifier:@"FourCollectionViewCellreuse"];


}
#pragma mark - delegate/colloction
- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
    return 4;
}
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    
    switch (section) {
        case 0:{
            return 1;
        }
            break;
        case 1:{
            return 2;
        }
            break;
        case 2:{
            return 1;
        }
            break;
        case 3:{
            return 1;
        }
            break;
        default:{
            return 6;
        }
            break;
    }
    return 6;
}
-(CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath {
    
    switch (indexPath.section) {
        case 0:{
            return CGSizeMake(SCREEN_WIDTH, 40.5);
        }
            break;
        case 1:{
            return CGSizeMake(SCREEN_WIDTH/2.0, 125);
        }
            break;
        case 2:{
            return CGSizeMake(SCREEN_WIDTH, 55.5);
        }
            break;
        case 3:{
            return CGSizeMake(SCREEN_WIDTH, 80);
        }
            break;
        default:
            break;
    }
    return CGSizeMake(SCREEN_WIDTH, 30);

}
- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    switch (indexPath.section) {
        case 0:{
            OneCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"OneCollectionViewCellreuse" forIndexPath:indexPath];
            
            
            return cell;
        }
            break;
        case 1:{
            TwoCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"TwoCollectionViewCellreuse" forIndexPath:indexPath];
            NSArray *arr = @[@"left_up",@"right_up"];
            [cell setShowImageV:arr[indexPath.item] imdexRow:indexPath.item];
            return cell;
        }
            break;
        case 2:{
            ThreeCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"ThreeCollectionViewCellreuse" forIndexPath:indexPath];
            return cell;
        }
            break;
        case 3:{
            FourCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"FourCollectionViewCellreuse" forIndexPath:indexPath];
            cell.delegate = self;
            return cell;
        }
            break;
        default:
            break;
    }
    return nil;
}
- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    switch (indexPath.section) {
        case 0:
            
            break;
        case 1:{
//            switch (indexPath.item) {
//                case 0:
//                    
//                    break;
//                case 1:{
//                    [[AppDelegate getInstance].mainTabController hideTabbarView];
//                    ExternalLinksViewController *ELVC = [[ExternalLinksViewController alloc]init];
//                    ELVC.class_name = @"白领借款";
//                    ELVC.isRooterEnter = YES;
//                    ELVC.is_show_header = YES;
//                    ELVC.externalLink_url = [NSString stringWithFormat:@"%@?userId=%@",PUBLIC_WEBURL(WHITECOLLAR),[Gobal loadAppSetting:BASE_KEY_memberId]];
//                    [[AppDelegate getInstance].CurNavController pushViewController:ELVC animated:YES];
//
//                }
//                    break;
//                default:
//                    break;
//            }
        }
            break;
        case 2:
            
            break;
        case 3:
            
            break;
        default:
            break;
    }
}
#pragma mark -- delegate/
-(void)IWantToBorrow {
    [self memberDataRequest];
}
- (void)selectJeeplusStyle:(NSInteger)btnTag {
    switch (btnTag) {
        case 0:{
            [self memberDataRequest];
        }
            break;
        case 1:{
            [[AppDelegate getInstance].mainTabController hideTabbarView];
            ExternalLinksViewController *ELVC = [[ExternalLinksViewController alloc]init];
            ELVC.class_name = @"我要还款";
            ELVC.isRooterEnter = YES;
            ELVC.is_show_header = YES;
            ELVC.externalLink_url = [NSString stringWithFormat:@"%@?userId=%@",PUBLIC_WEBURL(WEB_TOREPAYMENT),[Gobal loadAppSetting:BASE_KEY_memberId]];
            [[AppDelegate getInstance].CurNavController pushViewController:ELVC animated:YES];
        }
            break;
        case 2:{
            [[AppDelegate getInstance].mainTabController hideTabbarView];
            ExternalLinksViewController *ELVC = [[ExternalLinksViewController alloc]init];
            ELVC.class_name = @"费用说明";
            ELVC.externalLink_url = WEBURL(WEB_EXPLAIN);
            ELVC.isRooterEnter = YES;
            ELVC.is_show_header = YES;
            [[AppDelegate getInstance].CurNavController pushViewController:ELVC animated:YES];
        }
            break;
        case 3:{
            [[AppDelegate getInstance].mainTabController hideTabbarView];
            ExternalLinksViewController *ELVC = [[ExternalLinksViewController alloc]init];
            ELVC.class_name = @"借款查询";
            ELVC.isRooterEnter = YES;
            ELVC.is_show_header = YES;
            ELVC.externalLink_url = [NSString stringWithFormat:@"%@?userId=%@",PUBLIC_WEBURL(WEB_TOLOAN),[Gobal loadAppSetting:BASE_KEY_memberId]];
            [[AppDelegate getInstance].CurNavController pushViewController:ELVC animated:YES];
        }
            break;
        default:
            break;
    }
}
#pragma mark - delegate/BHInfiniteScrollViewDelegate
- (void)infiniteScrollView:(BHInfiniteScrollView *)infiniteScrollView didSelectItemAtIndex:(NSInteger)index {
    NSLog(@"BHInfiniteScrollViewDelegate == %@",content_Array[index]);
    AdvertModel *model = content_Array[index];

    [[AppDelegate getInstance].mainTabController hideTabbarView];
    PhotoTextMaxViewController *PTMVC = [[PhotoTextMaxViewController alloc]init];
    PTMVC.PhotoTextMax_URL = [NSString stringWithFormat:@"%@?id=%@",PUBLIC_WEBURL(WEB_TOADVERTISE),model.Id];
    [[AppDelegate getInstance].CurNavController pushViewController:PTMVC animated:YES];
}
#pragma mark - Data  轮播数据
- (void)indexWeekLoanDataRequest {
    NSString *num_str = @"-7";
    NSDictionary *parameters = @{
                                 @"num" : num_str,
                                 };
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    manager.responseSerializer.acceptableContentTypes = [NSSet setWithObject:@"text/plain"];
    [manager POST:PUBLIC_URL(INDEXWEEKLOAN) parameters:parameters success:^(AFHTTPRequestOperation *operation,id responseObject) {
        NSLog(@"indexWeekLoan_success: %@", responseObject);
        
        if ([responseObject[@"status"] isEqualToString:@"100"]) {

            NSArray *array = responseObject[@"data"];
            NSMutableArray *array_data = [NSMutableArray new];
            for (int i = 0; i<array.count; i++) {
                BorrowBannerModel *bannerModel = [BorrowBannerModel dataWithJsonDictionary:[array objectAtIndex:i]];
                [array_data addObject:bannerModel];
            }
            
            if (title_data_A) {
                title_data_A = nil;
            }
            title_data_A = [NSMutableArray arrayWithArray:array_data];
            
            [collection reloadData];
        }        
    }failure:^(AFHTTPRequestOperation *operation,NSError *error) {
        [CustomHUD createShowContent:@"网络链接失败,请检查是否链接网络" hiddenTime:2.4];
    }];
    
}
#pragma mark -- Data/轮播图
- (void)shufflingFigureDataRequest {
    
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    manager.responseSerializer.acceptableContentTypes = [NSSet setWithObject:@"text/plain"];
    [manager POST:PUBLIC_URL(ADVERT) parameters:nil success:^(AFHTTPRequestOperation *operation,id responseObject) {
        NSLog(@"advert_success: %@", responseObject);
        NSMutableArray *data_A = [NSMutableArray new];
        if ([responseObject[@"status"] isEqualToString:@"100"]) {
            NSMutableArray *data_arr = [NSMutableArray new];
            NSMutableArray *content_arr = [NSMutableArray new];
            
            NSLog(@"data: %@", responseObject[@"data"]);
            data_A = [NSMutableArray arrayWithArray:responseObject[@"data"]];
            for (int i = 0; i < data_A.count ; i++) {
                AdvertModel *model = [AdvertModel dataWithJsonDictionary:data_A[i]];
                [data_arr addObject:model.imgurl];
                [content_arr addObject:model];
            }
            if (photo_Array) {
                photo_Array = nil;
            }
            photo_Array = [NSMutableArray arrayWithArray:data_arr];
            if (content_Array) {
                content_Array = nil;
            }
            content_Array = [NSMutableArray arrayWithArray:content_arr];


            infinitePageView = [BHInfiniteScrollView
                                infiniteScrollViewWithFrame:CGRectMake(0, 0, SCREEN_WIDTH,(14/25.0)*SCREEN_WIDTH) Delegate:self ImagesArray:photo_Array];
            infinitePageView.placeholderImage = [UIImage imageNamed:@"header_photo"];
            infinitePageView.pageControl.dotSize = 4;
            infinitePageView.pageControlAlignmentOffset = CGSizeMake(20, 10);
            infinitePageView.scrollTimeInterval = 2.4;
            infinitePageView.autoScrollToNextPage = YES;
            infinitePageView.delegate = self;
            infinitePageView.pageControlAlignmentH = BHInfiniteScrollViewPageControlAlignHorizontalRight;
            [self.view addSubview:infinitePageView];

        }
        
    }failure:^(AFHTTPRequestOperation *operation,NSError *error) {
        [CustomHUD createShowContent:@"网络链接失败,请检查是否链接网络" hiddenTime:2.4];
    }];
}
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
            
            NSLog(@"memberData: %@", responseObject[@"data"]);
            _authenticateModel = [AuthenticationModel dataWithJsonDictionary:responseObject[@"data"]];
            
             if ([_authenticateModel.personalStatus isEqualToString:@"1"]&&[_authenticateModel.educationStatus isEqualToString:@"1"]&&[_authenticateModel.contactStatus isEqualToString:@"1"]&&[_authenticateModel.photoStatus isEqualToString:@"1"]&&[_authenticateModel.phoneStatus isEqualToString:@"1"]) {
                
                [[AppDelegate getInstance].mainTabController hideTabbarView];
                BorrowViewController *bvc = [[BorrowViewController alloc]init];
                [[AppDelegate getInstance].CurNavController pushViewController:bvc animated:YES];
                
            }else{
            
                UIAlertView *alert = [[UIAlertView alloc]initWithTitle:@"温馨提示" message:@"您的资料未完成,是否去填写?" delegate:self cancelButtonTitle:@"取消" otherButtonTitles:@"确认", nil];
                [alert show];
                
            }
        }
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
