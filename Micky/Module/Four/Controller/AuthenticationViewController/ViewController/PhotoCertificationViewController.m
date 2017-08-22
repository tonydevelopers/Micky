//
//  PhotoCertificationViewController.m
//  MickyEasyCredit
//
//  Created by 张宁 on 2017/4/8.
//  Copyright © 2017年 apple. All rights reserved.
//

#import "PhotoCertificationViewController.h"
#import "AFNetworking.h"
#import "AppDelegate.h"
#import "UIImageView+WebCache.h"

#import "PhotoAuthModel.h"
#import "PhotoCollectionCell.h"
#import "PhotoCollectionTwoCell.h"


@interface PhotoCertificationViewController ()<UICollectionViewDelegate,UICollectionViewDataSource,UIActionSheetDelegate,UINavigationControllerDelegate,UIImagePickerControllerDelegate> {
    
    FCXRefreshHeaderView *headerView;
    UICollectionView *collection;
    NSMutableArray *photo_Array;
    UILabel *titleLabel;
    
    UIButton *save_Btn;
    UIActionSheet *sheet;
    NSInteger index_path_row;
    UILabel *label1;
    UILabel *label2;
    UILabel *label3;
    UIImage *image_1;
    UIImage *image_2;
    UIImage *image_3;
    UIImage *image_4;
    UIImage *image_5;

}
@property(nonatomic,strong)PhotoAuthModel *photoAuthModel;

@end

@implementation PhotoCertificationViewController
- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    NAVIGATIONBAR_COLOR_STYLE(BUTTON_COLOR_NORMA,UIStatusBarStyleLightContent);
    [self checkWhetherPhotoDataRequest];
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
    [self checkWhetherPhotoDataRequest];
}
#pragma mark -- init/navigate
- (void)initNavigate {
    UIView *navTitleView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 150, 30)];
    titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 5, navTitleView.frame.size.width-5, 20)];
    titleLabel.textAlignment = NSTextAlignmentCenter;
    titleLabel.textColor = [UIColor whiteColor];
    titleLabel.text = @"照片信息";
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
#pragma mark -- init/header
- (void)initHeader {
    
}
#pragma mark -- init/Table
- (void)initTable {
    
    UICollectionViewFlowLayout *collectLayput = [[UICollectionViewFlowLayout alloc]init];
    collectLayput.minimumInteritemSpacing = 0;
    collectLayput.minimumLineSpacing = 0;
    collectLayput.sectionInset = UIEdgeInsetsMake(0, 0, 0, 0);
    collectLayput.scrollDirection = UICollectionViewScrollDirectionVertical;
    
    collection = [[UICollectionView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT-64) collectionViewLayout:collectLayput];
    collection.backgroundColor = BACKGROUND_COLOR;
    collection.delegate = self;
    collection.dataSource = self;
    collection.showsVerticalScrollIndicator = NO;
    collection.showsHorizontalScrollIndicator = NO;
    [self.view addSubview:collection];
    
    [collection registerClass:[UICollectionViewCell class] forCellWithReuseIdentifier:@"CollectOneCellreuse"];
    [collection registerClass:[PhotoCollectionCell class] forCellWithReuseIdentifier:@"PhotoCollectionCellreuse"];
    [collection registerClass:[UICollectionViewCell class] forCellWithReuseIdentifier:@"CollectThreeCellreuse"];
    [collection registerClass:[PhotoCollectionTwoCell class] forCellWithReuseIdentifier:@"PhotoCollectionTwoCellreuse"];
    [collection registerClass:[UICollectionViewCell class] forCellWithReuseIdentifier:@"CollectFourCellreuse"];
    [self initFooter];
}
#pragma mark -- init/footer
- (void)initFooter {
    
    save_Btn = [UIButton buttonWithType:UIButtonTypeCustom];
    save_Btn.frame = CGRectMake(20, SCREEN_WIDTH*2/3.0+230, SCREEN_WIDTH-40, 45);
    [save_Btn setTitle:@"确认" forState:UIControlStateNormal];
    [save_Btn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [save_Btn setBackgroundImage:[Gobal imageWithColor:BUTTON_COLOR_NORMA size:save_Btn.frame.size] forState:UIControlStateNormal];
    [save_Btn setBackgroundImage:[Gobal imageWithColor:BUTTON_COLOR_HIGHT size:save_Btn.frame.size] forState:UIControlStateHighlighted];
    [save_Btn addTarget:self action:@selector(saveBtnAction) forControlEvents:UIControlEventTouchUpInside];
    save_Btn.layer.cornerRadius = 5;
    save_Btn.layer.masksToBounds = YES;
    [collection addSubview:save_Btn];
}

#pragma mark - delegate/colloction
- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
    return 5;
}
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    switch (section) {
        case 0:{
            return 1;
        }
            break;
        case 1:{
            return 3;
        }
            break;
        case 2:{
            return 1;
        }
            break;
        case 3:{
            return 3;
        }
            break;
        case 4:{
            return 1;
        }
            break;
        default:
            break;
    }
    return 9;
}
-(CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath {
    
    switch (indexPath.section) {
        case 0:{
            return CGSizeMake(SCREEN_WIDTH, 40);
        }
            break;
        case 1:{
            return CGSizeMake(SCREEN_WIDTH/3.0, SCREEN_WIDTH/3.0+30);
        }
            break;
        case 2:{
            return CGSizeMake(SCREEN_WIDTH, 40);
        }
            break;
        case 3:{
            return CGSizeMake(SCREEN_WIDTH/3.0,  SCREEN_WIDTH/3.0+30);
        }
            break;
        case 4:{
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
            UICollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"CollectOneCellreuse" forIndexPath:indexPath];
            CGFloat height = cell.contentView.frame.size.height;
            cell.backgroundColor = [UIColor whiteColor];
            if (label1) {
                [label1 removeFromSuperview];
            }
            label1 = [[UILabel alloc]init];
            label1.font = [UIFont boldSystemFontOfSize:17];
            label1.text = @"身份证照片(必填,三张照片)";
            label1.textColor = WORD_FONT_COLOR;
            label1.textAlignment = NSTextAlignmentLeft;
            label1.backgroundColor = [UIColor clearColor];
            label1.frame = CGRectMake(10, (height-20)/2.0, SCREEN_WIDTH-20, 20);
            [cell addSubview:label1];
            
            UIView *line = [Gobal drawSolidLinePointX:10 PointY:CGRectGetMaxY(label1.frame)+9 lineW:SCREEN_WIDTH-20 lineH:1.0 lineColor:@[@"220",@"220",@"220"] lineAlpha:1.0];
            [cell addSubview:line];
            
            return cell;
        }
            break;
        case 1:{
            PhotoCollectionCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"PhotoCollectionCellreuse" forIndexPath:indexPath];
            cell.backgroundColor = [UIColor whiteColor];
            NSArray *arr = @[@"身份证正面",@"身份证反面",@"手持身份证"];
            NSArray *img = @[@"IdCardFront_icon",@"IdOpposite_icon",@"HoldIdentity_icon"];
            cell.ID_imgV.image = [UIImage imageNamed:img[indexPath.item]];
            cell.text_label.text = arr[indexPath.item];

            switch (indexPath.item) {
                case 0:{
                    if ([Gobal isEmptyNull:image_1]) {
                        [cell.ID_imgV sd_setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@%@",IMGURLIP,_photoAuthModel.idCardFrontUrl]] placeholderImage:[UIImage imageNamed:@"IdCardFront_icon"]];
                        
                    }else {
                        cell.ID_imgV.image = image_1;
                    }
                }
                    break;
                case 1:{
                    if ([Gobal isEmptyNull:image_2]) {
                        [cell.ID_imgV sd_setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@%@",IMGURLIP,_photoAuthModel.idCardBackUrl]] placeholderImage:[UIImage imageNamed:@"IdOpposite_icon"]];
                        
                    }else {
                        cell.ID_imgV.image = image_2;
                    }
                }
                    break;
                case 2:{
                    if ([Gobal isEmptyNull:image_3]) {
                        [cell.ID_imgV sd_setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@%@",IMGURLIP,_photoAuthModel.idCardHandHeldUrl]] placeholderImage:[UIImage imageNamed:@"HoldIdentity_icon"]];
                        
                    }else {
                        cell.ID_imgV.image = image_3;
                        
                    }
                }
                    break;

                default:
                    break;
            }
            return cell;
        }
            break;
        case 2:{
            UICollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"CollectThreeCellreuse" forIndexPath:indexPath];
            CGFloat height = cell.contentView.frame.size.height;
            cell.backgroundColor = [UIColor whiteColor];
            if (label2) {
                [label2 removeFromSuperview];
            }
            label2 = [[UILabel alloc]init];
            label2.font = [UIFont boldSystemFontOfSize:17];
            label2.text = @"工作证明照片";
            label2.textColor = WORD_FONT_COLOR;
            label2.textAlignment = NSTextAlignmentLeft;
            label2.backgroundColor = [UIColor clearColor];
            label2.frame = CGRectMake(10, (height-20)/2.0, SCREEN_WIDTH-20, 20);
            [cell addSubview:label2];
            
            UIView *line = [Gobal drawSolidLinePointX:10 PointY:CGRectGetMaxY(label2.frame)+9 lineW:SCREEN_WIDTH-20 lineH:1.0 lineColor:@[@"220",@"220",@"220"] lineAlpha:1.0];
            [cell addSubview:line];

            return cell;
        }
            break;
        case 3:{
            PhotoCollectionTwoCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"PhotoCollectionTwoCellreuse" forIndexPath:indexPath];
            cell.backgroundColor = [UIColor whiteColor];
            NSArray *img = @[@"StudentCertification_icon",@"EmployeeCard_icon",@""];
            cell.ID_imgV.image =  [UIImage imageNamed:img[indexPath.item]];

            switch (indexPath.item) {
                case 0:{
                    cell.ID_imgV.hidden = NO;
                    cell.text_label.hidden = NO;
                    cell.text_label.text = @"工作证明(必填)";
                    if ([Gobal isEmptyNull:image_4]) {
                        [cell.ID_imgV sd_setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@%@",IMGURLIP,_photoAuthModel.studentCardJobCardUrl]] placeholderImage:[UIImage imageNamed:@"StudentCertification_icon"]];
                        
                    }else {
                        cell.ID_imgV.image = image_4;
                    }
                }
                    break;
                case 1:{
                    cell.ID_imgV.hidden = NO;
                    cell.text_label.hidden = NO;
                    cell.text_label.text = @"财力证明(非必填)";
                    if ([Gobal isEmptyNull:image_5]) {
                        [cell.ID_imgV sd_setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@%@",IMGURLIP,_photoAuthModel.schoolPageJobCardUrl]] placeholderImage:[UIImage imageNamed:@"EmployeeCard_icon"]];
                        
                    }else {
                        cell.ID_imgV.image = image_5;
                        
                    }
                }
                    break;
                case 2:{
                    cell.ID_imgV.hidden = YES;
                    cell.text_label.hidden = YES;
                }
                    break;
                default:
                    break;
            }
            return cell;
        }
            break;
        case 4:{
            UICollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"CollectFourCellreuse" forIndexPath:indexPath];
            cell.backgroundColor = [UIColor clearColor];
            if (label3) {
                [label3 removeFromSuperview];
            }
            label3 = [[UILabel alloc]init];
            label3.font = [UIFont systemFontOfSize:13];
            label3.text = @"*工作证明照片可以是：工牌名片、社保单、税单、单位开的证明或其他证明，该项是必填项；\n*财力证明照片可以是：保险单、房产证、行驶证，该项是非必填项；";
            label3.textColor = TITLE_FONT_COLOR;
            label3.textAlignment = NSTextAlignmentLeft;
            label3.backgroundColor = [UIColor clearColor];
            label3.numberOfLines = 0;
            label3.frame = CGRectMake(10, 0, SCREEN_WIDTH-20, 80);
            [cell addSubview:label3];
            
            return cell;
        }
            break;
 
        default:
            break;
    }
    return nil;
}


-(void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {

    switch (indexPath.section) {
        case 1:{
            switch (indexPath.item) {
                case 0:{
                    index_path_row = 0;
                    sheet = [[UIActionSheet alloc]initWithTitle:nil delegate:self cancelButtonTitle:@"取消" destructiveButtonTitle:nil otherButtonTitles:@"从相机拍下照片", nil];
                    [sheet showInView:self.view];
                }
                    break;
                case 1:{
                    index_path_row = 1;
                    sheet = [[UIActionSheet alloc]initWithTitle:nil delegate:self cancelButtonTitle:@"取消" destructiveButtonTitle:nil otherButtonTitles:@"从相机拍下照片", nil];
                    [sheet showInView:self.view];
                }
                    break;
                case 2:{
                    index_path_row = 2;
                    sheet = [[UIActionSheet alloc]initWithTitle:nil delegate:self cancelButtonTitle:@"取消" destructiveButtonTitle:nil otherButtonTitles:@"从相机拍下照片", nil];
                    [sheet showInView:self.view];
                }
                    break;
                default:
                    break;
            }
            
        }
            break;
        case 3:{
            switch (indexPath.item) {
                case 0:{
                    index_path_row = 3;
                    sheet = [[UIActionSheet alloc]initWithTitle:nil delegate:self cancelButtonTitle:@"取消" destructiveButtonTitle:nil otherButtonTitles:@"从相机拍下照片", nil];
                    [sheet showInView:self.view];
                }
                    break;
                case 1:{
                    index_path_row = 4;
                    sheet = [[UIActionSheet alloc]initWithTitle:nil delegate:self cancelButtonTitle:@"取消" destructiveButtonTitle:nil otherButtonTitles:@"从相机拍下照片", nil];
                    [sheet showInView:self.view];
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
#pragma mark -- Event/上传照片
- (void)actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex {
    if (buttonIndex == 0) {
        [self pickPhoto:UIImagePickerControllerSourceTypeCamera];
    }
}
- (void)pickPhoto:(UIImagePickerControllerSourceType)sourceType{
    
    UIImagePickerController *picker = [[UIImagePickerController alloc]init];
    picker.delegate = self;
    picker.sourceType = sourceType;
    picker.allowsEditing = NO;
    picker.videoQuality = UIImagePickerControllerQualityTypeLow;
    [self presentViewController:picker animated:YES completion:nil];
    
}
#pragma mark -- delegate/UIImagePickerControllerDelegate
-(void)imagePickerControllerDidCancel:(UIImagePickerController *)picker{
    [picker dismissViewControllerAnimated:YES completion:nil];
}
- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info{
    [picker dismissViewControllerAnimated:YES completion:nil];
        
    switch (index_path_row) {
        case 0:{
            image_1 = [info objectForKey:UIImagePickerControllerOriginalImage];
            NSData *ImageData = UIImageJPEGRepresentation(image_1, 0.6);
            [self identityAuthenticationDataRequest:ImageData indexRowPath:0];
        }
            break;
        case 1:{
            image_2 = [info objectForKey:UIImagePickerControllerOriginalImage];
            NSData *ImageData = UIImageJPEGRepresentation(image_2, 0.6);
            [self identityAuthenticationDataRequest:ImageData indexRowPath:1];
        }
            break;
        case 2:{
            image_3 = [info objectForKey:UIImagePickerControllerOriginalImage];
            NSData *ImageData = UIImageJPEGRepresentation(image_3, 0.6);
            [self identityAuthenticationDataRequest:ImageData indexRowPath:2];
        }
            break;
        case 3:{
            image_4 = [info objectForKey:UIImagePickerControllerOriginalImage];
            NSData *ImageData = UIImageJPEGRepresentation(image_4, 0.6);
            [self identityAuthenticationDataRequest:ImageData indexRowPath:3];
        }
            break;
        case 4:{
            image_5 = [info objectForKey:UIImagePickerControllerOriginalImage];
            NSData *ImageData = UIImageJPEGRepresentation(image_5, 0.6);
            [self identityAuthenticationDataRequest:ImageData indexRowPath:4];
        }
            break;
        default:
            break;
    }
    
    [collection reloadData];
}
#pragma mark - Event
#pragma mark -- Event/保存
- (void)saveBtnAction {
    save_Btn.enabled = NO;
    [save_Btn setTitle:@"申请中..." forState:UIControlStateNormal];
    [self photoSaveDataRequest];
}
#pragma mark - Data
#pragma mark -- Data/查看是否有照片
- (void)checkWhetherPhotoDataRequest {
    
    NSString *user_Id = [Gobal loadAppSetting:BASE_KEY_memberId];
    NSDictionary *parameters = @{
                                 @"userId" : [Gobal isEmptyString:user_Id]?@"":user_Id,
                                 };
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    manager.responseSerializer.acceptableContentTypes = [NSSet setWithObject:@"text/plain"];
    [manager POST:PUBLIC_URL(PHOTO) parameters:parameters success:^(AFHTTPRequestOperation *operation,id responseObject) {
        NSLog(@"photo_success: %@", responseObject);
        if ([responseObject[@"status"] isEqualToString:@"100"]) {
            _photoAuthModel = [PhotoAuthModel dataWithJsonDictionary:responseObject[@"data"]];
        }else {
            _photoAuthModel = [PhotoAuthModel dataWithJsonDictionary:responseObject[@"data"]];
        }
        [collection reloadData];
    }failure:^(AFHTTPRequestOperation *operation,NSError *error) {
        [CustomHUD createShowContent:@"网络链接失败,请检查是否链接网络" hiddenTime:2.4];
    }];
}
#pragma mark -- Data/身份认证上传
- (void)identityAuthenticationDataRequest:(NSData *)imgData indexRowPath:(NSInteger)index_item{
    NSString *user_Id = [Gobal loadAppSetting:BASE_KEY_memberId];
    //uploadType 1.用户头像上传
    NSDictionary *parameters = @{
                                 @"userId" : [Gobal isEmptyString:user_Id]?@"":user_Id,
                                 @"uploadType" :@"2",
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
        NSLog(@"UPLOADFILE_responseObject == %@",responseObject);
        if ([responseObject[@"status"] isEqualToString:@"100"]) {
            
            switch (index_item) {
                case 0:{ //身份正面
                    NSString *photo_url_Img = responseObject[@"data"] [@"url"];
                    [Gobal saveAppSetting:photo_url_Img Key:BASE_KEY_AS_POSITIVE];
                }
                    break;
                case 1:{//身份反面
                    NSString *photo_url_Img = responseObject[@"data"] [@"url"];
                    [Gobal saveAppSetting:photo_url_Img Key:BASE_KEY_IDENTITY_OPPOSITE];
                }
                    break;
                case 2:{//手拿身份
                    NSString *photo_url_Img = responseObject[@"data"] [@"url"];
                    [Gobal saveAppSetting:photo_url_Img Key:BASE_KEY_HOLDING_IDENTITY];
                }
                    break;
                case 3:{//学生证明
                    NSString *photo_url_Img = responseObject[@"data"] [@"url"];
                    [Gobal saveAppSetting:photo_url_Img Key:BASE_KEY_STUDENT_ID];
                }
                    break;
                case 4:{//学籍证明
                    NSString *photo_url_Img = responseObject[@"data"] [@"url"];
                    [Gobal saveAppSetting:photo_url_Img Key:BASE_KEY_STUDENT_PROOF];
                }
                    break;

                default:
                    break;
            }
        
        }else{
            [CustomHUD createShowContent:responseObject[@"message"] hiddenTime:2.4];
        }
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        [CustomHUD createShowContent:@"网络链接失败,请检查是否链接网络" hiddenTime:2.4];
    }];
}
#pragma mark -- Data/保存照片
- (void)photoSaveDataRequest {
    [CustomHUD createHudCustomShowContent:@"请稍等..."];

    NSString *user_Id = [Gobal loadAppSetting:BASE_KEY_memberId];
    NSString *idCardFront_URL = [Gobal isEmptyString:[Gobal loadAppSetting:BASE_KEY_AS_POSITIVE]]?[Gobal isEmptyString:_photoAuthModel.idCardFrontUrl]?@"":_photoAuthModel.idCardFrontUrl:[Gobal loadAppSetting:BASE_KEY_AS_POSITIVE];
    NSString *idCardBack_URL = [Gobal isEmptyString:[Gobal loadAppSetting:BASE_KEY_IDENTITY_OPPOSITE]]?[Gobal isEmptyString:_photoAuthModel.idCardBackUrl]?@"":_photoAuthModel.idCardBackUrl:[Gobal loadAppSetting:BASE_KEY_IDENTITY_OPPOSITE];
    NSString *idCardHandHeld_URL = [Gobal isEmptyString:[Gobal loadAppSetting:BASE_KEY_HOLDING_IDENTITY]]?[Gobal isEmptyString:_photoAuthModel.idCardHandHeldUrl]?@"":_photoAuthModel.idCardHandHeldUrl:[Gobal loadAppSetting:BASE_KEY_HOLDING_IDENTITY];
    NSString *studentCardJobCard_URL = [Gobal isEmptyString:[Gobal loadAppSetting:BASE_KEY_STUDENT_ID]]?[Gobal isEmptyString:_photoAuthModel.studentCardJobCardUrl]?@"":_photoAuthModel.studentCardJobCardUrl:[Gobal loadAppSetting:BASE_KEY_STUDENT_ID];
    NSString *schoolPageJobCard_URL = [Gobal isEmptyString:[Gobal loadAppSetting:BASE_KEY_STUDENT_PROOF]]?[Gobal isEmptyString:_photoAuthModel.schoolPageJobCardUrl]?@"":_photoAuthModel.schoolPageJobCardUrl:[Gobal loadAppSetting:BASE_KEY_STUDENT_PROOF];

    NSDictionary *parameters = @{
                                 @"id" : [Gobal isEmptyString:_photoAuthModel.Id]?@"": _photoAuthModel.Id,
                                 @"memberInfoId" : [Gobal isEmptyString:user_Id]?@"":user_Id,
                                 @"idCardFrontUrl": idCardFront_URL,
                                 @"idCardBackUrl" :idCardBack_URL,
                                 @"idCardHandHeldUrl" :idCardHandHeld_URL,
                                 @"studentCardJobCardUrl" :studentCardJobCard_URL,
                                 @"schoolPageJobCardUrl" :schoolPageJobCard_URL,
                                 };
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    manager.responseSerializer.acceptableContentTypes = [NSSet setWithObject:@"text/plain"];
    [manager POST:PUBLIC_URL(PHOTOSAVE) parameters:parameters success:^(AFHTTPRequestOperation *operation,id responseObject) {
        NSLog(@"photo_success: %@", responseObject);
        save_Btn.enabled = YES;
        [save_Btn setTitle:@"确认" forState:UIControlStateNormal];

        if ([responseObject[@"status"] isEqualToString:@"100"]) {
            
            [Gobal saveAppSetting:@"" Key:BASE_KEY_AS_POSITIVE];
            [Gobal saveAppSetting:@"" Key:BASE_KEY_IDENTITY_OPPOSITE];
            [Gobal saveAppSetting:@"" Key:BASE_KEY_HOLDING_IDENTITY];
            [Gobal saveAppSetting:@"" Key:BASE_KEY_STUDENT_ID];
            [Gobal saveAppSetting:@"" Key:BASE_KEY_STUDENT_PROOF];

            [CustomHUD createShowContent:@"保存成功" hiddenTime:2.4];
            [self popBack];
            
        }else {
            [CustomHUD createShowContent:responseObject[@"message"] hiddenTime:2.4];
        }
        [collection reloadData];
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
