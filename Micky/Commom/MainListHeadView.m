//
//  MainListHeadView.m
//  zhadui
//
//  Created by infzm infzm on 12/14/11.
//  Copyright (c) 2011 __MyCompanyName__. All rights reserved.
//

//#import <QRCodeReader.h>

#import "MainListHeadView.h"
#import "AppDelegate.h"
#import "Gobal.h"

@interface MainListHeadView()<UINavigationControllerDelegate, UIImagePickerControllerDelegate,UIGestureRecognizerDelegate>
{
    UIButton *previousBtn;
    UIButton *nextBtn;
    UIImageView *bottomArrow;
}

//-(void)clickLogo;
//
//-(void)clickWrite;

@end

@implementation MainListHeadView
@synthesize titleLabel=_titleLabel,todayBtn=_todayBtn,backgroundIUmageView=_backgroundIUmageView;
@synthesize dateLabel=_dateLabel, dateView=_dateView, bornNumView=_bornNumView, bornNumLabel=_bornNumLabel;


-(void)dealloc{
    [_bornNumLabel release];
    _bornNumLabel = nil;
    [_bornNumView release];
    _bornNumView = nil;
    [_dateLabel release];
    _dateLabel = nil;
    [_dateView release];
    _dateView = nil;
    [_titleLabel release];
    _titleLabel = nil;
    [_todayBtn release];
    _todayBtn = nil;
    [_backgroundIUmageView release];
    _backgroundIUmageView = nil;
	[super dealloc];
}



- (id)init{
    if (self = [super initWithFrame:MainListHeadViewShowPositionProtrait]){
        self.backgroundColor = [UIColor clearColor];
        
        _backgroundIUmageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 320, 44)];
        _backgroundIUmageView.image = [UIImage imageNamed:(IS_OS_7_OR_LATER)?@"NavigationBarBg":@"NavigationBarBg"];
        [self addSubview:_backgroundIUmageView];
        [self sendSubviewToBack:_backgroundIUmageView];
        
        _todayBtn = [[UIButton alloc] initWithFrame:CGRectMake(5, 0, 53, 44)];
        _todayBtn.backgroundColor = [UIColor clearColor];
        [_todayBtn setTitle:@"今天" forState:UIControlStateNormal];
        _todayBtn.titleLabel.font = [UIFont systemFontOfSize:15];
        _todayBtn.titleLabel.textColor = [UIColor whiteColor];
        [_todayBtn addTarget:self action:@selector(clickToday) forControlEvents:UIControlEventTouchUpInside];
        [_todayBtn setHidden:YES];
        [self addSubview:_todayBtn];
        
        UILabel *aTitleLabel = [[UILabel alloc] initWithFrame:CGRectMake(50, 0, 220, 44)];
        self.titleLabel = aTitleLabel;
        self.titleLabel.backgroundColor = [UIColor clearColor];
        self.titleLabel.font = [UIFont boldSystemFontOfSize:20.0];
        self.titleLabel.textColor = [UIColor whiteColor];
        self.titleLabel.numberOfLines = 1;
        self.titleLabel.textAlignment = NSTextAlignmentCenter;
        self.titleLabel.text = @"";
        [self.titleLabel setHidden:YES];
        [self addSubview: self.titleLabel];
        [aTitleLabel release];
        
        _dateView = [[UIView alloc] initWithFrame:CGRectMake(self.frame.size.width/2-200/2, 0, 200, self.frame.size.height)];
        _dateView.backgroundColor = [UIColor clearColor];
        [_dateView setHidden:YES];
        [self addSubview:_dateView];
        [_dateView release];
        
        _dateLabel = [[UILabel alloc] initWithFrame:CGRectMake(30, 0, 140, CGRectGetHeight(_dateView.frame))];
        _dateLabel.backgroundColor = [UIColor clearColor];
        _dateLabel.font = [UIFont boldSystemFontOfSize:20.0];
        _dateLabel.textColor = [UIColor whiteColor];
        _dateLabel.numberOfLines = 1;
        _dateLabel.textAlignment = NSTextAlignmentCenter;
        _dateLabel.text = @"2014年11月";
        [_dateView addSubview:_dateLabel];
        [_dateLabel release];
        
        previousBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        [previousBtn setFrame:CGRectMake(0, 0, 30, CGRectGetHeight(_dateView.frame))];
        previousBtn.contentMode = UIViewContentModeScaleAspectFit;
        [previousBtn setImage:[UIImage imageNamed:@"calendar_beforebtn"] forState:UIControlStateNormal];
        [previousBtn addTarget:self action:@selector(clickPreviousMonth) forControlEvents:UIControlEventTouchUpInside];
        [_dateView addSubview:previousBtn];
        
        nextBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        [nextBtn setFrame:CGRectMake(CGRectGetWidth(_dateView.frame)-30, 0, 30, CGRectGetHeight(_dateView.frame))];
        nextBtn.contentMode = UIViewContentModeScaleAspectFit;
        [nextBtn setImage:[UIImage imageNamed:@"calendar_afterbtn"] forState:UIControlStateNormal];
        [nextBtn addTarget:self action:@selector(clickNextMonth) forControlEvents:UIControlEventTouchUpInside];
        [_dateView addSubview:nextBtn];
        
        _bornNumView = [[UIView alloc] initWithFrame:CGRectMake(self.frame.size.width/2-200/2, 0, 200, self.frame.size.height)];
        _bornNumView.backgroundColor = [UIColor clearColor];
        [_bornNumView setHidden:NO];
        [self addSubview:_bornNumView];
        [_bornNumView release];
        
        _bornNumLabel = [[UILabel alloc] initWithFrame:CGRectMake(30, 0, 140, CGRectGetHeight(_bornNumView.frame))];
        _bornNumLabel.backgroundColor = [UIColor clearColor];
        _bornNumLabel.font = [UIFont boldSystemFontOfSize:20.0];
        _bornNumLabel.textColor = [UIColor whiteColor];
        _bornNumLabel.numberOfLines = 1;
        _bornNumLabel.textAlignment = NSTextAlignmentCenter;
        _bornNumLabel.text = @"";
        _bornNumLabel.userInteractionEnabled = YES;
        [_bornNumView addSubview:_bornNumLabel];
        [_bornNumLabel release];
        
        bottomArrow = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"today下拉"]];
        bottomArrow.frame = CGRectMake(CGRectGetWidth(_bornNumLabel.frame)/2-CGRectGetWidth(bottomArrow.frame)/2, CGRectGetHeight(_bornNumLabel
                                                                                                                                  .frame)-CGRectGetHeight(bottomArrow.frame)-3, CGRectGetWidth(bottomArrow.frame), CGRectGetHeight(bottomArrow.frame));
        [_bornNumLabel addSubview:bottomArrow];
        
        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapHandling:)];
        tap.numberOfTapsRequired = 1;
        tap.delegate = self;
        [_bornNumLabel addGestureRecognizer:tap];
        [tap release];
    }
    return self;
}

- (BOOL)gestureRecognizerShouldBegin:(UIGestureRecognizer *)gestureRecognizer{
    return YES;
}

#pragma mark - Button Action
- (void)clickToday{
    [[NSNotificationCenter defaultCenter] postNotificationName:Notification_SetToday object:nil];
}

- (void) tapHandling: (UIGestureRecognizer *)recognizer{
    [self showCalendar:_bornNumLabel];
}

- (IBAction)showCalendar:(id)sender
{
    
//    [self calendarController:pmCC didChangePeriod:pmCC.period];
}

- (void)clickPreviousMonth{
    [[NSNotificationCenter defaultCenter] postNotificationName:Notification_previousMonth object:nil];
    previousBtn.enabled = NO;
    [NSTimer scheduledTimerWithTimeInterval:0.4 target:self selector:@selector(enablePreviousBtn) userInfo:nil repeats:NO];
}

- (void)enablePreviousBtn{
    previousBtn.enabled = YES;
}

- (void)clickNextMonth{
    [[NSNotificationCenter defaultCenter] postNotificationName:Notification_nextMonth object:nil];
    nextBtn.enabled = NO;
    [NSTimer scheduledTimerWithTimeInterval:0.4 target:self selector:@selector(enableNextBtn) userInfo:nil repeats:NO];
}

- (void)enableNextBtn{
    nextBtn.enabled = YES;
}

- (void)clickCamera{
    UIActionSheet *asheet = [[UIActionSheet alloc] initWithTitle:nil
                                                        delegate:self
                                               cancelButtonTitle:@"取消"
                                          destructiveButtonTitle:nil
                                               otherButtonTitles:@"我要拍照", @"从图片库选择",nil];
    
    [asheet showInView:[self superview]];
    [asheet release];
}

- (void)pressCodeRead:(id)sender
{

}


-(void)selectPage:(id)sender{

    
}

-(void)refreshTableView{

}

-(void)setMainTabViewControllerSelectedIndex:(int)index{

}

- (void)pickPhoto:(UIImagePickerControllerSourceType)sourceType{
    UIImagePickerController *picker = [[UIImagePickerController alloc]init];
    picker.delegate = self;
    picker.sourceType = sourceType;
    //    picker.allowsEditing = YES;
    picker.videoQuality = UIImagePickerControllerQualityTypeLow;
    [[AppDelegate getInstance].CurNavController presentViewController:picker animated:YES completion:nil];
    [picker release];
}

# pragma mark -
# pragma mark UIImagePickerControllerDelegate
-(void)imagePickerController:(UIImagePickerController *)picker didFinishPickingImage:(UIImage *)image editingInfo:(NSDictionary *)editingInfo{
    [picker  dismissViewControllerAnimated:YES completion:nil];
//    [[UIApplication sharedApplication] setStatusBarStyle:UIStatusBarStyleBlackOpaque];
    
//    if (![AppDelegate checkNetworkStatus:nil]) {
//        [Gobal showAlert:nil Content:@"网络尚未连接"];
//        return;
//    }
    
//    UIImage *resize_image = [Gobal ResizeImageWithImage:image scaledToWidth:500];
//    NSData *data = UIImageJPEGRepresentation(resize_image, 0.1);
//    [[[AppDelegate getInstance] mainTabController] hideHeaderView];
//    [[[AppDelegate getInstance] mainTabController] hideTabbarView];
    
//    DLPublishViewController *Controller = [[DLPublishViewController alloc] initWithNibName:nil bundle:nil RootNavController:[[AppDelegate getInstance] CurNavController] PublishType:DLRequestParam_PublishType_ItemLook Items:nil LookImage:[UIImage imageWithData:data]];
//    [[[AppDelegate getInstance] CurNavController] pushViewController:Controller animated:YES];
//    [Controller release];

}

- (void)imagePickerControllerDidCancel:(UIImagePickerController *)picker{
    //[picker dismissModalViewControllerAnimated:YES];
    [picker dismissViewControllerAnimated:YES completion:^{
        
    }];
//    [[UIApplication sharedApplication] setStatusBarStyle:UIStatusBarStyleBlackOpaque];
}

#pragma mark - actionSheet delegate
- (void)actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex {
    if (buttonIndex != [actionSheet cancelButtonIndex]){
        NSString *buttonTitle = [actionSheet buttonTitleAtIndex:buttonIndex];
        if ([buttonTitle isEqualToString:@"我要拍照"]){
            if ([UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypeCamera])
                [self pickPhoto:UIImagePickerControllerSourceTypeCamera];
            else
                [Gobal showAlert:nil Content:@"设备不支持拍照"];
        }
        else if ([buttonTitle isEqualToString:@"从图片库选择"]){
            [self pickPhoto:UIImagePickerControllerSourceTypePhotoLibrary];
        }
    }
}


#pragma mark - alertview delegate
- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex{

}


@end
