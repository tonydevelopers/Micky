//
//  MyOrderView.h
//  MickyEasyCredit
//
//  Created by 张宁 on 16/10/9.
//  Copyright © 2016年  张宁. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MyOrderView : UIView

@property (nonatomic, strong)UIImageView *order_image;
@property (nonatomic, strong)UILabel     *title_label;
@property (nonatomic, strong)UILabel     *corner_label;

//创建view ，指定背景色
+(UIView *)createViewFrame:(CGRect)frame
           backgroundColor:(UIColor *)color;

//创建button，有背景图片

+ (UIButton *)creatButtonFrame:(CGRect )frame
            setBackgroundImage:(UIImage *)image
                      setTitle:(NSString *)title
                 setTitleColor:(UIColor *)TitleColor
                     addTarget:(id)target
                        action:(SEL)action
              forControlEvents:(UIControlEvents)controlEvents;

+(UIImageView *)initWithFrame:(CGRect)frame
                     setImage:(UIImage *)image
                     setTitle:(NSString *)title
                   connerBage:(NSString *)connerBage;
@end
