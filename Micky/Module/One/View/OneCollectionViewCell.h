//
//  OneCollectionViewCell.h
//  MickyEasyCredit
//
//  Created by 张宁 on 2017/5/3.
//  Copyright © 2017年 apple. All rights reserved.
//

#import <UIKit/UIKit.h>
@class SXMarquee;
@interface OneCollectionViewCell : UICollectionViewCell

@property(nonatomic,strong)UIView *BGView;
@property(nonatomic,strong)UIView *showView;
@property(nonatomic,strong)UILabel *nameLabel;

@property(nonatomic,strong)UIImageView *ADImg;
@property(nonatomic,strong)SXMarquee *marqueeBar;

@end
