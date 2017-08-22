//
//  MyOrderView.m
//  MickyEasyCredit
//
//  Created by 张宁 on 16/10/9.
//  Copyright © 2016年  张宁. All rights reserved.
//

#import "MyOrderView.h"

@implementation MyOrderView

-(id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    
    if (self) {
        
        _order_image = [[UIImageView alloc] initWithFrame:CGRectMake(self.frame.size.width / 2 -20, 20, 40, 40)];
        _order_image.backgroundColor = [UIColor greenColor];
        _order_image.layer.masksToBounds = YES;
        _order_image.layer.cornerRadius = 20;
        [self addSubview:_order_image];
        
        _title_label = [[UILabel alloc] init];
        _title_label.textAlignment = NSTextAlignmentCenter;
        _title_label.font = [UIFont systemFontOfSize:13];
        _title_label.frame = CGRectMake(0, CGRectGetMaxY(_order_image.frame)+5, frame.size.width, 30);
        [self addSubview:_title_label];
        
        _corner_label = [[UILabel alloc] init];
        _corner_label.textAlignment = NSTextAlignmentCenter;
        _corner_label.layer.borderColor = [[UIColor redColor] CGColor];
        _corner_label.layer.borderWidth = 0.5f;
        _corner_label.textColor = [UIColor redColor];
        _corner_label.font = [UIFont systemFontOfSize:12];
        [self addSubview:_corner_label];
        _corner_label.frame = CGRectMake(self.frame.size.width / 2 +5, 10, 20, 20);
        _corner_label.layer.masksToBounds = YES;
        _corner_label.layer.cornerRadius = 10;
        
    }

    return self;
}

+(UIView *)createViewFrame:(CGRect)frame
           backgroundColor:(UIColor *)color
{
    
    UIView *view = [[UIView alloc]initWithFrame:frame];
    view.backgroundColor = color;
    return view;
}

+(UIButton *)creatButtonFrame:(CGRect )frame
           setBackgroundImage:(UIImage *)image
                     setTitle:(NSString *)title
                setTitleColor:(UIColor *)TitleColor
                    addTarget:(id)target
                       action:(SEL)action
             forControlEvents:(UIControlEvents)controlEvents
{
    
    UIButton *button =[UIButton buttonWithType:UIButtonTypeCustom];
    button.frame = frame;
    [button setBackgroundImage:image forState:UIControlStateNormal];
    [button setTitle:title forState:UIControlStateNormal];
    [button setTitleColor:TitleColor forState:UIControlStateNormal];
    [button addTarget:(id)target action:(SEL)action forControlEvents:(UIControlEvents)controlEvents];
    
    return button;
    
}

+(UIImageView *)initWithFrame:(CGRect)frame
                     setImage:(UIImage *)image
                     setTitle:(NSString *)title
                   connerBage:(NSString *)connerBage
{
    UIImageView *imageView = [UIImageView new];
    imageView.frame = frame;
    imageView.image = image;
    return imageView;
}

@end
