//
//  PasswordView.h
//  MickyEasyCredit
//
//  Created by 张宁 on 2016/12/24.
//  Copyright © 2016年 apple. All rights reserved.
//

#import <UIKit/UIKit.h>
/**
 *  点击菜单回调block
 *
 *  @param passwordString 点击按钮的位置
 */
typedef void (^PasswordClickBlock)(NSString* passwordString);

@interface PasswordView : UIView
@property (nonatomic, copy) PasswordClickBlock menuClickBlock;

- (instancetype)initWithMenuFrame:(CGRect)frame menuClickBlock:(PasswordClickBlock)menuClickBlock;
- (void)show;

@end
