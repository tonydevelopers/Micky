//
//  MultipleDisplayPictureView.h
//  shopMall
//
//  Created by mosjoydev6 on 16/8/8.
//  Copyright © 2016年 Mosjoy. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol MultipleDisplayPictureViewDelegate <NSObject>
/** 每添加一张图片就告诉外边这里有多少个图片 以及最大图片数 */
-(void)imagesCount:(NSInteger)count maxNumber:(NSInteger)maxNumber;

@end

@interface MultipleDisplayPictureView : UIView

-(instancetype)initWithFrame:(CGRect)frame maxNumberOfPicture:(NSInteger)maxNumberOfPicture;

/**
 *  获取所有图片
 *
 *  @return 图片数组
 */
-(NSArray<UIImage *> *)getResultImages;

/**
 *  增加图片的占位图
 */
@property (nonatomic, strong) id addPlaceholderImage;

@property (nonatomic, weak) id<MultipleDisplayPictureViewDelegate>delegate;


@end
