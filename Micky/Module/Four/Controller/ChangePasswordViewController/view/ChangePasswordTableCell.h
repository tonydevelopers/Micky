//
//  ChangePasswordTableCell.h
//  MickyEasyCredit
//
//  Created by 张宁 on 2017/4/7.
//  Copyright © 2017年 apple. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ChangePasswordTableCell : UITableViewCell

@property(nonatomic,strong)UIView *showview;
@property(nonatomic,strong)UITextField *field;
- (void)setFieldPlaceholder:(NSString *)place;
- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier;

@end
