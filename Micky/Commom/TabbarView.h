//
//  MainListHeadView.h
//  zhadui
//
//  Created by infzm infzm on 12/14/11.
//  Copyright (c) 2011 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>

#define MainViewTabbarShowPositionProtrait (CGRectMake(0, SCREENHEIGH-49, SCREENWIDTH, 49))
#define MainViewTabbarShowPositionProtraitH (CGRectMake(0, SCREENHEIGH-49, SCREENWIDTH, 49))
#define MainViewTabbarHidePositionProtrait (CGRectMake(0, SCREENHEIGH+11, SCREENWIDTH, 49))



@interface TabbarView : UIView{
    UILabel           *titleLabel;
}

@property (nonatomic, retain) UILabel  *titleLabel;
@property (nonatomic, retain) UIButton *one_Btn;
@property (nonatomic, retain) UIButton *two_Btn;
@property (nonatomic, retain) UIButton *three_Btn;
@property (nonatomic, retain) UIButton *four_Btn;
@property (nonatomic, retain) UISegmentedControl *rightSegment;

//-(void)setBadgeViewHide:(BOOL)isHide;
//-(void)setBadgeNum:(int)num;
-(void)ClickMainPage;
//-(void)ClickCSPage;
//-(void)ClickOnSellPage;
//-(void)ClickHWWeiboPage;
-(void)setMainTabViewControllerSelectedIndex:(int)index;

@end
