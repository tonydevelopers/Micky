//
//  PhotoAuthModel.h
//  MickyEasyCredit
//
//  Created by 张宁 on 2017/4/12.
//  Copyright © 2017年 apple. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface PhotoAuthModel : NSObject

@property(nonatomic,strong)NSString *Id;                      //图片id
@property(nonatomic,strong)NSString *idCardFrontUrl;          //身份证正面
@property(nonatomic,strong)NSString *idCardBackUrl;           //身份证反面
@property(nonatomic,strong)NSString *idCardHandHeldUrl;       //手持身份证
@property(nonatomic,strong)NSString *studentCardJobCardUrl;   //学生证封面或工作证明
@property(nonatomic,strong)NSString *schoolPageJobCardUrl;    //学籍页或工作证明

- (PhotoAuthModel*)initWithJsonDictionary:(NSDictionary*)dic;
- (void)updateWithJSonDictionary:(NSDictionary*)dic;
+ (PhotoAuthModel*)dataWithJsonDictionary:(NSDictionary*)dic;



@end
