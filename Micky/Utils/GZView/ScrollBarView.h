//
//  ScrollBarView.h
//  Encapsulation
//
//  Created by 张宁 on 2017/4/14.
//  Copyright © 2017年 mosjoydev6. All rights reserved.
//

#import <UIKit/UIKit.h>
#define NUM_LABELS 2

enum ScrollBarDirection {
    SCROLLBAR_RIGHT,
    SCROLLBAR_LEFT,
};

@interface ScrollBarView : UIScrollView <UIScrollViewDelegate>{
    UILabel *label[NUM_LABELS];
    enum ScrollBarDirection scrollDirection;
    float scrollSpeed;
    NSTimeInterval pauseInterval;
    int bufferSpaceBetweenLabels;
    bool isScrolling;
}
@property(nonatomic) enum ScrollBarDirection scrollDirection;
@property(nonatomic) float scrollSpeed;
@property(nonatomic) NSTimeInterval pauseInterval;
@property(nonatomic) int bufferSpaceBetweenLabels;
// normal UILabel properties
@property(nonatomic,retain) UIColor *textColor;
@property(nonatomic, retain) UIFont *font;

- (void) readjustLabels;
- (void) setText: (NSString *) text;
- (NSString *) text;
- (void) scroll;


@end
