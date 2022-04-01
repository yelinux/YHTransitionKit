//
//  YHPresentDismissDelegateObject.m
//  YHTransitionKit
//
//  Created by chenyehong on 2022/3/31.
//

#import "YHPresentDismissDelegateObject.h"

@interface YHPresentDismissDelegateObject()<UIViewControllerTransitioningDelegate>

@property (nonatomic, weak) UIViewController *viewController;
@property (nonatomic, strong) id<UIViewControllerAnimatedTransitioning> animatedTransitioning;
@property (nonatomic, strong) UIPercentDrivenInteractiveTransition *dismissTransition;

@end

@implementation YHPresentDismissDelegateObject

- (instancetype)initWithViewController: (UIViewController*)viewController
                 animatedTransitioning: (id<UIViewControllerAnimatedTransitioning>)animatedTransitioning{
    if (self = [super init]) {
        self.viewController = viewController;
        self.animatedTransitioning = animatedTransitioning;
        viewController.transitioningDelegate = self;
    }
    return self;
}

#pragma mark - YHDismissProcessDelegate

- (void)yhDismissStart{
    self.dismissTransition = [UIPercentDrivenInteractiveTransition new];
    [self.viewController dismissViewControllerAnimated:YES completion:nil];
}

- (void)yhDismissProgress: (CGFloat)progress{
    [self.dismissTransition updateInteractiveTransition:progress];
}

- (void)yhDismissFinish{
    [self.dismissTransition finishInteractiveTransition];
    self.dismissTransition = nil;
}

- (void)yhDismissCancel{
    [self.dismissTransition cancelInteractiveTransition];
    self.dismissTransition = nil;
}

#pragma mark - UIViewControllerTransitioningDelegate
- (nullable id <UIViewControllerAnimatedTransitioning>)animationControllerForPresentedController:(UIViewController *)presented presentingController:(UIViewController *)presenting sourceController:(UIViewController *)source{
    return self.animatedTransitioning;
}

-(id<UIViewControllerAnimatedTransitioning>)animationControllerForDismissedController:(UIViewController *)dismissed{
    return self.animatedTransitioning;
}

-(id<UIViewControllerInteractiveTransitioning>)interactionControllerForDismissal:(id<UIViewControllerAnimatedTransitioning>)animator {
    return self.dismissTransition;
}


@end
