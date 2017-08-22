//
//  MultipleDisplayPictureCell.m
//  shopMall
//
//  Created by mosjoydev6 on 16/8/9.
//  Copyright © 2016年 Mosjoy. All rights reserved.
//

#define DEFAULT_ADD_IMAGE @"fb_pic_add"

#import "MultipleDisplayPictureCell.h"

@interface MultipleDisplayPictureCell ()

@end

@implementation MultipleDisplayPictureCell

- (void)awakeFromNib {
    [super awakeFromNib];
    _image.layer.cornerRadius = 7.5;
    _image.layer.masksToBounds = YES;
}

- (IBAction)deletePic:(UIButton *)sender {
    self.deletePictureBlock(sender.tag);
    NSLog(@"删除图片");
}

- (IBAction)add:(UIButton *)sender {
    self.addPictureBlock(sender.tag);
    NSLog(@"添加图片");
}

-(void)setIsLast:(BOOL)isLast
{
    _image.hidden = isLast;
    _deletePic.hidden = isLast;
    _add.hidden = !isLast;
    
}

-(void)setPicture:(UIImage *)picture
{
    _image.image = picture;
}

-(void)setAddImage:(id)addImage
{
    NSLog(@"addImage.class = %@",[addImage class]);
    NSLog(@"addimage = %@",addImage);
    if (addImage == nil || [addImage isKindOfClass:[NSNull class]]) return;
    
    if ([addImage isKindOfClass:[NSString class]]) {
        [_add setBackgroundImage:[UIImage imageNamed:addImage] forState:UIControlStateNormal];
    }else if ([addImage isKindOfClass:[UIImage class]]){
        [_add setBackgroundImage:addImage forState:UIControlStateNormal];
    }else if ([addImage isKindOfClass:[NSData class]]){
        UIImage *image = [UIImage imageWithData:addImage];
        [_add setBackgroundImage:image forState:UIControlStateNormal];
    }
}

@end
