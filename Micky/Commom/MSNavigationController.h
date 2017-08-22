//
//  MSNavigationController.h
//  NewProject
//
//  Created by 张宁 on 16/10/26.
//  Copyright © 2016年 apple. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MSNavigationController : UINavigationController

- (void)pushViewController:(UIViewController *)viewController
                  animated:(BOOL)animated;

- (void)navigationController:(UINavigationController *)navigationController
       didShowViewController:(UIViewController *)viewController
                    animated:(BOOL)animated;

@end
