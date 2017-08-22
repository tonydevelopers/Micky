//
//  BorrowViewController.m
//  MickyEasyCredit
//
//  Created by 张宁 on 2017/4/8.
//  Copyright © 2017年 apple. All rights reserved.
//

#import "BorrowViewController.h"
#import "AFNetworking.h"
#import "AppDelegate.h"

#import "CouponModel.h"
#import "BankListModel.h"
#import "DYScrollRulerView.h"
#import "ConfirmBorrowView.h"
#import "BankViewController.h"
#import "CouponViewController.h"

#import "ExternalLinksViewController.h"

@interface BorrowViewController ()<UITableViewDelegate,UITableViewDataSource,UITextFieldDelegate,UIActionSheetDelegate,UIAlertViewDelegate,DYScrollRulerDelegate,ConfirmBorrowDelegate,BankDelegate,CouponDelegate>
{
    UILabel *titleLabel;
    NSMutableArray *data_A;
    UITableView *Borrow_Table;
    
    UIView *header_View;
    UIView *footer_View;
    UILabel *text_label;
    UIImageView *select_imgV;
    
    UIButton *select_Btn;
    UILabel *myagree_Label;
    UIButton *agree_Btn;
    UIButton *borrow_Btn;
    UIButton *contract_Btn;
    UIButton *withhold_Btn;

    UIButton *apply_Btn;
    NSString *money_str;
    BOOL     is_select;
    NSString *time_day;
    float money;
    NSString *couponId_string;
    NSString *bindNo_string;
    NSString *cardId_string;
    NSString *jeeplus_user_say;


}
@property(nonatomic,strong)DYScrollRulerView *rullerView;

@end

@implementation BorrowViewController
- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    NAVIGATIONBAR_COLOR_STYLE(BUTTON_COLOR_NORMA,UIStatusBarStyleLightContent);
}
- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = BACKGROUND_COLOR;
    self.navigationController.navigationBar.hidden = NO;
    [[UIApplication sharedApplication] setStatusBarStyle:UIStatusBarStyleLightContent];
    
    [self initData];
    [self initNavigate];
    [self initTable];
}
#pragma mark - init
#pragma mark -- init/Data
- (void)initData {
    //查看资料信息
    is_select = YES;
}
#pragma mark -- init/navigate
- (void)initNavigate {
    
    UIView *navTitleView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 150, 30)];
    titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 5, navTitleView.frame.size.width-5, 20)];
    titleLabel.textAlignment = NSTextAlignmentCenter;
    titleLabel.textColor = [UIColor whiteColor];
    titleLabel.text = @"我要借款";
    titleLabel.font = [UIFont systemFontOfSize:20.0];
    [navTitleView addSubview:titleLabel];
    self.navigationItem.titleView = navTitleView;
    self.navigationController.navigationBar.backgroundColor = [UIColor clearColor];
    
    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    button.frame = CGRectMake(0,0,53,44);
    button.backgroundColor = [UIColor clearColor];
    [button setImage:[UIImage imageNamed:@"navbar_back"] forState:UIControlStateNormal];
    [button setImageEdgeInsets:UIEdgeInsetsMake(0, -40, 0, 0)];
    [button addTarget:self action:@selector(popBack) forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem *barButtonItem = [[UIBarButtonItem alloc] initWithCustomView:button];
    [self.navigationItem setLeftBarButtonItem:barButtonItem];
    
}
#pragma mark -- init/Table
- (void)initTable {
    
    Borrow_Table = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT-64) style:UITableViewStylePlain];
    Borrow_Table.delegate = self;
    Borrow_Table.dataSource = self;
    Borrow_Table.showsVerticalScrollIndicator = NO;
    Borrow_Table.showsHorizontalScrollIndicator = NO;
    Borrow_Table.backgroundColor = BACKGROUND_COLOR;
    Borrow_Table.separatorStyle = UITableViewCellSeparatorStyleNone;
    [self.view addSubview:Borrow_Table];
    
    [self initHeader];
}
#pragma mark -- init/Footer
- (void)initHeader {
    
    header_View = [[UIView alloc]init];
    header_View.backgroundColor = BUTTON_COLOR_NORMA;
    header_View.frame = CGRectMake(0, 0, SCREEN_WIDTH, 150);
    Borrow_Table.tableHeaderView = header_View;
    
    text_label = [[UILabel alloc]init];
    text_label.font = [UIFont systemFontOfSize:13];
    text_label.text = @"借款金额(元)";
    text_label.textColor = [UIColor whiteColor];
    text_label.textAlignment = NSTextAlignmentCenter;
    text_label.backgroundColor = [UIColor clearColor];
    text_label.frame = CGRectMake(0, 10, SCREEN_WIDTH, 20);
    [header_View addSubview:text_label];
    [header_View addSubview:self.rullerView];
    
    footer_View = [[UIView alloc]init];
    footer_View.backgroundColor = [UIColor clearColor];
    footer_View.frame = CGRectMake(0, 0, SCREEN_WIDTH, 130);
    Borrow_Table.tableFooterView = footer_View;
    
    select_Btn = [UIButton buttonWithType:UIButtonTypeCustom];
    select_Btn.frame = CGRectMake(15, 30, 20, 20);
    [select_Btn setBackgroundImage:[UIImage imageNamed:@"select_agree_Y"] forState:UIControlStateNormal];
    [select_Btn setBackgroundImage:[UIImage imageNamed:@"select_agree_N"] forState:UIControlStateSelected];
    [select_Btn addTarget:self action:@selector(selectAgreeBtnAction:) forControlEvents:UIControlEventTouchUpInside];
    [footer_View addSubview:select_Btn];
    
    
    myagree_Label = [[UILabel alloc]init];
    myagree_Label.font = [UIFont systemFontOfSize:13];
    myagree_Label.text = @"我已阅读并同意";
    myagree_Label.textColor = TITLE_FONT_COLOR;
    myagree_Label.textAlignment = NSTextAlignmentCenter;
    myagree_Label.backgroundColor = [UIColor clearColor];
    [footer_View addSubview:myagree_Label];
    [myagree_Label mas_updateConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(select_Btn.mas_top).offset(0);
        make.left.equalTo(select_Btn.mas_right).offset(0);
        make.height.equalTo(@20);
        make.width.equalTo(@100);
    }];

    agree_Btn = [UIButton buttonWithType:UIButtonTypeCustom];
    agree_Btn.backgroundColor = [UIColor clearColor];
    [agree_Btn setTitle:@"《费用说明》" forState:UIControlStateNormal];
    [agree_Btn setTitleColor:RGBColor(51, 118, 187) forState:UIControlStateNormal];
    [agree_Btn addTarget:self action:@selector(costsThatAction:) forControlEvents:UIControlEventTouchUpInside];
    agree_Btn.titleLabel.font = [UIFont systemFontOfSize:13];
    agree_Btn.tag = 0;
    [footer_View addSubview:agree_Btn];
    [agree_Btn mas_updateConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(myagree_Label.mas_top).offset(0);
        make.left.equalTo(myagree_Label.mas_right).offset(0);
        make.height.equalTo(@20);
        make.width.equalTo(@80);
    }];
    
    borrow_Btn = [UIButton buttonWithType:UIButtonTypeCustom];
    borrow_Btn.backgroundColor = [UIColor clearColor];
    [borrow_Btn setTitle:@"《借款合同》" forState:UIControlStateNormal];
    [borrow_Btn setTitleColor:RGBColor(51, 118, 187) forState:UIControlStateNormal];
    [borrow_Btn addTarget:self action:@selector(costsThatAction:) forControlEvents:UIControlEventTouchUpInside];
    borrow_Btn.titleLabel.font = [UIFont systemFontOfSize:13];
    borrow_Btn.tag = 1;
    [footer_View addSubview:borrow_Btn];
    [borrow_Btn mas_updateConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(myagree_Label.mas_top).offset(0);
        make.left.equalTo(agree_Btn.mas_right).offset(0);
        make.height.equalTo(@20);
        make.width.equalTo(@80);
    }];
    
    contract_Btn = [UIButton buttonWithType:UIButtonTypeCustom];
    contract_Btn.backgroundColor = [UIColor clearColor];
    [contract_Btn setTitle:@"《代扣协议》" forState:UIControlStateNormal];
    [contract_Btn setTitleColor:RGBColor(51, 118, 187) forState:UIControlStateNormal];
    [contract_Btn addTarget:self action:@selector(costsThatAction:) forControlEvents:UIControlEventTouchUpInside];
    contract_Btn.titleLabel.font = [UIFont systemFontOfSize:13];
    contract_Btn.tag = 2;
    [footer_View addSubview:contract_Btn];
    
    if (SCREEN_WIDTH>360) {
        [contract_Btn mas_updateConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(myagree_Label.mas_top).offset(0);
            make.left.equalTo(borrow_Btn.mas_right).offset(0);
            make.height.equalTo(@20);
            make.width.equalTo(@80);
        }];
    }else {
        [contract_Btn mas_updateConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(myagree_Label.mas_bottom).offset(0);
            make.left.equalTo(select_Btn.mas_right).offset(0);
            make.height.equalTo(@20);
            make.width.equalTo(@80);
        }];
    }
    
    withhold_Btn = [UIButton buttonWithType:UIButtonTypeCustom];
    withhold_Btn.backgroundColor = [UIColor clearColor];
    [withhold_Btn setTitle:@"《借款人服务协议》" forState:UIControlStateNormal];
    [withhold_Btn setTitleColor:RGBColor(51, 118, 187) forState:UIControlStateNormal];
    [withhold_Btn addTarget:self action:@selector(costsThatAction:) forControlEvents:UIControlEventTouchUpInside];
    withhold_Btn.titleLabel.font = [UIFont systemFontOfSize:13];
    withhold_Btn.tag = 3;
    [footer_View addSubview:withhold_Btn];
    
    if (SCREEN_WIDTH>360) {
        [withhold_Btn mas_updateConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(myagree_Label.mas_bottom).offset(0);
            make.left.equalTo(agree_Btn.mas_left).offset(0);
            make.height.equalTo(@20);
            make.width.equalTo(@120);
        }];
    }else {
        [withhold_Btn mas_updateConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(contract_Btn.mas_top).offset(0);
            make.left.equalTo(contract_Btn.mas_right).offset(0);
            make.height.equalTo(@20);
            make.width.equalTo(@120);
        }];
    }

    
    
    apply_Btn = [UIButton buttonWithType:UIButtonTypeCustom];
    apply_Btn.frame = CGRectMake(15, CGRectGetHeight(footer_View.frame)-45, SCREEN_WIDTH-30, 45);
    [apply_Btn setTitle:@"立即申请" forState:UIControlStateNormal];
    [apply_Btn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [apply_Btn setBackgroundImage:[Gobal imageWithColor:BUTTON_COLOR_NORMA size:apply_Btn.frame.size] forState:UIControlStateNormal];
    [apply_Btn setBackgroundImage:[Gobal imageWithColor:BUTTON_COLOR_HIGHT size:apply_Btn.frame.size] forState:UIControlStateHighlighted];
    [apply_Btn addTarget:self action:@selector(applyConfirmBtnAction) forControlEvents:UIControlEventTouchUpInside];
    apply_Btn.layer.cornerRadius = 5;
    apply_Btn.layer.masksToBounds = YES;
    [footer_View addSubview:apply_Btn];
}
-(DYScrollRulerView *)rullerView{
    if (!_rullerView) {
        NSString *unitStr = @"￥";
        CGFloat rullerHeight = [DYScrollRulerView rulerViewHeight];
        _rullerView = [[DYScrollRulerView alloc]initWithFrame:CGRectMake(5, 20, ScreenWidth-10, rullerHeight) theMinValue:500 theMaxValue:1000 theStep:10 theUnit:unitStr theNum:10];
        [_rullerView setDefaultValue:500 animated:YES];
        _rullerView.bgColor = [UIColor clearColor];
        _rullerView.triangleColor   = [UIColor whiteColor];
        _rullerView.delegate        = self;
        _rullerView.scrollByHand    = YES;
    }
    return _rullerView;
}
#pragma mark - delegate
#pragma mark -- delegate/table
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 5;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    switch (section) {
        case 0:{
            return 1;
        }
            break;
        case 1:{
            return 2;
        }
            break;
        case 2:{
            return 1;
        }
            break;
        case 3:{
            return 1;
        }
            break;
        case 4:{
            return 1;
        }
            break;
        default:
            break;
    }
    return 1;
}
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    switch (section) {
        case 0:{
            return 10;
        }
            break;
        case 1:{
            return 10;
        }
            break;
        case 2:{
            return 10;
        }
            break;
        case 3:{
            return 0;
        }
            break;
        case 4:{
            return 0;
        }
            break;
        default:
            break;
    }
    return 10;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 44;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    switch (indexPath.section) {
        case 0:{
            static NSString *oneCell = @"oneCell";
            UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:oneCell];
            if (!cell) {
                cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:oneCell];
                //cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
                cell.selectionStyle = UITableViewCellSelectionStyleNone;
                cell.textLabel.textColor = WORD_FONT_COLOR;
                cell.textLabel.text = @"借款周期";
                
                UILabel *day_label = [[UILabel alloc]init];
                day_label = [[UILabel alloc]init];
                day_label.font = [UIFont systemFontOfSize:15];
//                day_label.text = [Gobal isEmptyString:time_day]?@"15天":[NSString stringWithFormat:@"%@天",time_day];
                day_label.text = @"15天";
                day_label.textColor = TITLE_FONT_COLOR;
                day_label.textAlignment = NSTextAlignmentRight;
                day_label.backgroundColor = [UIColor clearColor];
                day_label.frame = CGRectMake(SCREEN_WIDTH-135, 0, 120, cell.frame.size.height);
                day_label.tag = 123;
                [cell addSubview:day_label];
            }
            UILabel *day_label = (UILabel *)[cell viewWithTag:123];
            day_label.text =  [Gobal isEmptyString:time_day]?@"15天":[NSString stringWithFormat:@"%@天",time_day];
            return cell;
        }
            break;
        case 1:{
            NSArray *left_arr = @[@"借款费用",@"实际到账"];
            static NSString *oneCell = @"twoCell";
            UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:oneCell];
            if (!cell) {
                cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:oneCell];
                cell.selectionStyle = UITableViewCellSelectionStyleNone;
                cell.textLabel.textColor = WORD_FONT_COLOR;
                cell.textLabel.text = left_arr[indexPath.row];
                
                UIView *line = [[UIView alloc]init];
                line.frame = CGRectMake(0, 43.5, SCREEN_WIDTH, 0.5);
                line.backgroundColor = BASE_COLOR_LINE;
                [cell addSubview:line];
                
                UILabel *day_label = [[UILabel alloc]init];
                day_label = [[UILabel alloc]init];
                day_label.font = [UIFont systemFontOfSize:15];
                day_label.textColor = TITLE_FONT_COLOR;
                day_label.textAlignment = NSTextAlignmentRight;
                day_label.backgroundColor = [UIColor clearColor];
                day_label.frame = CGRectMake(SCREEN_WIDTH-135, 0, 120, cell.frame.size.height);
                day_label.tag = 100;
                [cell addSubview:day_label];
            }
            if (indexPath.row == 0) {
                UILabel *day_label = (UILabel *)[cell viewWithTag:100];
                day_label.text =  [Gobal isEmptyString:money_str]?@"500元":[NSString stringWithFormat:@"%@元",money_str];
 
            }else {
                UILabel *day_label = (UILabel *)[cell viewWithTag:100];
                if ([Gobal isEmptyString:money_str]) {
//                    (1-0.0005*15-0.006*15-0.06)
                    money = 500*(1-0.006*15-0.06);

                }else {
                    money = [money_str floatValue]*(1-0.006*15-0.06);
                }
                
                day_label.text = [NSString stringWithFormat:@"%.2f元",money];
            }
            return cell;
        }
            break;
        case 2:{
            static NSString *fourCell = @"twofourCell";
            UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:fourCell];
            if (!cell) {
                cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:fourCell];
                cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
                cell.textLabel.textColor = WORD_FONT_COLOR;
                cell.textLabel.text = @"借款用途";
                
                UILabel *day_label = [[UILabel alloc]init];
                day_label = [[UILabel alloc]init];
                day_label.font = [UIFont systemFontOfSize:15];
                day_label.textColor = TITLE_FONT_COLOR;
                day_label.text =  @"请选择借款用途";
                day_label.textAlignment = NSTextAlignmentRight;
                day_label.backgroundColor = [UIColor clearColor];
                day_label.frame = CGRectMake(SCREEN_WIDTH-210, 0, 180, cell.frame.size.height);
                day_label.tag = 333333;
                [cell addSubview:day_label];
                
                UIView *line = [[UIView alloc]init];
                line.frame = CGRectMake(0, 43.5, SCREEN_WIDTH, 0.5);
                line.backgroundColor = BASE_COLOR_LINE;
                [cell addSubview:line];
            }
            return cell;
        }
            break;

        case 3:{
            static NSString *oneCell = @"threeCell";
            UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:oneCell];
            if (!cell) {
                cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:oneCell];
                cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
                cell.textLabel.textColor = WORD_FONT_COLOR;
                cell.textLabel.text = @"入账银行";
                
                UILabel *day_label = [[UILabel alloc]init];
                day_label = [[UILabel alloc]init];
                day_label.font = [UIFont systemFontOfSize:15];
                day_label.text =  @"请选择入账银行";
                day_label.textColor = TITLE_FONT_COLOR;
                day_label.textAlignment = NSTextAlignmentRight;
                day_label.backgroundColor = [UIColor clearColor];
                day_label.frame = CGRectMake(SCREEN_WIDTH-210, 0, 180, cell.frame.size.height);
                day_label.tag = 123321;
                [cell addSubview:day_label];
                
                UIView *line = [[UIView alloc]init];
                line.frame = CGRectMake(0, 43.5, SCREEN_WIDTH, 0.5);
                line.backgroundColor = BASE_COLOR_LINE;
                [cell addSubview:line];
            }
         
            return cell;
        }
            break;
        case 4:{
            static NSString *fourCell = @"fourCell";
            UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:fourCell];
            if (!cell) {
                cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:fourCell];
                cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
                cell.textLabel.textColor = WORD_FONT_COLOR;
                cell.textLabel.text = @"选择优惠券";
                
                UILabel *day_label = [[UILabel alloc]init];
                day_label = [[UILabel alloc]init];
                day_label.font = [UIFont systemFontOfSize:15];
                day_label.textColor = TITLE_FONT_COLOR;
                day_label.text =  @"请选择免息优惠券";
                day_label.textAlignment = NSTextAlignmentRight;
                day_label.backgroundColor = [UIColor clearColor];
                day_label.frame = CGRectMake(SCREEN_WIDTH-210, 0, 180, cell.frame.size.height);
                day_label.tag = 222222;
                [cell addSubview:day_label];
                
                UIView *line = [[UIView alloc]init];
                line.frame = CGRectMake(0, 43.5, SCREEN_WIDTH, 0.5);
                line.backgroundColor = BASE_COLOR_LINE;
                [cell addSubview:line];

            }
            return cell;
        }
            break;
        default:
            break;
    }
    return nil;
}
- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    return [Gobal drawSolidLinePointX:0 PointY:0 lineW:SCREEN_WIDTH lineH:20 lineColor:@[@"240",@"240",@"240"] lineAlpha:1.0];
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    switch (indexPath.section) {
        case 0:
        
            break;
        case 1:
            
            break;
        case 2:{
            UIActionSheet *sheet = [[UIActionSheet alloc]initWithTitle:@"请选择借款用途" delegate:self cancelButtonTitle:@"取消" destructiveButtonTitle:nil otherButtonTitles:@"支付学费",@"消费购物",@"旅游",@"创业", nil];
            [sheet showInView:self.view];
        }
            break;
        case 3:{
            [[AppDelegate getInstance].mainTabController hideTabbarView];
            BankViewController *BVC = [[BankViewController alloc]init];
            BVC.isBankBack = YES;
            BVC.delegate = self;
            [[AppDelegate getInstance].CurNavController pushViewController:BVC animated:YES];
        }
            break;
        case 4:{
            [[AppDelegate getInstance].mainTabController hideTabbarView];
            CouponViewController *BVC = [[CouponViewController alloc]init];
            BVC.isPopBack = YES;
            BVC.delegate = self;
            [[AppDelegate getInstance].CurNavController pushViewController:BVC animated:YES];
        }
            break;
        default:
            break;
    }
}
#pragma mark -- delegate/DYScrollRulerView
-(void)dyScrollRulerView:(DYScrollRulerView *)rulerView valueChange:(float)value {
    money_str = [NSString stringWithFormat:@"%.f",value];
    [Borrow_Table reloadData];
}
#pragma mark -- delegate/UIActionSheetDelegate
- (void)actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex {
    UILabel *day_label = (UILabel *)[self.view viewWithTag:333333];
    switch (buttonIndex) {
        case 0:{
            day_label.text = @"支付学费";
            jeeplus_user_say = @"1";
        }
            break;
        case 1:{
            day_label.text = @"消费购物";
            jeeplus_user_say = @"2";
        }
            break;
        case 2:{
            day_label.text = @"旅游";
            jeeplus_user_say = @"3";
        }
            break;
        case 3:{
            day_label.text = @"创业";
            jeeplus_user_say = @"4";
        }
            break;
        default:
            break;
    }
    [Borrow_Table reloadData];
}
#pragma mark -- delegate/ConfirmBorrowDelegate
- (void)confirmBorrow {
    [self confirmLoanDataRequest];
}
#pragma mark -- delegate/BankDelegate
- (void)selectBankInfoModel:(BankListModel*)model {
    bindNo_string = model.bindNo;
    cardId_string = model.cardId;
    UILabel *day_label = (UILabel *)[self.view viewWithTag:123321];
    day_label.text = [Gobal isEmptyString:model.cardName]?@"--":model.cardName;
}
#pragma mark -- delegate/CouponDelegate
- (void)selectCouponModel:(CouponModel *)model {
    couponId_string = model.Id;
    UILabel *day_label = (UILabel *)[self.view viewWithTag:222222];
    day_label.text =  [Gobal isEmptyString:model.name]?@"--":model.name;
}
#pragma mark - Event
#pragma mark -- Event/费用说明
- (void)costsThatAction:(UIButton *)sender {
    switch (sender.tag) {
        case 0:{//费用说明
            [[AppDelegate getInstance].mainTabController hideTabbarView];
            ExternalLinksViewController *ELVC = [[ExternalLinksViewController alloc]init];
            ELVC.class_name = @"费用说明";
            ELVC.externalLink_url = WEBURL(WEB_EXPLAIN);
            [[AppDelegate getInstance].CurNavController pushViewController:ELVC animated:YES];
        }
            break;
        case 1:{//借款合同
            [[AppDelegate getInstance].mainTabController hideTabbarView];
            ExternalLinksViewController *ELVC = [[ExternalLinksViewController alloc]init];
            ELVC.class_name = @"借款合同";
            ELVC.externalLink_url = [NSString stringWithFormat:@"%@?userId=%@&jkAmount=%@",PUBLIC_WEBURL(LOANPROTOCOL),[Gobal loadAppSetting:BASE_KEY_memberId],[Gobal isEmptyString:money_str]?@"500":money_str];
            [[AppDelegate getInstance].CurNavController pushViewController:ELVC animated:YES];
        }
            break;
        case 2:{//借款合同
            if ([Gobal isEmptyString:cardId_string]) {
                [CustomHUD createShowContent:@"请选择银行卡" hiddenTime:4.5];
                return;
            }
            [[AppDelegate getInstance].mainTabController hideTabbarView];
            ExternalLinksViewController *ELVC = [[ExternalLinksViewController alloc]init];
            ELVC.class_name = @"代扣协议";
            ELVC.externalLink_url = [NSString stringWithFormat:@"%@?userId=%@&cardId=%@",PUBLIC_WEBURL(WITHHOLDAGREEMENT),[Gobal loadAppSetting:BASE_KEY_memberId],cardId_string];
            [[AppDelegate getInstance].CurNavController pushViewController:ELVC animated:YES];
        }
            break;
        case 3:{//借款协议
            [[AppDelegate getInstance].mainTabController hideTabbarView];
            ExternalLinksViewController *ELVC = [[ExternalLinksViewController alloc]init];
            ELVC.class_name = @"借款人服务协议";
            ELVC.externalLink_url = WEBURL(WEB_SERVICEPROTOCOL);
            [[AppDelegate getInstance].CurNavController pushViewController:ELVC animated:YES];
        }
            break;
        default:
            break;
    }
}
#pragma mark -- Event/是否同意说明
- (void)selectAgreeBtnAction:(UIButton *)sender {
    sender.selected = !sender.selected;
    if (sender.selected == YES) {
        is_select = NO;
    }else {
        is_select = YES;
    }
}
#pragma mark -- Event/立即申请
- (void)applyConfirmBtnAction {
    if (is_select == NO) {
        [CustomHUD createShowContent:@"请仔细阅读《费用说明》《借款人服务协议》《借款合同》《代扣协议》" hiddenTime:2.4];
        return;
    }
    apply_Btn.enabled = NO;
    [apply_Btn setTitle:@"申请中..." forState:UIControlStateNormal];
    [self confirmLoanDataRequest];
//    ConfirmBorrowView *cbv = [[ConfirmBorrowView alloc]initWithBorrow:[Gobal isEmptyString:money_str]?@"500":money_str timeLimit:[Gobal isEmptyString:time_day]?@"20":time_day serviceFee:@"100" repaymentAmount:[Gobal isEmptyString:money_str]?@"500":money_str];
//    cbv.delegate = self;
//    [cbv show];
}
#pragma mark - Data
#pragma mark -- Data/立即申请借款／确认
- (void)confirmLoanDataRequest {
    float mney_string;
    if ([Gobal isEmptyString:money_str]) {
        mney_string = 500*(0.006*15+0.06);
    }else {
        mney_string = [money_str floatValue]*(0.006*15+0.06);
    }
    
    NSString *coupon_Id =  [Gobal isEmptyString:couponId_string]?@"":couponId_string;
    NSString *bind_No = [Gobal isEmptyString:bindNo_string]?@"":bindNo_string;
    NSString *card_Id = [Gobal isEmptyString:cardId_string]?@"":cardId_string;
    NSString *user_Id = [Gobal loadAppSetting:BASE_KEY_memberId];
    
    NSDictionary *parameters = @{
                                 @"userId"   : [Gobal isEmptyString:user_Id]?@"":user_Id,
                                 @"jkAmount" :[Gobal isEmptyString:money_str]?@"500":money_str,
                                 @"jkFee"    :[NSString stringWithFormat:@"%.2f",mney_string],
                                 
                                 @"jkValidate" :@"15",
                                 @"hkAmount" :[NSString stringWithFormat:@"%.2f",[Gobal isEmptyString:money_str]?500:[money_str floatValue]],
                                 @"loanUseType" : [Gobal isEmptyString:jeeplus_user_say]?@"":jeeplus_user_say,
                                 @"couponId" : coupon_Id,
                                 @"cardId" : card_Id,
                                 @"bindNo" : bind_No,
                                 };

    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    manager.responseSerializer.acceptableContentTypes = [NSSet setWithObject:@"text/plain"];
    [manager POST:PUBLIC_URL(CONFIRMLOAN) parameters:parameters success:^(AFHTTPRequestOperation *operation,id responseObject) {
        apply_Btn.enabled = YES;
        [apply_Btn setTitle:@"立即申请" forState:UIControlStateNormal];
        NSLog(@"confirmLoan_success: %@", responseObject);
        if ([responseObject[@"status"] isEqualToString:@"100"]) {
            
            UIAlertView *alert = [[UIAlertView alloc]initWithTitle:@"温馨提示" message:@"您的申请已经提交,请耐心等待" delegate:self cancelButtonTitle:@"好" otherButtonTitles: nil];
            [alert show];
            
        }else {
            [CustomHUD createShowContent:responseObject[@"message"] hiddenTime:4.5];
        }
        
    }failure:^(AFHTTPRequestOperation *operation,NSError *error) {
        [CustomHUD createShowContent:@"网络链接失败,请检查是否链接网络" hiddenTime:2.4];
    }];
}
- (void)alertView:(UIAlertView *)alertView didDismissWithButtonIndex:(NSInteger)buttonIndex {
    [[AppDelegate getInstance].mainTabController hideTabbarView];
    ExternalLinksViewController *ELVC = [[ExternalLinksViewController alloc]init];
    ELVC.class_name = @"借款查询";
    ELVC.isRooterEnter = YES;
    ELVC.externalLink_url = [NSString stringWithFormat:@"%@?userId=%@",PUBLIC_WEBURL(WEB_TOLOAN),[Gobal loadAppSetting:BASE_KEY_memberId]];
    [[AppDelegate getInstance].CurNavController pushViewController:ELVC animated:YES];
//    [self popBack];
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
