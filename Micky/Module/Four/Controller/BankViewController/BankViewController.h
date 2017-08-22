//
//  BankViewController.h
//  MickyEasyCredit
//
//  Created by 张宁 on 2017/5/9.
//  Copyright © 2017年 apple. All rights reserved.
//

#import <UIKit/UIKit.h>
@class BankListModel;
@protocol BankDelegate <NSObject>

- (void)selectBankInfoModel:(BankListModel*)model;

@end

@interface BankViewController : UIViewController

@property(nonatomic,assign)id<BankDelegate>delegate;
@property(nonatomic,assign)BOOL isBankBack;

@end
