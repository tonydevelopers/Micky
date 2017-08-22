//
//  NO_Data_View.m
//  MickyEasyCredit
//
//  Created by 张宁 on 2016/11/10.
//  Copyright © 2016年 apple. All rights reserved.
//

#import "NO_Data_View.h"
#import "AppDelegate.h"
@implementation NO_Data_View
@synthesize noDataImage;
@synthesize noneLabel;

- (instancetype)initWithFrame:(CGRect)frame noDataImage:(NSString *)image_name noneLabel:(NSString *)label_title {
    self = [super initWithFrame:frame];
    if (self) {
       
        self.backgroundColor = [UIColor clearColor];
        self.hidden = NO;
        self.userInteractionEnabled = NO;
        
        noDataImage = [[UIImageView alloc] initWithImage:[UIImage imageNamed:[Gobal isEmptyString:image_name]?@"none":image_name]];
        noDataImage.frame = CGRectMake(frame.size.width/2-noDataImage.image.size.width/2, frame.size.height/2-noDataImage.image.size.height/2-50, noDataImage.image.size.width, noDataImage.image.size.height);
        noDataImage.contentMode = UIViewContentModeCenter;
        noDataImage.autoresizingMask = UIViewAutoresizingFlexibleLeftMargin|UIViewAutoresizingFlexibleWidth|UIViewAutoresizingFlexibleRightMargin|UIViewAutoresizingFlexibleTopMargin|UIViewAutoresizingFlexibleHeight|UIViewAutoresizingFlexibleBottomMargin;
        [self addSubview:noDataImage];
        
        noneLabel = [[UILabel alloc] initWithFrame:CGRectMake(frame.size.width/2-200/2, CGRectGetMaxY(noDataImage.frame), 200, 50)];
        noneLabel.backgroundColor = [UIColor clearColor];
        noneLabel.textAlignment = NSTextAlignmentCenter;
        noneLabel.textColor = [UIColor colorWithRed:(191/255.0) green:(191/255.0) blue:(191/255.0) alpha:1.0];
        noneLabel.text = [Gobal isEmptyString:image_name]?@"暂无相关数据":label_title;
        noneLabel.font = [UIFont systemFontOfSize:13];
        [self addSubview:noneLabel];
   
    }
    return self;
}
- (instancetype)initWithFrame:(CGRect)frame {
   self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = [UIColor clearColor];
        self.hidden = NO;
        self.userInteractionEnabled = NO;

        noDataImage = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"none_data"]];
        noDataImage.frame = CGRectMake(frame.size.width/2-noDataImage.image.size.width/2, frame.size.height/2-noDataImage.image.size.height/2-50, noDataImage.image.size.width, noDataImage.image.size.height);
        noDataImage.contentMode = UIViewContentModeCenter;
        noDataImage.autoresizingMask = UIViewAutoresizingFlexibleLeftMargin|UIViewAutoresizingFlexibleWidth|UIViewAutoresizingFlexibleRightMargin|UIViewAutoresizingFlexibleTopMargin|UIViewAutoresizingFlexibleHeight|UIViewAutoresizingFlexibleBottomMargin;
        [self addSubview:noDataImage];
        
        noneLabel = [[UILabel alloc] initWithFrame:CGRectMake(frame.size.width/2-200/2, CGRectGetMaxY(noDataImage.frame), 200, 50)];
        noneLabel.backgroundColor = [UIColor clearColor];
        noneLabel.textAlignment = NSTextAlignmentCenter;
        noneLabel.textColor = [UIColor colorWithRed:(191/255.0) green:(191/255.0) blue:(191/255.0) alpha:1.0];
        noneLabel.text = @"暂无相关数据";
        noneLabel.font = [UIFont systemFontOfSize:13];
        [self addSubview:noneLabel];

    }
    return self;
}
- (void)noDataViewUpdate:(NSArray *)data_array {
    [self setHidden:(data_array.count>0)?YES:NO];
    NSLog(@"noDataViewUpdate == %lu",(unsigned long)data_array.count);
}

@end
