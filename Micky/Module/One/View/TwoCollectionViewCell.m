//
//  TwoCollectionViewCell.m
//  MickyEasyCredit
//
//  Created by 张宁 on 2017/5/3.
//  Copyright © 2017年 apple. All rights reserved.
//

#import "TwoCollectionViewCell.h"

@implementation TwoCollectionViewCell
@synthesize show_ImageV;
- (instancetype)initWithFrame:(CGRect)frame {
    self =[super initWithFrame:frame];
    if (self) {
        
        self.contentView.backgroundColor = [UIColor whiteColor];
        
        show_ImageV = [[UIImageView alloc]init];
        show_ImageV.frame = CGRectMake(10, 10, SCREEN_WIDTH/2.0-20,100);
        show_ImageV.backgroundColor = [UIColor clearColor];
        show_ImageV.image = [UIImage imageNamed:@"right_home"];
        show_ImageV.layer.cornerRadius = 5;
        show_ImageV.layer.masksToBounds = YES;
        [self.contentView addSubview:show_ImageV];
        
    }
    return self;
}
- (void)setShowImageV:(NSString *)showImageV imdexRow:(NSInteger)index {
    show_ImageV.image = [UIImage imageNamed:showImageV];
    switch (index) {
        case 0:{
            show_ImageV.frame = CGRectMake(10, 10, SCREEN_WIDTH/2.0-15,105);
        }
            break;
        case 1:{
            show_ImageV.frame = CGRectMake(5, 10, SCREEN_WIDTH/2.0-15,105);
            
        }
            break;
        default:
            break;
    }
    
    
}

@end
