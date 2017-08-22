//
//  customeTableOneCell.m
//  MickyEasyCredit
//
//  Created by 张宁 on 2017/4/6.
//  Copyright © 2017年 apple. All rights reserved.
//

#import "customeTableOneCell.h"
//#import "QRCodeGenerator.h"
#import "AppDelegate.h"

@implementation customeTableOneCell
@synthesize longPressGestureRecognizer;
@synthesize recommended_Label;
@synthesize QRcode_imageV;

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        
        self.contentView.backgroundColor = BACKGROUND_COLOR;
    
        QRcode_imageV = [[UIImageView alloc]init];
        QRcode_imageV.frame = CGRectMake((SCREEN_WIDTH-180)/2.0, 20, 180, 180);
        QRcode_imageV.image = [UIImage imageNamed:@"QRCode"];
        QRcode_imageV.backgroundColor = [UIColor clearColor];
        QRcode_imageV.userInteractionEnabled = YES;
        [self.contentView addSubview:QRcode_imageV];
        
        recommended_Label = [[UILabel alloc]init];
        recommended_Label.frame = CGRectMake(10, CGRectGetMaxY(QRcode_imageV.frame)+5, SCREEN_WIDTH-20, 20);
        recommended_Label.backgroundColor = [UIColor clearColor];
        recommended_Label.text = @"扫描二维码关注我们";
        recommended_Label.textColor = WORD_FONT_COLOR;
        recommended_Label.font = [UIFont systemFontOfSize:15];
        recommended_Label.textAlignment = NSTextAlignmentCenter;
        [self.contentView addSubview:recommended_Label];
       
        longPressGestureRecognizer = [[UILongPressGestureRecognizer alloc] initWithTarget:self action:@selector(longPressToDo:)];
        longPressGestureRecognizer.minimumPressDuration = 1.0;
        [QRcode_imageV addGestureRecognizer:longPressGestureRecognizer];
        
    }
    return self;
}
- (void)setRecommended:(NSString *)RStr {

//    if ([Gobal isEmptyString:[Gobal loadAppSetting:BASE_KEY_myCode]]) {
//        QRcode_imageV.image = [UIImage imageNamed:@"QRCode"];
//    }else {
//        NSString *url_str = [Gobal loadAppSetting:BASE_KEY_myCode];
//        QRcode_imageV.image = [Gobal qrImageForString:url_str imageSize:QRcode_imageV.bounds.size.width];
//    }
    
}

#pragma mark -- 响应长按事件代码：
-(void)longPressToDo:(UILongPressGestureRecognizer *)gesture
{
    if(gesture.state == UIGestureRecognizerStateBegan) {
        
        if ([self.delegate respondsToSelector:@selector(longPressQRcodeAccordingToTheRecognition)]) {
            [self.delegate longPressQRcodeAccordingToTheRecognition];
        }
    }
}

@end
