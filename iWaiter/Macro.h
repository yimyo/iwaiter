//
//  Macro.h
//  
//
//  Created by RedScor Yuan on 13/5/3.
//  Copyright (c) 2013年 soohoobook. All rights reserved.
//

#define NavigationBar_HEIGHT 44

#define TABBAR_HEIGHT 49

#define SCREEN_HEIGHT [UIScreen mainScreen].bounds.size.height

#define SCREEN_WIDTH [UIScreen mainScreen].bounds.size.width

//------------------------------------------------------------------------------
// Release methods
#define RELEASE_SAFELY(__POINTER) { [__POINTER release]; __POINTER = nil; }
#define AUTORELEASE_SAFELY(__POINTER) { [__POINTER autorelease]; __POINTER = nil; }

// iOS系統版本 Float 型態
#define IOS_VERSION [[[UIDevice currentDevice] systemVersion] floatValue]

// iOS系統版本 NSString 型態
#define CurrentSystemVersion ([[UIDevice currentDevice] systemVersion])

// 系統語言
#define CurrentLanguage ([[NSLocale preferredLanguages] objectAtIndex:0])

#define BACKGROUND_COLOR [UIColor colorWithRed:242.0/255.0 green:236.0/255.0 blue:231.0/255.0 alpha:1.0]

//use dlog to print while in debug model
#ifdef DEBUG
#   define DLog(fmt, ...) NSLog((@"%s [Line %d] " fmt), __PRETTY_FUNCTION__, __LINE__, ##__VA_ARGS__);
#else
#   define DLog(...)
#endif

// ALog always displays output regardless of the DEBUG setting
#define ALog(fmt, ...) NSLog((@"%s [Line %d] " fmt), __PRETTY_FUNCTION__, __LINE__, ##__VA_ARGS__)

#define _po(o) DLOG(@"%@", (o))
#define _pn(o) DLOG(@"%d", (o))
#define _pf(o) DLOG(@"%f", (o))
#define _ps(o) DLOG(@"CGSize: {%.0f, %.0f}", (o).width, (o).height)
#define _pr(o) DLOG(@"NSRect: {{%.0f, %.0f}, {%.0f, %.0f}}", (o).origin.x, (o).origin.x, (o).size.width, (o).size.height)

#define DOBJ(obj)  DLOG(@"%s: %@", #obj, [(obj) description])

#define MARK    NSLog(@"\nMARK: %s, %d", __PRETTY_FUNCTION__, __LINE__)

// 不帶緩存的imageLoad，圖多時適用
#define LOADIMAGE(file,ext) [UIImage imageWithContentsOfFile:[[NSBundle mainBundle]pathForResource:file ofType:ext]]

// 檢查是	不是Retina螢幕
#define isRetina ([UIScreen instancesRespondToSelector:@selector(currentMode)] ? CGSizeEqualToSize(CGSizeMake(640, 960), [[UIScreen mainScreen] currentMode].size) : NO)

// 檢查是不是iPhone5
#define iPhone5 ([UIScreen instancesRespondToSelector:@selector(currentMode)] ? CGSizeEqualToSize(CGSizeMake(640, 1136), [[UIScreen mainScreen] currentMode].size) : NO)

// 是不是iPad
#define isPad (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad)


#if TARGET_OS_IPHONE
//iPhone Device
#endif

#if TARGET_IPHONE_SIMULATOR
//iPhone Simulator
#endif


//ARC
#if __has_feature(objc_arc)
//compiling with ARC
#else
// compiling without ARC
#endif


//G－C－D
#define BACK(block) dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), block)
#define MAIN(block) dispatch_async(dispatch_get_main_queue(),block)

// NSUserDefaults
#define USER_DEFAULT [NSUserDefaults standardUserDefaults]


#pragma mark - degrees/radian functions
#define degreesToRadian(x) (M_PI * (x) / 180.0)
#define radianToDegrees(radian) (radian*180.0)/(M_PI)

#pragma mark - color functions
// RGB颜色
#define RGB(RED,GREEN,BLUE) [UIColor colorWithRed:RED/255.00 green:GREEN/255.00 blue:BLUE/255.00 alpha:1.0]
// 带有Alpha的颜色設置
#define RGBA(R, G, B, A) [UIColor colorWithRed:R/255.0 green:G/255.0 blue:B/255.0 alpha:A]

#define ITTDEBUG
#define ITTLOGLEVEL_INFO     10
#define ITTLOGLEVEL_WARNING  3
#define ITTLOGLEVEL_ERROR    1

#ifndef ITTMAXLOGLEVEL

#ifdef DEBUG
#define ITTMAXLOGLEVEL ITTLOGLEVEL_INFO
#else
#define ITTMAXLOGLEVEL ITTLOGLEVEL_ERROR
#endif

#endif

// The general purpose logger. This ignores logging levels.
#ifdef ITTDEBUG
#define ITTDPRINT(xx, ...)  NSLog(@"%s(%d): " xx, __PRETTY_FUNCTION__, __LINE__, ##__VA_ARGS__)
#else
#define ITTDPRINT(xx, ...)  ((void)0)
#endif

// Prints the current method's name.
#define ITTDPRINTMETHODNAME() ITTDPRINT(@"%s", __PRETTY_FUNCTION__)

// Log-level based logging macros.
#if ITTLOGLEVEL_ERROR <= ITTMAXLOGLEVEL
#define ITTDERROR(xx, ...)  ITTDPRINT(xx, ##__VA_ARGS__)
#else
#define ITTDERROR(xx, ...)  ((void)0)
#endif

#if ITTLOGLEVEL_WARNING <= ITTMAXLOGLEVEL
#define ITTDWARNING(xx, ...)  ITTDPRINT(xx, ##__VA_ARGS__)
#else
#define ITTDWARNING(xx, ...)  ((void)0)
#endif

#if ITTLOGLEVEL_INFO <= ITTMAXLOGLEVEL
#define ITTDINFO(xx, ...)  ITTDPRINT(xx, ##__VA_ARGS__)
#else
#define ITTDINFO(xx, ...)  ((void)0)
#endif

#ifdef ITTDEBUG
#define ITTDCONDITIONLOG(condition, xx, ...) { if ((condition)) { \
ITTDPRINT(xx, ##__VA_ARGS__); \
} \
} ((void)0)
#else
#define ITTDCONDITIONLOG(condition, xx, ...) ((void)0)
#endif

#define ITTAssert(condition, ...)                                       \
do {                                                                      \
if (!(condition)) {                                                     \
[[NSAssertionHandler currentHandler]                                  \
handleFailureInFunction:[NSString stringWithUTF8String:__PRETTY_FUNCTION__] \
file:[NSString stringWithUTF8String:__FILE__]  \
lineNumber:__LINE__                                  \
description:__VA_ARGS__];                             \
}                                                                       \
} while(0)