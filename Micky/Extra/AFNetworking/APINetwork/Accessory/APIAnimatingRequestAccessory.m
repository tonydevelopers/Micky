//
//  APIAnimatingRequestAccessory.m
//

#import "APIAnimatingRequestAccessory.h"
//#import "APIAlertUtils.h"


@implementation APIAnimatingRequestAccessory

- (id)initWithAnimatingView:(UIView *)animatingView animatingText:(NSString *)animatingText {
    self = [super init];
    if (self) {
        _animatingView = animatingView;
        _animatingText = animatingText;
    }
    return self;
}

- (id)initWithAnimatingView:(UIView *)animatingView {
    self = [super init];
    if (self) {
        _animatingView = animatingView;
    }
    return self;
}

+ (id)accessoryWithAnimatingView:(UIView *)animatingView {
    return [[self alloc] initWithAnimatingView:animatingView];
}

+ (id)accessoryWithAnimatingView:(UIView *)animatingView animatingText:(NSString *)animatingText {
    return [[self alloc] initWithAnimatingView:animatingView animatingText:animatingText];
}

- (void)requestWillStart:(id)request {
    if (_animatingView) {
        dispatch_async(dispatch_get_main_queue(), ^{
            // TODO: show loading
            // [APIAlertUtils showLoadingAlertView:_animatingText inView:_animatingView];
            NSLog(@" loading start");
        });
    }
}

- (void)requestWillStop:(id)request {
    if (_animatingView) {
        dispatch_async(dispatch_get_main_queue(), ^{
            // TODO: hide loading
            //[APIAlertUtils hideLoadingAlertView:_animatingView];
            NSLog(@" loading finished");
        });
    }
}

@end
