//
//  PromptView.m
//  MickyEasyCredit
//
//  Created by 张宁 on 16/10/10.
//  Copyright © 2016年  张宁. All rights reserved.
//

#import "PromptView.h"
#import "BaseView.h"
#import "Gobal.h"
@interface PromptView ()
{
    UIView *menuView;


}
@end

@implementation PromptView
@synthesize title_text;
@synthesize animate_image;


+(instancetype)sharePrompt {
    static PromptView *p = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        p = [[PromptView alloc]init];
    });
    return p;
}
- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:[UIScreen mainScreen].bounds];
    if (self) {
        self.backgroundColor = [UIColor colorWithWhite:0 alpha:.5];
        
        menuView = [[UIView alloc] init];
        menuView.backgroundColor = [UIColor whiteColor];
        menuView.userInteractionEnabled = YES;
        menuView.layer.anchorPoint = CGPointMake(0.5, 0.5);
        menuView.frame = CGRectMake((SCREEN_WIDTH-120)/2.0, (SCREEN_HEIGHT-50)/2.0-20, 120, 40);
        menuView.layer.cornerRadius = 5;
        menuView.layer.masksToBounds = YES;
        menuView.layer.borderWidth = 0.8;
        menuView.layer.borderColor = BASE_COLOR_LINE.CGColor;
        [self addSubview:menuView];

        title_text = [[UILabel alloc]init];
        title_text.frame = CGRectMake(10, 5, 100, 30);
        title_text.backgroundColor = [UIColor clearColor];
        title_text.textColor = WORD_FONT_COLOR;
        title_text.font = [UIFont systemFontOfSize:15];
        title_text.textAlignment = NSTextAlignmentCenter;
        title_text.numberOfLines = 0;
        [menuView addSubview:title_text];
    }
    return self;
}
-(void)showPromptTitle:(NSString *)message {
    
    
}
-(void)showPromptTitle:(NSString *)message Secord:(CGFloat)time_date {

    title_text.text = message;
    CGFloat height = [Gobal heightWithText:title_text.text font:[UIFont systemFontOfSize:15] maxWidth:100];
    
    if (height>20&&height<70) {
        menuView.frame = CGRectMake((SCREEN_WIDTH-120)/2.0, (SCREEN_HEIGHT-50)/2.0-20-height/2.0, 120, height+20);
        title_text.frame = CGRectMake(10, 5, 100, height+10);
    }
    [self performSelector:@selector(dismiss) withObject:nil afterDelay:time_date];
}
- (void)show {
    UIWindow* window = [UIApplication sharedApplication].keyWindow;
    [window addSubview:self];
    
    __weak UIView *weakView = menuView;
    
    menuView.transform = CGAffineTransformMakeScale(0.1f, 0.1f);
    
    [UIView animateWithDuration:.15 delay:0 options:UIViewAnimationOptionCurveEaseInOut animations:^{
        
        weakView.transform = CGAffineTransformIdentity;
        
    } completion:^(BOOL finished) {
        
    }];

}
- (void)dismiss {
    __weak __typeof(self)weakSelf = self;
    __weak UIView *weakView = menuView;
    [UIView animateWithDuration:.15 animations:^{
        weakView.transform = CGAffineTransformMakeScale(0.1f, 0.1f);
    } completion:^(BOOL finished) {
        [weakSelf removeFromSuperview];
    }];
}

@end
