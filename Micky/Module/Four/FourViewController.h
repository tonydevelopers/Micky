//
//  FourViewController.h
//  MickyEasyCredit
//
//  Created by 张宁 on 16/10/26.
//  Copyright © 2016年 apple. All rights reserved.
//

#import <UIKit/UIKit.h>



@interface UserTableOneCell : UITableViewCell

@property(nonatomic,strong)UIView *BGView;
@property(nonatomic,strong)UIImageView *left_imageV;
@property(nonatomic,strong)UIImageView *right_imageV;
@property(nonatomic,strong)UILabel *left_label;
- (void)setOneDataImage:(NSInteger)index_image labelData:(NSString *)labelTitle;
- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier;
@end

#pragma mark -

@interface UserTableTwoCell : UITableViewCell
@property(nonatomic,strong)UIView *BGView;
@property(nonatomic,strong)UIImageView *left_imageV;
@property(nonatomic,strong)UIImageView *right_imageV;
@property(nonatomic,strong)UILabel *left_label;
- (void)setTwoDataImage:(NSString *)imageName labelData:(NSString *)labelTitle;
- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier;

@end

#pragma mark -

@interface UserTableThreeCell : UITableViewCell

@property(nonatomic,strong)UIView *BGView;
@property(nonatomic,strong)UIImageView *left_imageV;
@property(nonatomic,strong)UIImageView *right_imageV;
@property(nonatomic,strong)UILabel *left_label;
- (void)setThreeDataImage:(NSString *)imageName labelData:(NSString *)labelTitle;
- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier;

@end

#pragma mark -

@interface FourViewController : UIViewController

@property(nonatomic, retain) UINavigationController *rootNavController;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil RootNavController:(UINavigationController *)Controller;

@end
