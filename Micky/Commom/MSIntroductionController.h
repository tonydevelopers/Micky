//
//  MSIntroductionController.h
//  MickyEasyCredit
//
//  Created by 张宁 on 2017/5/24.
//  Copyright © 2017年 apple. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MSIntroductionPage.h"

#define TUTORIAL_LABEL_TEXT_COLOR               [UIColor blackColor]
#define TUTORIAL_LABEL_HEIGHT                   34
#define TUTORIAL_SUB_TITLE_FONT                 [UIFont fontWithName:@"Helvetica" size:20.0f]
#define TUTORIAL_SUB_TITLE_LINES_NUMBER         1
#define TUTORIAL_SUB_TITLE_OFFSET               170
#define TUTORIAL_DESC_FONT                      [UIFont fontWithName:@"Helvetica" size:15.0f]
#define TUTORIAL_DESC_LINES_NUMBER              2
#define TUTORIAL_DESC_OFFSET                    140
#define TUTORIAL_DEFAULT_DURATION_ON_PAGE       3.0f


typedef NS_OPTIONS(NSUInteger, ScrollingState) {
    ScrollingStateAuto      = 1 << 0,
    ScrollingStateManual    = 1 << 1,
    ScrollingStateLooping   = 1 << 2,
};

typedef void (^ButtonBlock)(UIButton *button);

@interface MSIntroductionController : UIViewController <UIScrollViewDelegate> {
    UIImageView *_backLayerView;
    UIImageView *_frontLayerView;
    __weak IBOutlet UILabel *_overlayTitle;
    UIScrollView *_scrollView;
    UIPageControl *_pageControl;
    
    CGSize _windowSize;
    ScrollingState _currentState;
    
    NSArray *_pages;
    NSInteger _currentPageIndex;
    
    BOOL _autoScrollEnabled;
    BOOL _autoScrollLooping;
    CGFloat _autoScrollDurationOnPage;
    
    MSIntroductionLabelStyle *_commonPageSubTitleStyle;
    MSIntroductionLabelStyle *_commonPageDescriptionStyle;
    
    ButtonBlock _button1Block;
    ButtonBlock _button2Block;
    ButtonBlock _qqBtnBlock;
    ButtonBlock _sinaBtnBlock;
}

@property (nonatomic, assign) BOOL autoScrollEnabled;
@property (nonatomic, assign) BOOL autoScrollLooping;
@property (nonatomic, assign) CGFloat autoScrollDurationOnPage;
@property (nonatomic, retain) MSIntroductionLabelStyle *commonPageSubTitleStyle;
@property (nonatomic, retain) MSIntroductionLabelStyle *commonPageDescriptionStyle;

// Inits.
- (id)initWithNibName:(NSString *)nibNameOrNil
               bundle:(NSBundle *)nibBundleOrNil;
- (id)initWithNibName:(NSString *)nibNameOrNil
               bundle:(NSBundle *)nibBundleOrNil
             andPages:(NSArray *)pages;
- (id)initWithNibName:(NSString *)nibNameOrNil
               bundle:(NSBundle *)nibBundleOrNil
                pages:(NSArray *)pages
         button1Block:(ButtonBlock)block1
         button2Block:(ButtonBlock)block2;

// Actions.
- (void)show;
- (void)viewsDisappear;
- (void)setButton1Block:(ButtonBlock)block;
- (void)setButton2Block:(ButtonBlock)block;
- (void)setQQBtnBlock:(ButtonBlock)block;
- (void)setSinaBtnBlock:(ButtonBlock)block;
- (void)setSubTitleStyleArray:(NSArray *)array;
- (void)setDescStyleArray:(NSArray *)array;

// Pages management.
- (void)setPages:(NSArray*)pages;
- (NSUInteger)numberOfPages;

// Scrolling.
- (void)startScrolling;
- (void)stopScrolling;

// State.
- (ScrollingState)getCurrentState;

@end
