//
//  UIViewController+YHPresentDismiss.m
//  YHTransitionKit
//
//  Created by chenyehong on 2022/3/31.
//

#import "UIViewController+YHPresentDismiss.h"
#import "YHPresentDismissDelegateObject.h"
#import <objc/runtime.h>

@interface UIViewController()

@property (nonatomic, strong) YHPresentDismissDelegateObject *presentDismissDelegateObject;

@end

@implementation UIViewController (YHPresentDismiss)

-(YHPresentDismissDelegateObject *)presentDismissDelegateObject{
    return objc_getAssociatedObject(self, _cmd);
}

- (void)setPresentDismissDelegateObject:(YHPresentDismissDelegateObject *)presentDismissDelegateObject{
    objc_setAssociatedObject(self, @selector(presentDismissDelegateObject), presentDismissDelegateObject, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

- (void)yh_presentViewController:(UIViewController *)viewControllerToPresent
           animatedTransitioning:(id<UIViewControllerAnimatedTransitioning>)animatedTransitioning
                      completion:(YHPresentCompletion __nullable)completion{
    viewControllerToPresent.modalPresentationStyle = UIModalPresentationCustom;
    viewControllerToPresent.presentDismissDelegateObject = [[YHPresentDismissDelegateObject alloc] initWithViewController:viewControllerToPresent animatedTransitioning:animatedTransitioning];
    [self presentViewController:viewControllerToPresent animated:YES completion:^{
        if (completion) {
            completion(^(UIView *view, UIGestureRecognizer *dismissRecognizer){
                dismissRecognizer.dismissDelegate = viewControllerToPresent.presentDismissDelegateObject;
                [view addGestureRecognizer:dismissRecognizer];
            });
        }
    }];
}

@end
