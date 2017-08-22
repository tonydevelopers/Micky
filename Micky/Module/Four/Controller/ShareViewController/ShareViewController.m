//
//  ShareViewController.m
//  MickyEasyCredit
//
//  Created by 张宁 on 2017/4/17.
//  Copyright © 2017年 apple. All rights reserved.
//

#import "ShareViewController.h"
#import "AppDelegate.h"

#import <UShareUI/UShareUI.h>
#import <UMSocialCore/UMSocialCore.h>


@interface ShareViewController ()
{
    UILabel *titleLabel;
    UIImageView *header_imgV;
    UILabel *recommended_label;
    UILabel *text_label;
    UIButton *share_Btn;
    UILabel *share_title;

}
@end

@implementation ShareViewController

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    self.navigationController.navigationBar.hidden = YES;
    [[UIApplication sharedApplication] setStatusBarStyle:UIStatusBarStyleLightContent];
}
- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = BACKGROUND_COLOR;
    self.navigationController.navigationBar.hidden = YES;
    [[UIApplication sharedApplication] setStatusBarStyle:UIStatusBarStyleLightContent];
    
    [self initData];
    [self initNavigate];
    [self initLayout];
}
#pragma mark - init
#pragma mark -- init/Data
- (void)initData {
    //查看资料信息
//    [self loanDataRequest];
}
#pragma mark -- init/navigate
- (void)initNavigate {
    header_imgV = [[UIImageView alloc]init];
    header_imgV.frame = CGRectMake(0, 0, SCREEN_WIDTH, (313/375.0)*SCREEN_WIDTH);
    header_imgV.image = [UIImage imageNamed:@"my_share"];
    header_imgV.userInteractionEnabled = YES;
    [self.view addSubview:header_imgV];
    
    titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 25, SCREEN_WIDTH, 20)];
    titleLabel.textAlignment = NSTextAlignmentCenter;
    titleLabel.textColor = [UIColor whiteColor];
    titleLabel.text = @"邀好友得优惠券";
    titleLabel.font = [UIFont systemFontOfSize:20.0];
    [header_imgV addSubview:titleLabel];
    
    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    button.frame = CGRectMake(15,12,53,44);
    button.backgroundColor = [UIColor clearColor];
    [button setImage:[UIImage imageNamed:@"navbar_back"] forState:UIControlStateNormal];
    [button setImageEdgeInsets:UIEdgeInsetsMake(0, -40, 0, 0)];
    [button addTarget:self action:@selector(popBack) forControlEvents:UIControlEventTouchUpInside];
    [header_imgV addSubview:button];
    
    UILabel *label_1 = [[UILabel alloc] initWithFrame:CGRectMake(0, CGRectGetMaxY(titleLabel.frame)+10, SCREEN_WIDTH, 30)];
    label_1.text = @"邀请好友一起变土豪";
    label_1.font = [UIFont systemFontOfSize:18];
    label_1.textAlignment = NSTextAlignmentCenter;
    label_1.textColor = [UIColor whiteColor];
    [header_imgV addSubview:label_1];

    UILabel *label_2 = [[UILabel alloc] initWithFrame:CGRectMake(0, CGRectGetMaxY(label_1.frame)+20, SCREEN_WIDTH, 40)];
    label_2.text = @"感谢您一直以来对仟易贷的支持,\n现在邀请您的好友开启兑换优惠券之旅";
    label_2.font = [UIFont systemFontOfSize:15];
    label_2.textAlignment = NSTextAlignmentCenter;
    label_2.textColor = [UIColor whiteColor];
    label_2.numberOfLines = 2;
    [header_imgV addSubview:label_2];

    
    UILabel *label_3 = [[UILabel alloc] initWithFrame:CGRectMake(0,  (313/375.0)*SCREEN_WIDTH-65, SCREEN_WIDTH, 20)];
    label_3.text = @"分享好友邀请码,注册成功获优惠券奖励";
    label_3.font = [UIFont systemFontOfSize:15];
    label_3.textAlignment = NSTextAlignmentCenter;
    label_3.textColor = [UIColor whiteColor];
    [header_imgV addSubview:label_3];

    
    recommended_label = [[UILabel alloc] initWithFrame:CGRectMake(0, (313/375.0)*SCREEN_WIDTH-(150/313.0)*(313/375.0)*SCREEN_WIDTH, SCREEN_WIDTH, 60)];
    recommended_label.text = [Gobal loadAppSetting:BASE_KEY_myCode];
    recommended_label.font = [UIFont systemFontOfSize:30.0];
    recommended_label.textAlignment = NSTextAlignmentCenter;
    recommended_label.textColor = [UIColor colorWithRed:241/255.0 green:251/255.0 blue:34/255.0 alpha:1.0];
    [header_imgV addSubview:recommended_label];
    
}
#pragma mark -- init/layout
- (void)initLayout {

    text_label = [[UILabel alloc] initWithFrame:CGRectMake(0, (313/375.0)*SCREEN_WIDTH+10, SCREEN_WIDTH, 20)];
    text_label.textAlignment = NSTextAlignmentCenter;
    text_label.textColor = TITLE_FONT_COLOR;
    text_label.text = @"发邀请函给好友(们)拿免息券";
    text_label.font = [UIFont systemFontOfSize:15.0];
    [self.view addSubview:text_label];

    NSArray *img = @[@"share_WX",@"share_QQ",@"share_space",@"share_friends"];
    NSArray *arr = @[@"微信",@"QQ",@"QQ空间",@"朋友圈"];
    for (int i = 0; i<4; i++) {
        CGFloat w = (SCREEN_WIDTH-240)/5.0;
        share_Btn = [UIButton buttonWithType:UIButtonTypeCustom];
        share_Btn.frame = CGRectMake(w+(w+60)*i, CGRectGetMaxY(text_label.frame)+10, 60, 60);
        [share_Btn setBackgroundImage:[UIImage imageNamed:img[i]] forState:UIControlStateNormal];
        [share_Btn addTarget:self action:@selector(shareBtnAction:) forControlEvents:UIControlEventTouchUpInside];
        share_Btn.tag = i+1;
        [self.view addSubview:share_Btn];
        
        share_title = [[UILabel alloc] init];
        share_title.frame = CGRectMake(w+(w+60)*i, CGRectGetMaxY(share_Btn.frame)+5, 60, 20);
        share_title.textAlignment = NSTextAlignmentCenter;
        share_title.textColor = WORD_FONT_COLOR;
        share_title.text = arr[i];
        share_title.font = [UIFont systemFontOfSize:12.0];
        [self.view addSubview:share_title];
    }
}
#pragma mark - Event
#pragma mark -- Event/分享
- (void)shareBtnAction:(UIButton *)sender {

    switch (sender.tag) {
        case 1:{//微信聊天
            [self shareTextToPlatformType:UMSocialPlatformType_WechatSession];
        }
            break;
        case 2:{//QQ聊天页面
            [self shareTextToPlatformType:UMSocialPlatformType_QQ];
        }
            break;
        case 3:{//qq空间
            [self shareTextToPlatformType:UMSocialPlatformType_Qzone];
        }
            break;
        case 4:{//微信朋友圈
            [self shareTextToPlatformType:UMSocialPlatformType_WechatTimeLine];
        }
            break;
        default:
            break;
    }

}
//分享文本
- (void)shareTextToPlatformType:(UMSocialPlatformType)platformType
{
    //创建分享消息对象
    UMSocialMessageObject *messageObject = [UMSocialMessageObject messageObject];
    //设置文本
    messageObject.text = @"仟易贷";
    //创建网页内容对象
    NSString *share_str = [NSString stringWithFormat:@"一起来变土豪,我的邀请码是：%@",[Gobal loadAppSetting:BASE_KEY_myCode]];
    UIImage *img = [UIImage imageNamed:@"home_logo"];
    UMShareWebpageObject *shareObject = [UMShareWebpageObject shareObjectWithTitle:@"我正在使用仟易贷" descr:share_str thumImage:img];
    //设置网页地址
    shareObject.webpageUrl = QYDShare_URL([Gobal loadAppSetting:BASE_KEY_memberId]);
    
    //分享消息对象设置分享内容对象
    messageObject.shareObject = shareObject;
    
    //调用分享接口
    [[UMSocialManager defaultManager] shareToPlatform:platformType messageObject:messageObject currentViewController:self completion:^(id data, NSError *error) {
        if (error) {
            NSLog(@"Share fail with error %@",error);
            UMSocialLogInfo(@"************Share fail with error %@*********",error);
        }else{
            if ([data isKindOfClass:[UMSocialShareResponse class]]) {
                UMSocialShareResponse *resp = data;
                //分享结果消息
                UMSocialLogInfo(@"response message is %@",resp.message);
                //第三方原始返回的数据
                UMSocialLogInfo(@"response originalResponse data is %@",resp.originalResponse);
                
            }else{
                UMSocialLogInfo(@"response data is %@",data);
            }
        }
    }];
}
#pragma mark -- Event/back
-(void)popBack {
    self.navigationController.navigationBar.hidden = YES;
    [[AppDelegate getInstance].mainTabController showTabbarView];
    [[AppDelegate getInstance].CurNavController popToRootViewControllerAnimated:YES];
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

@end
