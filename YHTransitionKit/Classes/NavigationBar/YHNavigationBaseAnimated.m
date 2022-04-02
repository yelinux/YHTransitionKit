//
//  YHNavigationBaseAnimated.m
//  YHNavigationBarExample
//
//  Created by chenyehong on 2022/3/4.
//

#import "YHNavigationBaseAnimated.h"
#import "UIViewController+YHNavigation.h"

#define YHNavigationBaseAnimatedDuration 0.3

@implementation YHNavigationBaseAnimated

#pragma mark - UIViewControllerAnimatedTransitioning
- (NSTimeInterval)transitionDuration:(nullable id <UIViewControllerContextTransitioning>)transitionContext{
    return YHNavigationBaseAnimatedDuration;
}

- (void)animateTransition:(id <UIViewControllerContextTransitioning>)transitionContext{

    UIView *containerView = [transitionContext containerView];
    
    UIViewController *fromViewController = [transitionContext viewControllerForKey:UITransitionContextFromViewControllerKey];
    UIViewController *toViewController = [transitionContext viewControllerForKey:UITransitionContextToViewControllerKey];
    
    UIView *fromView;
    UIView *toView;
    if ([transitionContext respondsToSelector:@selector(viewForKey:)]) {
        fromView = [transitionContext viewForKey:UITransitionContextFromViewKey];
        toView = [transitionContext viewForKey:UITransitionContextToViewKey];
    } else {
        fromView = fromViewController.view;
        toView = toViewController.view;
    }
    
    BOOL isPush = ([toViewController.navigationController.viewControllers indexOfObject:toViewController] > [fromViewController.navigationController.viewControllers indexOfObject:fromViewController]);
    
    fromView.frame = [transitionContext initialFrameForViewController:fromViewController];
    toView.frame = [transitionContext finalFrameForViewController:toViewController];
    [containerView addSubview:toView];
    
    UIImage *fromViewSnapshot;
    __block UIImage *toViewSnapshot;
    
    UIGraphicsBeginImageContextWithOptions(containerView.bounds.size, YES, containerView.window.screen.scale);
    [fromView drawViewHierarchyInRect:containerView.bounds afterScreenUpdates:NO];
    fromViewSnapshot = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    dispatch_async(dispatch_get_main_queue(), ^{
        UIGraphicsBeginImageContextWithOptions(containerView.bounds.size, YES, containerView.window.screen.scale);
        [toView drawViewHierarchyInRect:containerView.bounds afterScreenUpdates:NO];
        toViewSnapshot = UIGraphicsGetImageFromCurrentImageContext();
        UIGraphicsEndImageContext();
    });
    
    UIView *transitionContainer = [[UIView alloc] initWithFrame:containerView.bounds];
    transitionContainer.opaque = YES;
    transitionContainer.backgroundColor = isPush ? fromView.backgroundColor : toView.backgroundColor;
    [containerView addSubview:transitionContainer];
    
    __block CGRect fromFrame = transitionContainer.bounds;
    __block CGRect toFrame = transitionContainer.bounds;
    
    if (!fromViewController.navigationController.navigationBar.translucent && (fromViewController.yh_prefersNavigationBarType == YHViewControllerNavigationBarTypeShow || (fromViewController.yh_prefersNavigationBarType == YHViewControllerNavigationBarTypeNone && !fromViewController.navigationController.navigationBar.isHidden))) {
        CGFloat marginTop = fromViewController.navigationController.navigationBar.frame.size.height;
        if (@available(iOS 11.0, *)) {
            if ([fromView.window convertRect:fromViewController.navigationController.view.frame fromView:fromViewController.navigationController.view.superview].origin.y == 0) {
                marginTop += fromView.window.safeAreaInsets.top;
            }
        }
        fromFrame.origin.y += marginTop;
        fromFrame.size.height -= marginTop;
    }
    
    if (!toViewController.navigationController.navigationBar.translucent && (toViewController.yh_prefersNavigationBarType == YHViewControllerNavigationBarTypeShow || (toViewController.yh_prefersNavigationBarType == YHViewControllerNavigationBarTypeNone && !toViewController.navigationController.navigationBar.isHidden))) {
        CGFloat marginTop = toViewController.navigationController.navigationBar.frame.size.height;
        if (@available(iOS 11.0, *)) {
            if ([toView.window convertRect:toViewController.navigationController.view.frame fromView:toViewController.navigationController.view.superview].origin.y == 0) {
                marginTop += toView.window.safeAreaInsets.top;
            }
        }
        toFrame.origin.y += marginTop;
        toFrame.size.height -= marginTop;
    }
    
    UIImageView *fromIv = [[UIImageView alloc] initWithFrame:fromFrame];
    fromIv.image = fromViewSnapshot;
    [transitionContainer addSubview:fromIv];
    
    UIImageView *toIv = [[UIImageView alloc] initWithFrame:toFrame];
    dispatch_async(dispatch_get_main_queue(), ^{
        toIv.image = toViewSnapshot;
    });
    if (isPush) {
        [transitionContainer addSubview:toIv];
    } else {
        [transitionContainer insertSubview:toIv belowSubview:fromIv];
    }
    
    [self animateStart:isPush fromIv:fromIv toIv:toIv];
    
    [UIView animateWithDuration:YHNavigationBaseAnimatedDuration animations:^{
        [self animateEnd:isPush fromIv:fromIv toIv:toIv];
    } completion:^(BOOL finished) {
        BOOL wasCancelled = [transitionContext transitionWasCancelled];
        [transitionContainer removeFromSuperview];
        [transitionContext completeTransition:!wasCancelled];
    }];
}

-(void)animateStart: (BOOL)isPush fromIv: (UIImageView*)fromIv toIv: (UIImageView*)toIv{}

-(void)animateEnd: (BOOL)isPush fromIv: (UIImageView*)fromIv toIv: (UIImageView*)toIv{}

@end
