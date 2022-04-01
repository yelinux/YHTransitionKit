//
//  YHPresentDismissBaseAnimated.m
//  YHTransitionKit
//
//  Created by chenyehong on 2022/3/31.
//

#import "YHPresentDismissBaseAnimated.h"

#define YHAnimatedDuration 0.3

@interface YHPresentDismissBaseAnimated()

@property (nonatomic, strong) UIImage *snapshotImg;

@end

@implementation YHPresentDismissBaseAnimated

#pragma mark - UIViewControllerAnimatedTransitioning
- (NSTimeInterval)transitionDuration:(nullable id <UIViewControllerContextTransitioning>)transitionContext{
    return YHAnimatedDuration;
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
    
    BOOL isPresent = self.snapshotImg == nil;
    
    fromView.frame = [transitionContext initialFrameForViewController:fromViewController];
    toView.frame = [transitionContext finalFrameForViewController:toViewController];
    [containerView addSubview:toView];
    
    UIImage *fromViewSnapshot;
    __block UIImage *toViewSnapshot;
    
    if (isPresent) {
        UIGraphicsBeginImageContextWithOptions(containerView.bounds.size, YES, containerView.window.screen.scale);
        [containerView.window drawViewHierarchyInRect:containerView.bounds afterScreenUpdates:NO];
        fromViewSnapshot = UIGraphicsGetImageFromCurrentImageContext();
        UIGraphicsEndImageContext();
        self.snapshotImg = fromViewSnapshot;
        
        dispatch_async(dispatch_get_main_queue(), ^{
            UIGraphicsBeginImageContextWithOptions(containerView.bounds.size, YES, containerView.window.screen.scale);
            [toView drawViewHierarchyInRect:containerView.bounds afterScreenUpdates:NO];
            toViewSnapshot = UIGraphicsGetImageFromCurrentImageContext();
            UIGraphicsEndImageContext();
        });
    } else {
        UIGraphicsBeginImageContextWithOptions(containerView.bounds.size, YES, containerView.window.screen.scale);
        [fromView drawViewHierarchyInRect:containerView.bounds afterScreenUpdates:NO];
        fromViewSnapshot = UIGraphicsGetImageFromCurrentImageContext();
        UIGraphicsEndImageContext();
        
        toViewSnapshot = self.snapshotImg;
    }

    UIView *transitionContainer = [[UIView alloc] initWithFrame:containerView.bounds];
    transitionContainer.opaque = YES;
    transitionContainer.backgroundColor = UIColor.blackColor;//isPresent ? fromView.backgroundColor : toView.backgroundColor;
    [containerView addSubview:transitionContainer];
    
    __block CGRect fromFrame = transitionContainer.bounds;
    __block CGRect toFrame = transitionContainer.bounds;
    
    UIImageView *fromIv = [[UIImageView alloc] initWithFrame:fromFrame];
    fromIv.image = fromViewSnapshot;
    [transitionContainer addSubview:fromIv];
    
    UIImageView *toIv = [[UIImageView alloc] initWithFrame:toFrame];
    dispatch_async(dispatch_get_main_queue(), ^{
        toIv.image = toViewSnapshot;
    });
    if (isPresent) {
        [transitionContainer addSubview:toIv];
    } else {
        [transitionContainer insertSubview:toIv belowSubview:fromIv];
    }
    
    [self animateStart:isPresent fromIv:fromIv toIv:toIv];
    
    [UIView animateWithDuration:YHAnimatedDuration animations:^{
        [self animateEnd:isPresent fromIv:fromIv toIv:toIv];
    } completion:^(BOOL finished) {
        BOOL wasCancelled = [transitionContext transitionWasCancelled];
        [transitionContainer removeFromSuperview];
        [transitionContext completeTransition:!wasCancelled];
    }];
}

- (void)animateStart: (BOOL)isPush fromIv: (UIImageView*)fromIv toIv: (UIImageView*)toIv{
}

- (void)animateEnd: (BOOL)isPush fromIv: (UIImageView*)fromIv toIv: (UIImageView*)toIv{
}

@end
