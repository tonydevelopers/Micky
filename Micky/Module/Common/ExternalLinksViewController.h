//
//  ExternalLinksViewController.h
//  MickyEasyCredit
//
//  Created by 张宁 on 2017/3/3.
//  Copyright © 2017年 apple. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "TOWebViewController.h"

@interface ExternalLinksViewController : TOWebViewController

@property(nonatomic,strong)NSString *externalLink_url;
@property(nonatomic,strong)NSString *class_name;
@property(nonatomic,assign)BOOL isRooterEnter;
@property(nonatomic,assign)BOOL is_show_header;

@end
