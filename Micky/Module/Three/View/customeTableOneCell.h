//
//  customeTableOneCell.h
//  MickyEasyCredit
//
//  Created by 张宁 on 2017/4/6.
//  Copyright © 2017年 apple. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol CustomeTableOneDelegate <NSObject>

- (void)longPressQRcodeAccordingToTheRecognition;

@end


@interface customeTableOneCell : UITableViewCell

@property(nonatomic,assign) id<CustomeTableOneDelegate>delegate;
@property(nonatomic,strong)UILongPressGestureRecognizer *longPressGestureRecognizer;
@property(nonatomic,strong)UILabel *recommended_Label;
@property(nonatomic,strong)UIImageView *QRcode_imageV;
- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier;
- (void)setRecommended:(NSString *)RStr;

@end
