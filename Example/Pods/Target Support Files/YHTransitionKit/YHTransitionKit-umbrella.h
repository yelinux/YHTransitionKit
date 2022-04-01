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

#import "UINavigationController+YHTransition.h"
#import "UIViewController+YHNavigation.h"
#import "YHNavigationBaseAnimated.h"
#import "YHNavigationDelegateObject.h"
#import "YHNavigationFullScreenPopGesture.h"
#import "YHNavigationKit.h"
#import "YHNavigationScaleAnimated.h"
#import "YHNavigationTransitionAnimated.h"
#import "UIGestureRecognizer+YHDismiss.h"
#import "UIViewController+YHPresentDismiss.h"
#import "YHPanDownDismissGesture.h"
#import "YHPanRightDismissGesture.h"
#import "YHPresentDismissBaseAnimated.h"
#import "YHPresentDismissDelegateObject.h"
#import "YHPresentDismissKit.h"
#import "YHPresentDismissScaleBottomAnimated.h"
#import "YHPresentDismissScaleRightAnimated.h"
#import "YHPresentDismissTransitionAnimated.h"

FOUNDATION_EXPORT double YHTransitionKitVersionNumber;
FOUNDATION_EXPORT const unsigned char YHTransitionKitVersionString[];

