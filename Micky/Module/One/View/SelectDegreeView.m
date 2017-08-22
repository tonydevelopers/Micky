//
//  SelectDegreeView.m
//  EyeShop
//
//  Created by 陈鼎 on 16/10/12.
//  Copyright © 2016年  阳海浪. All rights reserved.
//

#import "SelectDegreeView.h"
#import "AppDelegate.h"
#import "ColorMacros.h"
#import "UIImageView+WebCache.h"
#import "UIButton+WebCache.h"
#import "InternationalCintrol.h"

#define SELF_WIDTH   [UIScreen mainScreen].bounds.size.width
#define SELF_HEIGHT  [UIScreen mainScreen].bounds.size.height
#define OneItem      @"SelectCollectCell"

@implementation  SelectTwoCell
@synthesize sdv;

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        
        sdv = [[SelectDegreePumberView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 260)];
        sdv.delegate = self;
        [self.contentView addSubview:sdv];

    }
    return self;
}
- (void)setSelectDegree:(NSArray *)degreearray {
    sdv.data_Aarry = [NSMutableArray arrayWithArray:degreearray];
}
-(void)selectDegreeCollect:(NSString *)degree_str{
    NSLog(@"左眼度数 == selectDegreeCollect == %@",degree_str);
    [self.delegate leftSelectTwoDegree:degree_str];
}
-(void)selectNumberCollect:(NSString *)number_str {
    NSLog(@"左眼数量 == selectNumberCollect == %@",number_str);
    [self.delegate leftSelectTwoNumber:number_str];
}

@end

#pragma mark --
#pragma mark --

@implementation  SelectThreeCell
@synthesize srv;

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        srv = [[SelectDegreeRightView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 260)];
        srv.delegate = self;
        [self.contentView addSubview:srv];
    }
    return self;
}
- (void)setSelectDegree:(NSArray *)degreearray {
    srv.data_Aarry = [NSMutableArray arrayWithArray:degreearray];
}
-(void)selectRightDegreeCollect:(NSString *)degree_str{
    NSLog(@"左眼度数 == selectDegreeCollect == %@",degree_str);
    [self.delegate rightSelectThreeDegree:degree_str];
}
-(void)selectRightNumberCollect:(NSString *)number_str {
    NSLog(@"左眼数量 == selectNumberCollect == %@",number_str);
    [self.delegate rightSelectThreeNumber:number_str];
}

@end

@interface SelectDegreeView ()<UITableViewDelegate,UITableViewDataSource,SelectTwoDelegate,SelectThreeDelegate>

@end

@implementation SelectDegreeView
{
    UIView *bg_view;
    UIView *clickView;
    UILabel *number_label;
    
    UIImageView *smallImage;
    UILabel *title_label;
    UILabel *daller_label;
    UILabel *select_label;
    
    UITableView *selected_Table;
    UITapGestureRecognizer *tapGestureRecognizer;
    NSString *product_Id_str;
    NSMutableArray *color_array;
    
    NSString *left_degree;
    NSString *right_degree;
    NSString *left_number;
    NSString *right_number;
    NSMutableArray *shopCart_Array;
    NSArray *value_degree_A;
    
    BOOL left_eye;
    BOOL right_eye;
    BOOL is_push_view;
    
}
@synthesize  addCart_Btn;
@synthesize  bugCart_Btn;

static dispatch_once_t onceToken;
+(instancetype)shareSelectDegreeView {
    static SelectDegreeView *select = nil;
    dispatch_once(&onceToken, ^{
        select = [[SelectDegreeView alloc]init];
    });
    return select;
}
-(instancetype)initWithFrame:(CGRect)frame
{
    NSString *isSmple = [Gobal loadAppSetting:BaeKey_switch_Simplified_traditional];
    self = [super initWithFrame:frame];
    if (self) {
        
        self.backgroundColor = [UIColor colorWithWhite:0 alpha:0.5];
        self.frame = CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT);
        self.hidden = YES;
        self.alpha = 0.0;
        
        bg_view = [[UIView alloc]init];
        bg_view.frame = CGRectMake(0, 1000, SELF_WIDTH, SELF_HEIGHT - 150);
        bg_view.backgroundColor = [UIColor whiteColor];
        bg_view.alpha = 0.0;
        bg_view.hidden = YES;
        [self addSubview:bg_view];
        
        smallImage = [[UIImageView alloc]init];
        smallImage.frame = CGRectMake(10, 1000, 120, 120);
        smallImage.backgroundColor = [UIColor whiteColor];
        smallImage.image = [UIImage imageNamed:@"header_photo"];
        smallImage.layer.borderColor = [UIColor whiteColor].CGColor;
        smallImage.layer.borderWidth = 2.0;
        smallImage.alpha = 0.0;
        smallImage.hidden = YES;
        [self addSubview:smallImage];
        //产品名
        title_label = [[UILabel alloc]init];
        title_label.frame = CGRectMake(140, 10, SELF_WIDTH-150, 30);
        title_label.backgroundColor = [UIColor clearColor];
        title_label.text = @"--";
        title_label.textColor = WORD_FONT_COLOR;
        title_label.font = [UIFont systemFontOfSize:16];
        title_label.textAlignment = NSTextAlignmentLeft;
        [bg_view addSubview:title_label];
        //产品价格
        daller_label = [[UILabel alloc]init];
        daller_label.frame = CGRectMake(CGRectGetMinX(title_label.frame), CGRectGetMaxY(title_label.frame), SELF_WIDTH-150, 25);
        daller_label.backgroundColor = [UIColor clearColor];
        daller_label.text = @"128";
        daller_label.textColor = [UIColor redColor];
        daller_label.font = [UIFont systemFontOfSize:16];
        daller_label.textAlignment = NSTextAlignmentLeft;
        [bg_view addSubview:daller_label];
        //展示文字
        select_label = [[UILabel alloc]init];
        select_label.frame = CGRectMake(CGRectGetMinX(title_label.frame), CGRectGetMaxY(daller_label.frame), SELF_WIDTH-150, 30);
        select_label.backgroundColor = [UIColor clearColor];
        select_label.text = [isSmple intValue]==1?@"请选择度数":@"請選擇度數";
        select_label.textColor = WORD_FONT_COLOR;
        select_label.font = [UIFont systemFontOfSize:16];
        select_label.textAlignment = NSTextAlignmentLeft;
        [bg_view addSubview:select_label];
        
        UIView *view1 = [[UIView alloc] initWithFrame:CGRectMake(10, CGRectGetMaxY(select_label.frame)+10, SELF_WIDTH - 10, 0.5)];
        view1.backgroundColor = [UIColor blackColor];
        view1.alpha = 0.3;
        [bg_view addSubview:view1];
        
        //产品参数选择
        selected_Table = [[UITableView alloc]initWithFrame:CGRectMake(0, CGRectGetMaxY(view1.frame), SCREEN_WIDTH, SCREEN_HEIGHT-255-50-0.5) style:UITableViewStylePlain];
        selected_Table.delegate = self;
        selected_Table.dataSource = self;
        selected_Table.showsVerticalScrollIndicator = NO;
        selected_Table.showsHorizontalScrollIndicator = NO;
        selected_Table.backgroundColor = BACKGROUND_COLOR;
        selected_Table.separatorStyle = UITableViewCellSeparatorStyleNone;
        [bg_view addSubview:selected_Table];
        
        //加入购物车
        addCart_Btn = [UIButton buttonWithType:UIButtonTypeCustom];
        addCart_Btn.frame = CGRectMake(0, SCREEN_HEIGHT-200, SCREEN_WIDTH/2.0, 50);
        [addCart_Btn setBackgroundImage:[Gobal imageWithColor:BASE_COLOR_Button_H size:addCart_Btn.frame.size] forState:UIControlStateNormal];
        [addCart_Btn setBackgroundImage:[Gobal imageWithColor:BASE_COLOR_Button_N size:addCart_Btn.frame.size] forState:UIControlStateHighlighted];
        [addCart_Btn setTitle:[isSmple intValue]==1?@"加入购物车":@"加入購物車" forState:UIControlStateNormal];
        [addCart_Btn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        addCart_Btn.titleLabel.font = [UIFont systemFontOfSize:16];
        [addCart_Btn addTarget:self action:@selector(leftAddCartBtnAction:) forControlEvents:UIControlEventTouchUpInside];
        [bg_view addSubview:addCart_Btn];
        //立即购买
        bugCart_Btn = [UIButton buttonWithType:UIButtonTypeCustom];
        bugCart_Btn.frame = CGRectMake(SCREEN_WIDTH/2.0, SCREEN_HEIGHT-200, SCREEN_WIDTH/2.0, 50);
        [bugCart_Btn setBackgroundImage:[Gobal imageWithColor:BASE_COLOR_Button_N size:bugCart_Btn.frame.size] forState:UIControlStateNormal];
        [bugCart_Btn setBackgroundImage:[Gobal imageWithColor:BASE_COLOR_Button_H size:bugCart_Btn.frame.size] forState:UIControlStateHighlighted];
        [bugCart_Btn setTitle:[isSmple intValue]==1?@"立即购买":@"立即購買" forState:UIControlStateNormal];
        [bugCart_Btn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        bugCart_Btn.titleLabel.font = [UIFont systemFontOfSize:16];
        [bugCart_Btn addTarget:self action:@selector(rightBugGoodsBtnAction:) forControlEvents:UIControlEventTouchUpInside];
        [bg_view addSubview:bugCart_Btn];
        
        addCart_Btn.hidden = YES;
        bugCart_Btn.hidden = YES;
    
        clickView = [[UIView alloc]init];
        clickView.backgroundColor = [UIColor clearColor];
        clickView.frame = CGRectMake(0, 0, SCREEN_WIDTH, 150);
        [self addSubview:clickView];
        
        
        tapGestureRecognizer = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(dismiss)];
        [clickView addGestureRecognizer:tapGestureRecognizer];
        
    }
    return self;
}
#pragma mark - delegate
#pragma mark -- delegate/table
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 2;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 1;
}
-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section {
    return 0.5;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    switch (indexPath.section) {
        case 0:
            return 265;
            break;
        case 1:
            return 265;
            break;
            
        default:
            break;
    }
    return 50;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    switch (indexPath.section) {
        case 0:{
            static NSString *two = @"twoCell";
            SelectTwoCell *cell = [tableView dequeueReusableCellWithIdentifier:two];
            if (!cell) {
                cell = [[SelectTwoCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:two];
                cell.selectionStyle = UITableViewCellSelectionStyleNone;
                cell.delegate = self;
                
                [cell setSelectDegree:value_degree_A];
            }
            return cell;
        }
            break;
        case 1:{
            static NSString *three = @"threeCell";
            SelectThreeCell *cell = [tableView dequeueReusableCellWithIdentifier:three];
            if (!cell) {
                cell = [[SelectThreeCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:three];
                cell.selectionStyle = UITableViewCellSelectionStyleNone;
                cell.delegate = self;
                [cell setSelectDegree:value_degree_A];
            }
            return cell;
        }
            break;
        default:
            break;
    }
    return nil;
}
- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section {
    UIView *footerView = [[UIView alloc]init];
    footerView.backgroundColor = [UIColor whiteColor];
    
    UIView *view1 = [[UIView alloc] initWithFrame:CGRectMake(10, 0, SELF_WIDTH - 10, 0.5)];
    view1.backgroundColor = [UIColor blackColor];
    view1.alpha = 0.3;
    [footerView addSubview:view1];
    
    return footerView;
}
-(void)setSelectDegreeModel:(GoodsDetailsModel *)selectDegreeModel {
    _selectDegreeModel = selectDegreeModel;
    NSString *isSimple = [Gobal loadAppSetting:BaeKey_switch_Simplified_traditional];

    NSArray *degreeValue_A = _selectDegreeModel.property_Value;
    value_degree_A = [[degreeValue_A[7] objectForKey:@"PropertyValue"] componentsSeparatedByString:@","];
    
    //商品名称
    title_label.text = [selectDegreeModel.Name length]>0?selectDegreeModel.Name:@"--";
    //价钱
    daller_label.text = [NSString stringWithFormat:@"%@:%@",[isSimple isEqualToString:@"1"]?@"¥":@"NT$",[isSimple isEqualToString:@"1"]?[selectDegreeModel.SimplifiedSell_Price length]>0?selectDegreeModel.SimplifiedSell_Price:@"0":[selectDegreeModel.TraditionalSell_Price length]>0?selectDegreeModel.TraditionalSell_Price:@"0"];
    //产品图像
    [smallImage sd_setImageWithURL:[NSURL URLWithString:selectDegreeModel.Cover] placeholderImage:[UIImage imageNamed:@"header_photo"]];

    [self reloadInputViews];
    [selected_Table reloadData];
}
#pragma mark - Event
#pragma mark -- Event/立即购买
-(void)rightBugGoodsBtnAction:(UIButton *)sender {
    
    [self leftAddCartBtnAction:sender];
}
#pragma mark -- Event/左眼度数
-(void)leftSelectTwoDegree:(NSString *)sender {
    left_degree = sender;
}
#pragma mark -- Event/左眼数量
- (void)leftSelectTwoNumber:(NSString *)sender {
    left_number = sender;
}
#pragma mark -- Event/右眼度数
- (void)rightSelectThreeDegree:(NSString *)sender {

    right_degree = sender;
}
#pragma mark -- Event/右眼数量
- (void)rightSelectThreeNumber:(NSString *)sender {
    right_number = sender;
}
#pragma mark -- Event/加入购物车
-(void)leftAddCartBtnAction:(UIButton *)sender {
    
    NSLog(@"Event/加入购物车 == leftAddCartBtnAction == %@",sender);
    
    if (sender == addCart_Btn) {
        is_push_view = NO;
        
    }else if (sender == bugCart_Btn) {
        is_push_view = YES;
    }
    //左眼
    if ([left_degree length]>0) {
        if ([left_number intValue]>0) {
            left_eye = YES;
            if ([right_degree length]>0) {
                if ([right_number intValue]>0) {
                    //右眼
                    right_eye = YES;
                }else{
                    right_eye = NO;
                    [CustomHUD createShowContent:@"请选择购买数量" hiddenTime:3.0];
                    return;
                }
            }else if ([right_number intValue]>0) {
                if (!([right_degree length]>0)) {
                    right_eye = NO;
                    [CustomHUD createShowContent:@"请选择右眼商品度数" hiddenTime:3.0];
                    return;
                }
            }
        }else{
            left_eye = NO;
            [CustomHUD createShowContent:@"请选择购买数量" hiddenTime:3.0];
            return;
        }
    }else if ([left_number intValue]>0) {
        if (!([left_degree length]>0)) {
            left_eye = NO;
            [CustomHUD createShowContent:@"请选择左眼商品度数" hiddenTime:3.0];
            return;
        }
    }else {
        if ([right_degree length]>0) {
            if ([right_number intValue]>0) {
                //右眼
                right_eye = YES;
            }else{
                right_eye = NO;
                [CustomHUD createShowContent:@"请选择购买数量" hiddenTime:3.0];
                return;
            }
        }else if ([right_number intValue]>0) {
            if (!([right_degree length]>0)) {
                right_eye = NO;
                [CustomHUD createShowContent:@"请选择右眼商品度数" hiddenTime:3.0];
                return;
            }
        }else {
            left_eye = NO;
            right_eye = NO;
            [CustomHUD createShowContent:@"请选择商品" hiddenTime:3.0];
            return;
        }
    }
    
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.5 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        if (left_eye == YES && right_eye == YES) {
            [self addShopCartDataRequest:left_degree number:left_number];
        }else if (left_eye == YES && right_eye == NO) {
            [self addShopCartDataRequest:left_degree number:left_number];
        }else if (left_eye == NO && right_eye == YES) {
            [self addShopCartDataRequest:right_degree number:right_number];
        }
    });
    
}

#pragma mark - Data
#pragma mark -- Data/加入购物车
- (void)addShopCartDataRequest:(NSString *)degree number:(NSString *)num {
    _shopCartAPI = [[ShopCartAPI alloc]init];
    _shopCartAPI.delegate = self;
    _shopCartAPI.ignoreCache = YES;
    
    NSString *user_ID = [Gobal  isEmptyString:[Gobal loadAppSetting:BaeKey_userId]]?@"":[Gobal loadAppSetting:BaeKey_userId];
    NSString *product_Id = _selectDegreeModel.Id;
    if (user_ID.length > 0)
    {
        _shopCartAPI.user_Id = user_ID;
        _shopCartAPI.product_Id = [product_Id_str length]>0?product_Id_str:product_Id;
        
        _shopCartAPI.degree = degree;
        _shopCartAPI.counts = num;
        [_shopCartAPI start];
        
    }else {
        [CustomHUD createShowContent:NSLocalizedString(@"statue_login", nil) hiddenTime:3.0];
    }
}
- (void)requestFinished:(APIBaseRequest *)request {
    NSLog(@"succeed_shopCartAPI:%@",_shopCartAPI.responseJSONObject);
    NSDictionary *dic_shop = _shopCartAPI.responseJSONObject;

    if ([dic_shop[@"Status"] isEqualToString:@"0000"]) {
        if (left_eye == YES && right_eye == YES) {
            NSString *shopCart_Id = [[dic_shop[@"InterfaceInfo"] objectAtIndex:0] objectForKey:@"Id"];
            [shopCart_Array addObject:shopCart_Id];
            [self addShopCartDataRequest:right_degree number:right_number];
            left_eye = NO;

        }else if (left_eye == YES && right_eye == NO) {
            NSString *shopCart_Id = [[dic_shop[@"InterfaceInfo"] objectAtIndex:0] objectForKey:@"Id"];
            [shopCart_Array addObject:shopCart_Id];
            //立即购买
            if (is_push_view) {
                [self.delegate bugGoodsBtnAction:shopCart_Array];
            }else {
                //加入购物车
                [CustomHUD createShowContent:@"加入購物車成功" hiddenTime:3.0];
                [self.delegate addShopCartAction:nil];
            }
            left_eye = NO;
            right_eye = NO;
            NSLog(@"left_eye_dic_shop == %@",dic_shop);
            
        }else if (left_eye == NO && right_eye == YES) {
            NSString *shopCart_Id = [[dic_shop[@"InterfaceInfo"] objectAtIndex:0] objectForKey:@"Id"];
            [shopCart_Array addObject:shopCart_Id];
            
            //立即购买
            if (is_push_view) {
                [self.delegate bugGoodsBtnAction:shopCart_Array];
            }else {
                //加入购物车
                [CustomHUD createShowContent:@"加入購物車成功" hiddenTime:3.0];
                [self.delegate addShopCartAction:nil];
            }
            
            left_eye = NO;
            right_eye = NO;
            NSLog(@"right_eye_dic_shop == %@",dic_shop);
        }
//        [self dismiss];
    }
    NSLog(@"shopCart_Array == %@",shopCart_Array);
    
}
- (void)requestFailed:(APIBaseRequest *)request {
    [CustomHUD stopHidden];
    NSLog(@"failed:%@",_shopCartAPI.responseJSONObject);
    [_shopCartAPI stop];
    UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"提示" message:[_shopCartAPI.responseJSONObject objectForKey:@"msg"] delegate:nil cancelButtonTitle:@"确定" otherButtonTitles:nil];
    [alertView show];
}
-(void)showBuyNowBtn {
    
    _data_color_A = [NSMutableArray new];
    color_array = [NSMutableArray new];
    shopCart_Array = [NSMutableArray new];
    //产品颜色
    _goodsColorAPI = [[GoodsColorAPI alloc]init];
    _goodsColorAPI.delegate = self;
    _goodsColorAPI.ignoreCache = YES;
    //加入购物车
    _shopCartAPI = [[ShopCartAPI alloc]init];
    _shopCartAPI.delegate = self;
    _shopCartAPI.ignoreCache = YES;
    
    addCart_Btn.hidden = NO;
    bugCart_Btn.hidden = NO;

    product_Id_str = [NSString string];
    
    __block SelectDegreeView *weakSelf = self;
    UIWindow* window = [UIApplication sharedApplication].keyWindow;
    [window addSubview:weakSelf];
    [UIView animateWithDuration:0.5 animations:^{
        
        weakSelf.hidden = NO;
        bg_view.hidden = NO;
        smallImage.hidden = NO;
        bg_view.alpha = 1.0;
        smallImage.alpha = 1.0;
        weakSelf.alpha = 1.0;
        bg_view.frame = CGRectMake(0, 150, SELF_WIDTH, SELF_HEIGHT - 150);
        smallImage.frame = CGRectMake(10, 120, 120, 120);
        
    } completion:^(BOOL finished) {
    }];
}

-(void)dismiss {
    
    __block SelectDegreeView *weakSelf = self;

    [UIView animateWithDuration:0.5 animations:^{
        
        bg_view.alpha = 0.0;
        smallImage.alpha = 0.0;
        bg_view.frame = CGRectMake(0, 1000, SELF_WIDTH, SELF_HEIGHT - 150);
        smallImage.frame = CGRectMake(10, 1000, 120, 120);
        weakSelf.alpha = 0.0;
        
    } completion:^(BOOL finished) {
//        onceToken = 0;
        weakSelf.hidden = YES;
        bg_view.hidden = YES;
        smallImage.hidden = YES;
        
        addCart_Btn.hidden = YES;
        bugCart_Btn.hidden = YES;
        [weakSelf removeFromSuperview];
        weakSelf = nil;
        
    }];
}

@end


