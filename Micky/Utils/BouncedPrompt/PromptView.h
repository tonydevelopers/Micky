//
//  PromptView.h
//  MickyEasyCredit
//
//  Created by 张宁 on 16/10/10.
//  Copyright © 2016年  张宁. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface PromptView : UIView

@property(nonatomic,strong)UILabel *title_text;
@property(nonatomic,strong)UIImage *animate_image;

+(instancetype)sharePrompt;
-(void)show;
-(void)showPromptTitle:(NSString *)message;
-(void)showPromptTitle:(NSString *)message Secord:(CGFloat)time_date;

@end
