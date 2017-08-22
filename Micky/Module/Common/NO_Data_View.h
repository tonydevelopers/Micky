//
//  NO_Data_View.h
//  MickyEasyCredit
//
//  Created by 张宁 on 2016/11/10.
//  Copyright © 2016年 apple. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface NO_Data_View : UIView

@property(nonatomic,strong)UIImageView *noDataImage;
@property(nonatomic,strong)UILabel *noneLabel;

- (void)noDataViewUpdate:(NSArray *)data_array;
- (instancetype)initWithFrame:(CGRect)frame noDataImage:(NSString *)image_name noneLabel:(NSString *)label_title;
@end
