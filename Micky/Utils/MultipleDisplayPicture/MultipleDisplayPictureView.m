//
//  MultipleDisplayPictureView.m
//  shopMall
//
//  Created by mosjoydev6 on 16/8/8.
//  Copyright © 2016年 Mosjoy. All rights reserved.
//

#define DELETE_INDEX_NOTIFICATION @"deleteIndexNotification"

#import "MultipleDisplayPictureView.h"
#import "MultipleDisplayPictureCell.h"

#import "UIButton+Extension.h"

#import "AppDelegate.h"

@interface MultipleDisplayPictureView ()<UICollectionViewDelegate,UICollectionViewDataSource,UIActionSheetDelegate,UIImagePickerControllerDelegate,UINavigationControllerDelegate,UIAlertViewDelegate>

@property (nonatomic, assign) NSInteger maxNumberOfPicture;
@property (nonatomic, assign) NSInteger defaultMaxNumberOfPicture;
@property (nonatomic, assign) CGSize defaultPictureSize;
@property (nonatomic, assign) CGRect selfFrame;

@property (nonatomic, assign) BOOL isAdd;               //是不是处于有加好的状态
@property (nonatomic, assign) __block NSInteger deleteIndex;    //要删除的下标

@property (nonatomic, strong) NSMutableArray *images;   //图片数组


@property (nonatomic, strong) UICollectionView *collectionView;



@end

static NSString *const identifier = @"MultipleDisplayPictureCell";

@implementation MultipleDisplayPictureView

-(instancetype)init
{
    NSAssert(NO, @"You should never call this method in this class. You should use initwithframe: method to create!!!");
    return nil;
}

-(instancetype)initWithFrame:(CGRect)frame
{
    _selfFrame = frame;
    [self calculateDefaultPictureSizeAndMaxNumberOfPicture];
    
    return [self initWithFrame:frame maxNumberOfPicture:_maxNumberOfPicture];
}

-(instancetype)initWithFrame:(CGRect)frame maxNumberOfPicture:(NSInteger)maxNumberOfPicture
{
    if (self = [super initWithFrame:frame]) {
        _selfFrame = frame;
        _isAdd = YES;
        
        [self calculateDefaultPictureSizeAndMaxNumberOfPicture];
        
        _maxNumberOfPicture = maxNumberOfPicture;
        
        [self initCollectionView];
        
        
    }
    return self;
}

-(void)initCollectionView
{
    UIImage *image = [UIImage imageNamed:@"store_icon_add"];
    _images = [NSMutableArray arrayWithObjects:image, nil];

    UICollectionViewFlowLayout *flowLayout = [[UICollectionViewFlowLayout alloc]init];
    flowLayout.sectionInset = UIEdgeInsetsMake(10, 10, 10, 10);
    flowLayout.itemSize = _defaultPictureSize;
    flowLayout.scrollDirection = UICollectionViewScrollDirectionHorizontal;
    flowLayout.minimumLineSpacing = 10;
    flowLayout.minimumInteritemSpacing = 5;
//    flowLayout.scrollDirection = UICollectionViewScrollDirectionHorizontal;
    
    _collectionView = [[UICollectionView alloc]initWithFrame:CGRectMake(0, 0, _selfFrame.size.width, _selfFrame.size.height) collectionViewLayout:flowLayout];
    _collectionView.backgroundColor = [UIColor clearColor];
    _collectionView.delegate = self;
    _collectionView.dataSource = self;
    [self addSubview:_collectionView];
    
    [_collectionView registerNib:[UINib nibWithNibName:@"MultipleDisplayPictureCell" bundle:nil] forCellWithReuseIdentifier:identifier];
    
}

#pragma mark - collectionView Delegate && dataSource
-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    
    return _images.count;
}

-(UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    
    MultipleDisplayPictureCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:identifier forIndexPath:indexPath];
    
    cell.deletePic.tag = indexPath.item + 1;
    cell.add.tag = indexPath.item + 11;
    cell.addImage = _addPlaceholderImage;
    
    
    cell.deletePictureBlock = ^(NSInteger tag){
        NSLog(@"delete tag = %ld",(long)tag);
        _deleteIndex = tag - 1;
        
        UIAlertView *alertView = [[UIAlertView alloc]initWithTitle:@"提示" message:@"是否要删除图片" delegate:self cancelButtonTitle:@"取消" otherButtonTitles:@"确定", nil];
        [alertView show];
        
    };
    
    __weak typeof(self) weakSelf = self;
    cell.addPictureBlock = ^(NSInteger tag){
//        NSLog(@"add tag = %ld",(long)tag);
        [weakSelf shareActionSheet];
    };
    
    
//    UIImage *image = [UIImage imageNamed:@"store_icon_add"];
    
    if ((indexPath.item == _images.count - 1) && _isAdd == YES) {//最后一个cell并且image是加号
        cell.isLast = _isAdd;
    }else if ((indexPath.item == _images.count - 1) && _isAdd == NO){//最后一个cell并且image不是加号
        cell.picture = (UIImage *)_images[indexPath.item];
        cell.isLast = _isAdd;
    }else if ((indexPath.item != _images.count - 1)){//不是最后一个cell
        cell.picture = (UIImage *)_images[indexPath.item];
        cell.isLast = NO;
    }
    
    return cell;
}

#pragma mark - support method
-(void)shareActionSheet
{
    UIActionSheet *asheet = [[UIActionSheet alloc] initWithTitle:nil
                                                        delegate:self
                                               cancelButtonTitle:@"取消"
                                          destructiveButtonTitle:nil
                                               otherButtonTitles:@"从相机拍下照片", @"从手机图片库取照片", nil];
    [asheet showInView:[self superview]];
}

- (void)pickPhoto:(UIImagePickerControllerSourceType)sourceType{
    UIImagePickerController *picker = [[UIImagePickerController alloc]init];
    picker.delegate = self;
    picker.sourceType = sourceType;
    picker.allowsEditing = YES;
    picker.videoQuality = UIImagePickerControllerQualityTypeLow;
    
//    NSLog(@".keyWindow.rootViewController = %@",[UIApplication sharedApplication].keyWindow.rootViewController);
    
//    [[self getCurrentVC] presentViewController:picker animated:YES completion:nil];
    [[AppDelegate getInstance].CurNavController presentViewController:picker animated:YES completion:nil];
  
}

//获取当前屏幕显示的viewcontroller
- (UIViewController *)getCurrentVC
{
    UIViewController *result = nil;
    
    UIWindow * window = [[UIApplication sharedApplication] keyWindow];
    if (window.windowLevel != UIWindowLevelNormal)
    {
        NSArray *windows = [[UIApplication sharedApplication] windows];
        for(UIWindow * tmpWin in windows)
        {
            if (tmpWin.windowLevel == UIWindowLevelNormal)
            {
                window = tmpWin;
                break;
            }
        }
    }
    
    UIView *frontView = [[window subviews] objectAtIndex:0];
    id nextResponder = [frontView nextResponder];
    
    if ([nextResponder isKindOfClass:[UIViewController class]])
        result = nextResponder;
    else
        result = window.rootViewController;
    
    return result;
}

-(void)deletePicture
{
    
}

#pragma mark -- delegate/UIActionSheetDelegate
- (void)actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex{
    
    NSString *buttonTitle = [actionSheet buttonTitleAtIndex:buttonIndex];
    if ([buttonTitle isEqualToString:@"从相机拍下照片"]){
        [self pickPhoto:UIImagePickerControllerSourceTypeCamera];
    }
    else if ([buttonTitle isEqualToString:@"从手机图片库取照片"]){
        [self pickPhoto:UIImagePickerControllerSourceTypePhotoLibrary];
    }
//    [BindingBankCreditTable reloadData];
}



#pragma mark -- delegate/UIImagePickerControllerDelegate
-(void)imagePickerControllerDidCancel:(UIImagePickerController *)picker{
    [picker dismissViewControllerAnimated:YES completion:nil];
}

- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info{
    [picker dismissViewControllerAnimated:YES completion:nil];
    UIImage *image = [info objectForKey:UIImagePickerControllerEditedImage];
    if (_images.count == _maxNumberOfPicture) {
        [_images replaceObjectAtIndex:_images.count - 1 withObject:image];
        _isAdd = NO;
    }else{
        [_images insertObject:image atIndex:_images.count - 1];
    }
    
    /**  如果有需要的话 会通过这里传出没添加一张图片就告诉外边这里有多少个图片 */
    if ([_delegate respondsToSelector:@selector(imagesCount:maxNumber:)]) {
        if (_isAdd == YES) {
            [_delegate imagesCount:_images.count - 1 maxNumber:_maxNumberOfPicture];
        }else{
            [_delegate imagesCount:_images.count maxNumber:_maxNumberOfPicture];
        }
    }
    
    [_collectionView reloadData];
//    NSIndexPath *indexPath = [NSIndexPath indexPathForItem:_images.count - 1 inSection:0];
//    [_collectionView insertItemsAtIndexPaths:@[indexPath]];
}

#pragma mark - alertView Delegate
-(void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
//    NSLog(@"buttonIndex = %ld",(long)buttonIndex);
//    NSLog(@"deleteIndex = %ld",(long)_deleteIndex);
    if (buttonIndex == 1) {//确定
        if (_images.count == _maxNumberOfPicture && _isAdd == NO) {
            [_images removeObjectAtIndex:_deleteIndex];
            [_images addObject:@"1"];
        }else{
            [_images removeObjectAtIndex:_deleteIndex];
        }
        _deleteIndex = -1;

        if (_isAdd == NO) {
            _isAdd = YES;
        }
        
        /**  如果有需要的话 会通过这里传出没添加一张图片就告诉外边这里有多少个图片 */
        if ([_delegate respondsToSelector:@selector(imagesCount:maxNumber:)]) {
            [_delegate imagesCount:_images.count - 1 maxNumber:_maxNumberOfPicture];
        }
        
        [_collectionView reloadData];
    }
}


#pragma mark - calculate method
-(void)calculateDefaultPictureSizeAndMaxNumberOfPicture
{
//    CGFloat selfWidth = _selfFrame.size.width;
    CGFloat pictureWH = _selfFrame.size.height - 20;
    _defaultPictureSize = CGSizeMake(pictureWH *4/5, pictureWH);
    if (_maxNumberOfPicture == 0) {
        _maxNumberOfPicture = 6;
    }
}

#pragma mark - outsize methods
-(NSArray<UIImage *> *)getResultImages
{
    if (!_isAdd) return _images;
    
    NSMutableArray *tempImages = [NSMutableArray new];
    for (int i = 0; i < _images.count; i++) {
        if (i == _images.count - 1) break;
        
        [tempImages addObject:_images[i]];
    }
    return tempImages;
}

-(void)setAddPlaceholderImage:(id)addPlaceholderImage
{
    //如果图片为空
    if (addPlaceholderImage == nil || [addPlaceholderImage isKindOfClass:[NSNull class]]) return;
    //图片名字为空
    if ([addPlaceholderImage isKindOfClass:[NSString class]]) {if ([addPlaceholderImage isEqualToString:@""]) return;}
    
    _addPlaceholderImage = addPlaceholderImage;
    [_collectionView reloadData];
}

@end
