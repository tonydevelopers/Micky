//
//  MenuPopover.h
//  Menu
//
//  Created by fcx on 15/7/31.
//  Copyright (c) 2015年 fcx. All rights reserved.
//

#import <UIKit/UIKit.h>

/**
 *  点击菜单回调block
 *
 *  @param buttonIndex 点击按钮的位置
 */
typedef void (^AlertBoxClickBlock)(NSInteger buttonIndex);

@protocol AlertBoxDelegate <NSObject>

- (void)determineAction:(NSString *)sender;

@end

@interface AlertBox : UIView

@property (nonatomic, assign) id<AlertBoxDelegate>delegate;
@property (nonatomic, copy) AlertBoxClickBlock alertBoxClickBlock;

- (instancetype)initWithMenuFrame:(CGRect)frame title:(NSString*)str alertBoxClickBlock:(AlertBoxClickBlock)alertBoxClickBlock;

- (void)show;
- (void)dismiss;

@end
