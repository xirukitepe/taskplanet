//
//  Constants.h
//  TodoList
//
//  Created by Shiela S on 2/9/15.
//  Copyright (c) 2015 Cynosure. All rights reserved.
//

//screen configs
#define SCREEN_HEIGHT_5               568.0   // iPhone 5
#define SCREEN_HEIGHT_4               480.0   // iPhone 4/4S
#define IS_IOS8_ABOVE                   ([[[UIDevice currentDevice] systemVersion] floatValue] >= 8.0 )
#define IS_IPHONE_5                       ((double)[[UIScreen mainScreen] bounds].size.height == SCREEN_HEIGHT_5)
#define IS_IPHONE_4                       ((double)[[UIScreen mainScreen] bounds].size.height == SCREEN_HEIGHT_4)
#define IS_IPHONE_4S_IOS8             (!IS_IPHONE_5 && IS_IOS8_ABOVE)
#define IS_RETINA                            ([UIScreen mainScreen].scale == 2.0)
#define SCREEN_WIDTH                     [[UIScreen mainScreen] bounds].size.width
#define SCREEN_HEIGHT                    [[UIScreen mainScreen] bounds].size.height
#define SCREEN_CENTER_X                SCREEN_WIDTH / 2
#define SCREEN_CENTER_Y                SCREEN_HEIGHT / 2
#define SCREEN_MARGIN                   10.0
#define ELEM_MARGIN                       30.0
#define DETAIL_MARGIN                    15.0
#define FULL_WIDTH                          SCREEN_WIDTH - SCREEN_MARGIN
#define TEXTFIELD_HEIGHT                50.0
#define BUTTON_HEIGHT                    40.0

//colors
#define RGB(r,g,b)                              [UIColor colorWithRed:r/255.0 green:g/255.0 blue:b/255.0 alpha:1]
#define LIGHTGRAY_TEXTCOLOR          RGB(125, 125, 124)
#define BG_GRAY                                RGB(229,227,225)
#define BUTTON_BG_GREEN                 RGB(41, 141, 65)