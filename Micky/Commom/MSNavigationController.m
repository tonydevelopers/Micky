//
//  MSNavigationController.m
//  MickyEasyCredit
//
//  Created by 张宁 on 16/10/26.
//  Copyright © 2016年 apple. All rights reserved.
//

#import "MSNavigationController.h"

@interface MSNavigationController ()<UINavigationControllerDelegate,UIGestureRecognizerDelegate>

@property(nonatomic,weak) UIViewController* currentShowVC;


@end

@implementation MSNavigationController


-(id)initWithRootViewController:(UIViewController *)rootViewController
{
    MSNavigationController* nvc = [super initWithRootViewController:rootViewController];
    if ([nvc respondsToSelector:@selector(interactivePopGestureRecognizer)])
        self.interactivePopGestureRecognizer.delegate = self;
    nvc.delegate = self;
    return nvc;
}

- (void)pushViewController:(UIViewController *)viewController
                  animated:(BOOL)animated
{
    if ([self respondsToSelector:@selector(interactivePopGestureRecognizer)]) {
        self.interactivePopGestureRecognizer.enabled = NO;
    }
    
    [super pushViewController:viewController animated:animated];
}

-(void)navigationController:(UINavigationController *)navigationController didShowViewController:(UIViewController *)viewController animated:(BOOL)animated
{
    if (navigationController.viewControllers.count == 1)
        self.currentShowVC = Nil;
    else
    {
        self.currentShowVC = viewController;
    }
    if ([navigationController respondsToSelector:@selector(interactivePopGestureRecognizer)]) {
        navigationController.interactivePopGestureRecognizer.enabled = YES;
    }
}

-(UIViewController *)popViewControllerAnimated:(BOOL)animated{
    return [super popViewControllerAnimated:animated];
}


- (BOOL)shouldAutorotate
{
    return [self.viewControllers.lastObject shouldAutorotate];
}
- (UIInterfaceOrientationMask)supportedInterfaceOrientations
{
    return [self.viewControllers.lastObject supportedInterfaceOrientations];
}
- (UIInterfaceOrientation)preferredInterfaceOrientationForPresentation
{
    return [self.viewControllers.lastObject preferredInterfaceOrientationForPresentation];
}


-(BOOL)gestureRecognizerShouldBegin:(UIGestureRecognizer *)gestureRecognizer
{
    
    return NO;
    
//    if ([self respondsToSelector:@selector(interactivePopGestureRecognizer)]){
//        if (gestureRecognizer == self.interactivePopGestureRecognizer) {
//            return (self.currentShowVC == self.topViewController); //the most important
//        }
//    }
//    return YES;
}

@end
