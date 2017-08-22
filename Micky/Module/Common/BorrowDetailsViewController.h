//
//  BorrowDetailsViewController.h
//  MickyEasyCredit
//
//  Created by 张宁 on 2017/4/17.
//  Copyright © 2017年 apple. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "TOWebViewController.h"

@interface BorrowDetailsViewController : TOWebViewController

@property(nonatomic,strong)NSString *externalLink_url;
@property(nonatomic,strong)NSString *class_name;
@property(nonatomic,assign)BOOL isRooterEnter;
@property(nonatomic,assign)BOOL is_show_header;

@end
