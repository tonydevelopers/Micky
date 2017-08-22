//
//  DimensMacros.h
//  MickyEasyCredit
//
//  Created by  张宁 on 2016/10/5.
//  Copyright © 2016年  张宁. All rights reserved.
//

#ifndef DimensMacros_h
#define DimensMacros_h

//状态栏高度
#define STATUS_BAR_HEIGHT       20
//NavBar高度
#define NAVIGATION_BAR_HEIGHT   44

#define TAB_BAR_HEIGHT          49
#define TOOL_BAR_HEIGHT         44
//状态栏 ＋ 导航栏 高度
#define STATUS_AND_NAVIGATION_HEIGHT ((STATUS_BAR_HEIGHT) + (NAVIGATION_BAR_HEIGHT))


//屏幕 rect
#define SCREEN_RECT ([UIScreen mainScreen].bounds)

#define MAIN_SCREEN_WIDTH   [[UIScreen mainScreen] applicationFrame].size.width
#define MAIN_SCREEN_HEIGHT  [[UIScreen mainScreen] applicationFrame].size.height

#define CONTENT_HEIGHT (SCREEN_HEIGHT - NAVIGATION_BAR_HEIGHT - STATUS_BAR_HEIGHT)

#define SCREEN_WIDTH ([UIScreen mainScreen].bounds.size.width)
#define SCREEN_HEIGHT ([UIScreen mainScreen].bounds.size.height)

#define SELF_WIDTH  self.view.frame.size.width
#define SELF_HEIGHT self.view.frame.size.height
//屏幕分辨率
#define SCREEN_RESOLUTION (SCREEN_WIDTH * SCREEN_HEIGHT * ([UIScreen mainScreen].scale))


//广告栏高度
#define BANNER_HEIGHT 215

#define STYLEPAGE_HEIGHT 21

#define SMALLTV_HEIGHT 77

#define SMALLTV_WIDTH 110

#define FOLLOW_HEIGHT 220

#define SUBCHANNEL_HEIGHT 62


#endif /* DimensMacros_h */
