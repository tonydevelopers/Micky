//
//  MainListHeadView.m
//  zhadui
//
//  Created by infzm infzm on 12/14/11.
//  Copyright (c) 2011 __MyCompanyName__. All rights reserved.
//

#import "TabbarView.h"
#import "AppDelegate.h"
#import "Gobal.h"
#import "MSNavigationController.h"
#import "InternationalCintrol.h"

@interface TabbarView(){
    
}

-(void)clickLogo;

-(void)clickWrite;

@end


@implementation TabbarView
@synthesize titleLabel;
@synthesize one_Btn=_one_Btn,
            two_Btn=_two_Btn,
            three_Btn=_three_Btn,
            four_Btn=_four_Btn;
@synthesize rightSegment;

-(void)dealloc{
    [titleLabel release];
    titleLabel = nil;
    [_one_Btn release];
    _one_Btn = nil;
    [_two_Btn release];
    _two_Btn = nil;
    [_three_Btn release];
    _three_Btn = nil;
    [_four_Btn release];
    _four_Btn = nil;
	[super dealloc];
}

- (void)changeLanguage{
    
    [_one_Btn setTitle:[[InternationalCintrol bundle] localizedStringForKey:@"tabbar_home" value:nil table:@"hello"] forState:UIControlStateNormal];
    [_two_Btn setTitle:[[InternationalCintrol bundle] localizedStringForKey:@"tabbar_list" value:nil table:@"hello"] forState:UIControlStateNormal];
    [_three_Btn setTitle:[[InternationalCintrol bundle] localizedStringForKey:@"tabbar_cart" value:nil table:@"hello"] forState:UIControlStateNormal];
    [_four_Btn setTitle:[[InternationalCintrol bundle] localizedStringForKey:@"tabbar_my" value:nil table:@"hello"] forState:UIControlStateNormal];
    
}

- (id)init{
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(changeLanguage) name:@"changeLanguage" object:nil];
    
    CGRect frame;
    if(SCREENHEIGH == 568)
        frame = MainViewTabbarShowPositionProtraitH;
    else
        frame = MainViewTabbarShowPositionProtrait;
    if (self = [super initWithFrame:frame]){
        self.backgroundColor = [UIColor whiteColor];
        UILabel *lineLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, self.frame.size.width, 1)];
        lineLabel.backgroundColor = [UIColor colorWithRed:(220.0/255.0) green:(220.0/255.0) blue:(220.0/255.0) alpha:1.0];
        [self addSubview:lineLabel];
        
        UIImageView *backgroundIUmageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, SCREENWIDTH, 49)];
//        backgroundIUmageView.image = [UIImage imageNamed:@"DLTabbarBg "];
        [self addSubview:backgroundIUmageView];
        [self sendSubviewToBack:backgroundIUmageView];
        [backgroundIUmageView release];
        
        
        _one_Btn = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, SCREENWIDTH/4, 49)];
        [_one_Btn setImage:[UIImage imageNamed:@"tabbar_home"] forState:UIControlStateNormal];
        [_one_Btn setImage:[UIImage imageNamed:@"tabbar_home_sel"] forState:UIControlStateSelected];
        _one_Btn.contentMode = UIViewContentModeScaleAspectFit;
        [_one_Btn setTitle:@"借款" forState:UIControlStateNormal];
        [_one_Btn setTitleColor:TITLE_FONT_COLOR forState:UIControlStateNormal];
        [_one_Btn setTitleColor:BUTTON_COLOR_NORMA forState:UIControlStateSelected];
        _one_Btn.titleLabel.font = [UIFont systemFontOfSize:12];
        _one_Btn.titleEdgeInsets = UIEdgeInsetsMake(12, -10, -12, 12);
        _one_Btn.imageEdgeInsets = UIEdgeInsetsMake(-7, 12, 10, -12);
        [_one_Btn addTarget:self action:@selector(ClickSegment:) forControlEvents:UIControlEventTouchUpInside];
        [_one_Btn setSelected:YES];
        [self addSubview:_one_Btn];
        [_one_Btn release];
        
        _two_Btn = [[UIButton alloc] initWithFrame:CGRectMake(CGRectGetMaxX(_one_Btn.frame), 0, SCREENWIDTH/4, 49)];
        [_two_Btn setImage:[UIImage imageNamed:@"tabbar_cart"] forState:UIControlStateNormal];
        [_two_Btn setImage:[UIImage imageNamed:@"tabbar_cart_sel"] forState:UIControlStateSelected];
        _two_Btn.contentMode = UIViewContentModeScaleAspectFit;
        [_two_Btn setTitle:@"消息" forState:UIControlStateNormal];
        [_two_Btn setTitleColor:TITLE_FONT_COLOR forState:UIControlStateNormal];
        [_two_Btn setTitleColor:BUTTON_COLOR_NORMA forState:UIControlStateSelected];
        _two_Btn.titleLabel.font = [UIFont systemFontOfSize:12];
        _two_Btn.titleEdgeInsets = UIEdgeInsetsMake(12, -10, -12, 12);
        _two_Btn.imageEdgeInsets = UIEdgeInsetsMake(-7, 12, 10, -12);
        [_two_Btn addTarget:self action:@selector(ClickSegment:) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:_two_Btn];
        [_two_Btn release];
        
        _three_Btn = [[UIButton alloc] initWithFrame:CGRectMake(CGRectGetMaxX(_two_Btn.frame), 0, SCREENWIDTH/4, 49)];
        [_three_Btn setImage:[UIImage imageNamed:@"tabbar_list"] forState:UIControlStateNormal];
        [_three_Btn setImage:[UIImage imageNamed:@"tabbar_list_sel"] forState:UIControlStateSelected];
        _three_Btn.contentMode = UIViewContentModeScaleAspectFit;
        [_three_Btn setTitle:@"客服" forState:UIControlStateNormal];
        [_three_Btn setTitleColor:TITLE_FONT_COLOR forState:UIControlStateNormal];
        [_three_Btn setTitleColor:BUTTON_COLOR_NORMA forState:UIControlStateSelected];
        _three_Btn.titleLabel.font = [UIFont systemFontOfSize:12];
        _three_Btn.titleEdgeInsets = UIEdgeInsetsMake(12, -10, -12, 12);
        _three_Btn.imageEdgeInsets = UIEdgeInsetsMake(-7, 12, 10, -12);
        [_three_Btn addTarget:self action:@selector(ClickSegment:) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:_three_Btn];
        [_three_Btn release];
        
        _four_Btn = [[UIButton alloc] initWithFrame:CGRectMake(CGRectGetMaxX(_three_Btn.frame), 0, SCREENWIDTH/4, 49)];
        [_four_Btn setImage:[UIImage imageNamed:@"tabbar_my"] forState:UIControlStateNormal];
        [_four_Btn setImage:[UIImage imageNamed:@"tabbar_my_sel"] forState:UIControlStateSelected];
        _four_Btn.contentMode = UIViewContentModeScaleAspectFit;
        [_four_Btn setTitle:NSLocalizedString(@"tabbar_my", nil) forState:UIControlStateNormal];
        [_four_Btn setTitleColor:TITLE_FONT_COLOR forState:UIControlStateNormal];
        [_four_Btn setTitleColor:BUTTON_COLOR_NORMA forState:UIControlStateSelected];
        _four_Btn.titleLabel.font = [UIFont systemFontOfSize:12];
        _four_Btn.titleEdgeInsets = UIEdgeInsetsMake(12, -10, -12, 12);
        _four_Btn.imageEdgeInsets = UIEdgeInsetsMake(-7, 12, 10, -12);
        [_four_Btn addTarget:self action:@selector(ClickSegment:) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:_four_Btn];
        [_four_Btn release];
        
        NSArray *array = [NSArray arrayWithObjects:@"1", @"2", @"3", @"4",nil];
        rightSegment = [[UISegmentedControl alloc] initWithItems:array];
        rightSegment.segmentedControlStyle = UISegmentedControlStyleBar;
        [rightSegment addTarget:self action:@selector(ClickSegment:) forControlEvents:UIControlEventValueChanged];
    }
    return self;
}


-(void)clickCatalog{

    if ([[AppDelegate getInstance] mainTabController].status == MainListViewStatusClose) {
        [[[AppDelegate getInstance] mainTabController] showCatalogView];
    }else if([[AppDelegate getInstance] mainTabController].status == MainListViewStatusOpen){
        [[[AppDelegate getInstance] mainTabController] hideCatalogView];
    }
}

-(void)refreshTableView{
    
//    NSArray *viewControllers = [[AppDelegate getInstance] VeidoNavController].viewControllers;
//
//    NoticeCenterController *noticeCenter = (NoticeCenterController *)[viewControllers objectAtIndex:0];
//    [noticeCenter SKrefreshMsgView];
}

-(void)setMainTabViewControllerSelectedIndex:(int)index{
    [[[AppDelegate getInstance] mainTabController] setSelectedIndex:index];
    switch (index) {
        case 0:
            [[[AppDelegate getInstance] mainTabController] headView].backgroundIUmageView.image = [UIImage imageNamed:(IS_OS_7_OR_LATER)?@"NavigationBarBg":@"NavigationBarBg"];
            [[[[AppDelegate getInstance] mainTabController] headView].titleLabel setHidden:NO];
            [[[AppDelegate getInstance] mainTabController] headView].titleLabel.text = @"首页";
            [[[[AppDelegate getInstance] mainTabController] headView].dateView setHidden:YES];
            [[[[AppDelegate getInstance] mainTabController] headView].bornNumView setHidden:YES];
            [AppDelegate getInstance].CurNavController = [AppDelegate getInstance].OneNavController;
            [[[AppDelegate getInstance] mainTabController] hideHeaderView];
            break;
            
        case 1:
            [[[AppDelegate getInstance] mainTabController] headView].backgroundIUmageView.image = [UIImage imageNamed:(IS_OS_7_OR_LATER)?@"NavigationBarBg":@"NavigationBarBg"];
            
            [[[[AppDelegate getInstance] mainTabController] headView].titleLabel setHidden:YES];
            [[[AppDelegate getInstance] mainTabController] headView].titleLabel.text = @"列表";
            [[[[AppDelegate getInstance] mainTabController] headView].dateView setHidden:YES];
            [[[[AppDelegate getInstance] mainTabController] headView].bornNumView setHidden:NO];
            [AppDelegate getInstance].CurNavController = [AppDelegate getInstance].TwoNavController;
            [[[AppDelegate getInstance] mainTabController] hideHeaderView];
            break;
            
        case 2:
            [[[AppDelegate getInstance] mainTabController] headView].backgroundIUmageView.image = [UIImage imageNamed:(IS_OS_7_OR_LATER)?@"NavigationBarBg":@"NavigationBarBg"];
            
            [[[[AppDelegate getInstance] mainTabController] headView].titleLabel setHidden:NO];
            [[[AppDelegate getInstance] mainTabController] headView].titleLabel.text = @"社区";
            [[[[AppDelegate getInstance] mainTabController] headView].dateView setHidden:YES];
            [[[[AppDelegate getInstance] mainTabController] headView].bornNumView setHidden:YES];
            [AppDelegate getInstance].CurNavController = [AppDelegate getInstance].ThreeNavController;
            [[[AppDelegate getInstance] mainTabController] hideHeaderView];
            break;
            
        case 3:
        {
            [[[AppDelegate getInstance] mainTabController] headView].backgroundIUmageView.image = [UIImage imageNamed:(IS_OS_7_OR_LATER)?@"NavigationBarBg":@"NavigationBarBg"];

            [[[[AppDelegate getInstance] mainTabController] headView].titleLabel setHidden:NO];
            [[[AppDelegate getInstance] mainTabController] headView].titleLabel.text = @"我的";
            [[[[AppDelegate getInstance] mainTabController] headView].dateView setHidden:YES];
            [[[[AppDelegate getInstance] mainTabController] headView].bornNumView setHidden:YES];
            [AppDelegate getInstance].CurNavController = [AppDelegate getInstance].FourNavController;
            [[[AppDelegate getInstance] mainTabController] hideHeaderView];
            
        }
            break;
            
            
        default:
            break;
    }
}

-(void)ClickSegment:(id)sender{

    UIButton *btn = (UIButton *)sender;
    
    if (btn == _one_Btn) {
        [rightSegment setSelectedSegmentIndex:0];
        [_one_Btn setSelected:YES];
        [_three_Btn setSelected:NO];
        [_two_Btn setSelected:NO];
        [_four_Btn setSelected:NO];
    }
    else if (btn == _two_Btn) {
        [rightSegment setSelectedSegmentIndex:1];
        [_one_Btn setSelected:NO];
        [_two_Btn setSelected:YES];
        [_three_Btn setSelected:NO];
        [_four_Btn setSelected:NO];
    }
    else if (btn == _three_Btn) {
        [rightSegment setSelectedSegmentIndex:2];
        [_one_Btn setSelected:NO];
        [_two_Btn setSelected:NO];
        [_three_Btn setSelected:YES];
        [_four_Btn setSelected:NO];
    }
    else if (btn == _four_Btn){
        [rightSegment setSelectedSegmentIndex:3];
        [_one_Btn setSelected:NO];
        [_three_Btn setSelected:NO];
        [_two_Btn setSelected:NO];
        [_four_Btn setSelected:YES];
    }
    
    
    [self setMainTabViewControllerSelectedIndex:(int)rightSegment.selectedSegmentIndex];
}

-(void)ClickMainPage{
    [_one_Btn setSelected:YES];
    [_three_Btn setSelected:NO];
    [_two_Btn setSelected:NO];
    [_four_Btn setSelected:NO];
    [rightSegment setSelectedSegmentIndex:0];
    [self setMainTabViewControllerSelectedIndex:(int)rightSegment.selectedSegmentIndex];
}



@end
