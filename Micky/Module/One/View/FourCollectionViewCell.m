//
//  FourCollectionViewCell.m
//  MickyEasyCredit
//
//  Created by 张宁 on 2017/5/3.
//  Copyright © 2017年 apple. All rights reserved.
//

#import "FourCollectionViewCell.h"
#import "AppDelegate.h"
@implementation FourCollectionViewCell
@synthesize show;
@synthesize click_btn;
-(instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = BASE_COLOR_LINE;
        
        show = [[UIView alloc]init];
        show.backgroundColor = [UIColor whiteColor];
        show.frame = CGRectMake(0, 0, SCREEN_WIDTH, 80);
        [self.contentView addSubview:show];
        
//        NSArray *title_A = @[@"我要借款",@"费用查询",@"进度查询"];
//        NSArray *image_A = @[@"home_jeeplus_one",@"home_feiyong_three",@"home_jindu_four"];
//        CGFloat w = (SCREEN_WIDTH-210)/4.0;
//        
//        for (int i = 0; i<3; i++) {
//            
//            click_btn = [UIButton buttonWithType:UIButtonTypeCustom];
//            click_btn.frame = CGRectMake(w+(70+w)*i, 2, 70, 75);
//            click_btn.titleLabel.font = [UIFont systemFontOfSize:12];
//            [click_btn setTitle:title_A[i] forState:UIControlStateNormal];
//            [click_btn setTitleColor:TITLE_FONT_COLOR forState:UIControlStateNormal];
//            [click_btn setImage:[UIImage imageNamed:image_A[i]] forState:UIControlStateNormal];
//            [click_btn setTitleEdgeInsets:UIEdgeInsetsMake(25, -35, -20, 0)];
//            [click_btn setImageEdgeInsets:UIEdgeInsetsMake(-10, 10, 10, -10)];
//            [click_btn setBackgroundImage:[Gobal imageWithColor:[UIColor clearColor] size:click_btn.frame.size] forState:UIControlStateNormal];
//            [click_btn setBackgroundImage:[Gobal imageWithColor:RGBColor(235, 235, 235) size:click_btn.frame.size] forState:UIControlStateHighlighted];
//            [click_btn addTarget:self action:@selector(clickBtnAction:) forControlEvents:UIControlEventTouchUpInside];
//            click_btn.tag = i;
//            [self.contentView addSubview:click_btn];
//            
//        }
        
        NSArray *title_A = @[@"我要借款",@"我要还款",@"费用查询",@"进度查询"];
        NSArray *image_A = @[@"home_jeeplus_one",@"home_fankuan_two",@"home_feiyong_three",@"home_jindu_four"];
        CGFloat w = (SCREEN_WIDTH-280)/5.0;
        
        for (int i = 0; i<4; i++) {
            
            click_btn = [UIButton buttonWithType:UIButtonTypeCustom];
            click_btn.frame = CGRectMake(w+(70+w)*i, 2, 70, 75);
            click_btn.titleLabel.font = [UIFont systemFontOfSize:12];
            [click_btn setTitle:title_A[i] forState:UIControlStateNormal];
            [click_btn setTitleColor:TITLE_FONT_COLOR forState:UIControlStateNormal];
            [click_btn setImage:[UIImage imageNamed:image_A[i]] forState:UIControlStateNormal];
            [click_btn setTitleEdgeInsets:UIEdgeInsetsMake(25, -35, -20, 0)];
            [click_btn setImageEdgeInsets:UIEdgeInsetsMake(-10, 10, 10, -10)];
            [click_btn setBackgroundImage:[Gobal imageWithColor:[UIColor clearColor] size:click_btn.frame.size] forState:UIControlStateNormal];
            [click_btn setBackgroundImage:[Gobal imageWithColor:RGBColor(235, 235, 235) size:click_btn.frame.size] forState:UIControlStateHighlighted];
            [click_btn addTarget:self action:@selector(clickBtnAction:) forControlEvents:UIControlEventTouchUpInside];
            click_btn.tag = i;
            [self.contentView addSubview:click_btn];
            
        }
    }
    return self;
}
- (void)clickBtnAction:(UIButton *)sender {
    if ([self.delegate respondsToSelector:@selector(selectJeeplusStyle:)]) {
        [self.delegate selectJeeplusStyle:sender.tag];
    }
    NSLog(@"clickBtnAction == %ld",sender.tag);
}



@end
