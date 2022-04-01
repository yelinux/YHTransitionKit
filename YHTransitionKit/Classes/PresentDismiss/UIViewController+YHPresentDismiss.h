//
//  UIViewController+YHPresentDismiss.h
//  YHTransitionKit
//
//  Created by chenyehong on 2022/3/31.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

typedef void (^YHBindDismissGestureBlock)(UIView *view, UIGestureRecognizer *dismissRecognizer);
typedef void (^YHPresentCompletion)(YHBindDismissGestureBlock bindDismissGestureBlock);

@interface UIViewController (YHPresentDismiss)

/// viewControllerToPresent:跳转的vc;
/// animatedTransitioning:跳转的动画;
/// completion:跳转完成后绑定关闭手势(可选);
- (void)yh_presentViewController:(UIViewController *)viewControllerToPresent
           animatedTransitioning:(id<UIViewControllerAnimatedTransitioning>)animatedTransitioning
                      completion:(YHPresentCompletion __nullable)completion;

@end

NS_ASSUME_NONNULL_END
