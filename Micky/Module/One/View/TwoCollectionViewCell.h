//
//  TwoCollectionViewCell.h
//  MickyEasyCredit
//
//  Created by 张宁 on 2017/5/3.
//  Copyright © 2017年 apple. All rights reserved.
//

#import <UIKit/UIKit.h>


@interface TwoCollectionViewCell : UICollectionViewCell

@property(nonatomic,strong)UIImageView *show_ImageV;
- (void)setShowImageV:(NSString *)showImageV imdexRow:(NSInteger)index;

@end
