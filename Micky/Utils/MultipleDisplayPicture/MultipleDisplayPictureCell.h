//
//  MultipleDisplayPictureCell.h
//  shopMall
//
//  Created by mosjoydev6 on 16/8/9.
//  Copyright © 2016年 Mosjoy. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void(^DeletePictureBlock)(NSInteger tag);
typedef void(^AddPictureBlock)(NSInteger tag);

@interface MultipleDisplayPictureCell : UICollectionViewCell
@property (weak, nonatomic) IBOutlet UIImageView *image;
@property (weak, nonatomic) IBOutlet UIButton *deletePic;
@property (weak, nonatomic) IBOutlet UIButton *add;

@property (nonatomic, copy) DeletePictureBlock deletePictureBlock;
@property (nonatomic, copy) AddPictureBlock addPictureBlock;

@property (nonatomic, assign) BOOL isLast; //是不是最后

@property (nonatomic, strong) UIImage *picture;

@property (nonatomic, strong) id addImage;



@end
