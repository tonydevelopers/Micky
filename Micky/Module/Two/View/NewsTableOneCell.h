//
//  NewsTableOneCell.h
//  MickyEasyCredit
//
//  Created by 张宁 on 2017/4/6.
//  Copyright © 2017年 apple. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "NewsModel.h"

@interface NewsTableOneCell : UITableViewCell

@property(nonatomic,strong)UIView *BGView;
@property(nonatomic,strong)UILabel *title_Label;
@property(nonatomic,strong)UILabel *content_Label;
@property(nonatomic,strong)UILabel *time_Label;
@property(nonatomic,strong)NewsModel *newsModel;

-(void)setNewsModel:(NewsModel *)newsModel;
- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier;

@end
