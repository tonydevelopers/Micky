//
//  SelectDegreeView.h
//  EyeShop
//
//  Created by 陈鼎 on 16/10/12.
//  Copyright © 2016年  阳海浪. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <Foundation/Foundation.h>
#import "GoodsDetailsViewController.h"
#import "SelectDegreePumberView.h"
#import "SelectDegreeRightView.h"

#import "HJCAjustNumButton.h"
#import "GoodsDetailsModel.h"
#import "GoodsColorModel.h"
#import "GoodsColorAPI.h"
#import "ShopCartAPI.h"
#import "Masonry.h"

@protocol SelectTwoDelegate <NSObject>

- (void)leftSelectTwoDegree:(NSString *)sender;
- (void)leftSelectTwoNumber:(NSString *)sender;

@end

@interface SelectTwoCell : UITableViewCell<SelectDegreePumberDelegate>

@property(nonatomic,assign)id<SelectTwoDelegate>delegate;
@property(nonatomic,strong)SelectDegreePumberView *sdv;

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier;
- (void)setSelectDegree:(NSArray *)degreearray;

@end

#pragma mark --
#pragma mark --

@protocol SelectThreeDelegate <NSObject>

- (void)rightSelectThreeDegree:(NSString *)sender;
- (void)rightSelectThreeNumber:(NSString *)sender;

@end
@interface SelectThreeCell : UITableViewCell<SelectDegreeRightDelegate>

@property(nonatomic,assign)id<SelectThreeDelegate>delegate;
@property(nonatomic,strong)SelectDegreeRightView *srv;

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier;
- (void)setSelectDegree:(NSArray *)degreearray;

@end

#pragma mark --
#pragma mark --

@protocol SelectDegreeDelegate <NSObject>

-(void)bugGoodsBtnAction:(NSArray *)sender;
-(void)addShopCartAction:(NSArray *)sender;

@end

@interface SelectDegreeView : UIView<APIRequestDelegate>

@property (nonatomic, assign) id<SelectDegreeDelegate>delegate;

@property (nonatomic, strong) ShopCartAPI *shopCartAPI;
@property (nonatomic, strong) GoodsColorAPI *goodsColorAPI;
@property (nonatomic, strong) NSMutableArray *data_color_A;
@property (nonatomic, strong) NSArray *dataAll;
@property (nonatomic, strong) UIButton *addCart_Btn;
@property (nonatomic, strong) UIButton *bugCart_Btn;

@property (nonatomic, strong) GoodsDetailsModel *selectDegreeModel;

+(instancetype)shareSelectDegreeView;
-(void)showBuyNowBtn;
-(void)dismiss;
-(instancetype)initWithFrame:(CGRect)frame;
-(void)setSelectDegreeModel:(GoodsDetailsModel *)selectDegreeModel;

@end








