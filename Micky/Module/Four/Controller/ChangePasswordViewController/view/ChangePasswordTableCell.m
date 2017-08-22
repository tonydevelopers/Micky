//
//  ChangePasswordTableCell.m
//  MickyEasyCredit
//
//  Created by 张宁 on 2017/4/7.
//  Copyright © 2017年 apple. All rights reserved.
//

#import "ChangePasswordTableCell.h"

@implementation ChangePasswordTableCell

@synthesize showview;
@synthesize field;

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        self.backgroundColor = BASE_COLOR_LINE;
        CGFloat height = self.frame.size.height;
        
        showview = [[UIView alloc]init];
        showview.backgroundColor = [UIColor whiteColor];
        showview.frame = CGRectMake(0, 0, SCREEN_WIDTH, height-1);
        [self.contentView addSubview:showview];
        
        field=[[UITextField alloc] init];
        field.frame = CGRectMake(15, 0, CGRectGetWidth(showview.frame), CGRectGetHeight(showview.frame));
        field.borderStyle = UITextBorderStyleNone;
        [field setBackgroundColor:[UIColor clearColor]];
        [field setTextColor:WORD_FONT_COLOR];
        field.textAlignment = NSTextAlignmentLeft;
        field.font = [UIFont systemFontOfSize:15];
        field.placeholder = @"";
        [showview addSubview:field];

        
    }
    return self;
}
- (void)setFieldPlaceholder:(NSString *)place {

    field.placeholder = place;

}
- (void)layoutSubviews {
    [super layoutSubviews];
    CGFloat height = self.frame.size.height;
    showview.frame = CGRectMake(0, 0, SCREEN_WIDTH, height-0.5);
    field.frame = CGRectMake(15, 0, CGRectGetWidth(showview.frame)-25, CGRectGetHeight(showview.frame));

}


@end
