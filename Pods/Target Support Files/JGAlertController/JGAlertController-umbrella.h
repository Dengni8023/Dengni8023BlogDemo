#ifdef __OBJC__
#import <UIKit/UIKit.h>
#else
#ifndef FOUNDATION_EXPORT
#if defined(__cplusplus)
#define FOUNDATION_EXPORT extern "C"
#else
#define FOUNDATION_EXPORT extern
#endif
#endif
#endif

#import "JGAlertController.h"
#import "JGAlertControllerImpl.h"
#import "UIViewController+JGAlertController.h"

FOUNDATION_EXPORT double JGAlertControllerVersionNumber;
FOUNDATION_EXPORT const unsigned char JGAlertControllerVersionString[];

