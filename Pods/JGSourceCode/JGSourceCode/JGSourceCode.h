//
//  JGSourceCode.h
//  JGSourceCode
//
//  Created by Mei Jigao on 2017/11/27.
//  Copyright © 2017年 MeiJigao. All rights reserved.
//

#import <UIKit/UIKit.h>

//! Project version number for JGSourceCode.
FOUNDATION_EXPORT double JGSourceCodeVersionNumber;

//! Project version string for JGSourceCode.
FOUNDATION_EXPORT const unsigned char JGSourceCodeVersionString[];

// In this header, you should import all the public headers of your framework using statements like #import <JGSourceCode/PublicHeader.h>

// JGSourceBase
#if __has_include(<JGSourceBase/JGSourceBase.h>)
#import <JGSourceBase/JGSourceBase.h>
#else
#import "JGSourceBase.h"
#endif

// JGAlertController
#if __has_include(<JGAlertController/JGAlertController.h>)
#import <JGAlertController/JGAlertController.h>
#else
#import "JGAlertController.h"
#endif

// JGNetworkReachability
#if __has_include(<JGNetworkReachability/JGNetworkReachability.h>)
#import <JGNetworkReachability/JGNetworkReachability.h>
#else
#import "JGNetworkReachability.h"
#endif

// JGPhotoBrowser
#if __has_include(<JGPhotoBrowser/JGPhotoBrowser.h>)
#import <JGPhotoBrowser/JGPhotoBrowser.h>
#else
#import "JGPhotoBrowser.h"
#endif
