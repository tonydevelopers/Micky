//
//  MainListHeadView.h
//  zhadui
//
//  Created by infzm infzm on 12/14/11.
//  Copyright (c) 2011 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>

#define MainListHeadViewShowPositionProtrait (CGRectMake(0,20, 320, 44))
#define MainListHeadViewHidePositionProtrait (CGRectMake(0, -56, 320, 44))
#define MainListHeadViewHidePositionProtraitWhenHideStatusBar (CGRectMake(0, -44, 320, 44))


@interface MainListHeadView : UIView{
    UILabel           *_titleLabel;
    UIButton           *_todayBtn;
    UIImageView         *_backgroundIUmageView;
    UILabel             *_dateLabel;
    UIView              *_dateView;
}

@property (nonatomic, retain) UILabel           *titleLabel;
@property (nonatomic, retain) UIButton           *todayBtn;
@property (nonatomic, retain) UIImageView *backgroundIUmageView;
@property (nonatomic, retain) UILabel           *dateLabel;
@property (nonatomic, retain) UIView           *dateView;
@property (nonatomic, retain) UIView           *bornNumView;
@property (nonatomic, retain) UILabel           *bornNumLabel;

//-(void)setBadgeViewHide:(BOOL)isHide;
//-(void)setBadgeNum:(int)num;

@end
