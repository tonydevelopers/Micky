//
//  FourCollectionViewCell.h
//  MickyEasyCredit
//
//  Created by 张宁 on 2017/5/3.
//  Copyright © 2017年 apple. All rights reserved.
//

#import <UIKit/UIKit.h>


@protocol FourCollectionDelegate <NSObject>

- (void)selectJeeplusStyle:(NSInteger)btnTag;

@end

@interface FourCollectionViewCell : UICollectionViewCell

@property(nonatomic,assign)id<FourCollectionDelegate>delegate;
@property(nonatomic,strong)UIView *show;
@property(nonatomic,strong)UIButton *click_btn;

@end
