//
//  YHPresentDismissDelegateObject.h
//  YHTransitionKit
//
//  Created by chenyehong on 2022/3/31.
//

#import <UIKit/UIKit.h>
#import "UIGestureRecognizer+YHDismiss.h"

NS_ASSUME_NONNULL_BEGIN

@interface YHPresentDismissDelegateObject : NSObject<YHDismissProcessDelegate>

- (instancetype)initWithViewController: (UIViewController*)viewController
                                               animatedTransitioning: (id<UIViewControllerAnimatedTransitioning>)animated;

@end

NS_ASSUME_NONNULL_END
