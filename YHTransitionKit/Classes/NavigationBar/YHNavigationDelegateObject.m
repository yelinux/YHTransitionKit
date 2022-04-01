//
//  YHNavigationDelegateObject.m
//  YHNavigationBarExample
//
//  Created by chenyehong on 2021/4/19.
//

#import "YHNavigationDelegateObject.h"
#import "UIViewController+YHNavigation.h"
#import "YHNavigationFullScreenPopGesture.h"
#import "UINavigationController+YHTransition.h"

@interface YHNavigationDelegateObject()

/// 当前处理的导航控制器
@property (nonatomic, weak) UINavigationController *navigationController;
/// pop动画进度
@property (nonatomic, strong) UIPercentDrivenInteractiveTransition *popTransition;
/// 全屏侧滑手势
@property (nonatomic, strong) YHNavigationFullScreenPopGesture *fullScreenPopGesture;

@end

@implementation YHNavigationDelegateObject

-(instancetype)initWithNavigationController: (UINavigationController *)navigationController{
    if (self = [super init]) {
        self.navigationController = navigationController;
        //防止隐藏导航栏，侧滑失效
        navigationController.interactivePopGestureRecognizer.delegate = self;
        navigationController.interactivePopGestureRecognizer.enabled = YES;
        //全屏侧滑
        [navigationController.view addGestureRecognizer:[[YHNavigationFullScreenPopGesture alloc] initWithTarget:self action:@selector(panGestureAction:) navigationController:navigationController]];
        navigationController.delegate = self;
    }
    return self;
}

- (void)panGestureAction:(UIPanGestureRecognizer *)gesture {
    // 进度
    CGFloat progress = [gesture translationInView:gesture.view].x / gesture.view.bounds.size.width * 1.2;
    progress = MIN(1.0f, MAX(0.0f, progress));
    CGPoint velocity = [gesture velocityInView:gesture.view];
    if (gesture.state == UIGestureRecognizerStateBegan) {
        self.popTransition = [UIPercentDrivenInteractiveTransition new];
        [self.navigationController popViewControllerAnimated:YES];
    } else if (gesture.state == UIGestureRecognizerStateChanged) {
        [self.popTransition updateInteractiveTransition:progress];
    } else if (gesture.state == UIGestureRecognizerStateEnded || gesture.state == UIGestureRecognizerStateCancelled) {
        if (velocity.x > 500 || progress > 0.5) {
            [self.popTransition finishInteractiveTransition];
        } else {
            [self.popTransition cancelInteractiveTransition];
        }
        self.popTransition = nil;
    }
}

#pragma mark - UINavigationControllerDelegate
- (nullable id <UIViewControllerAnimatedTransitioning>)navigationController:(UINavigationController *)navigationController
                                   animationControllerForOperation:(UINavigationControllerOperation)operation
                                                fromViewController:(UIViewController *)fromVC
                                                           toViewController:(UIViewController *)toVC  API_AVAILABLE(ios(7.0)){
    return self.navigationController.yh_pushPopAnimated;
}

- (nullable id <UIViewControllerInteractiveTransitioning>)navigationController:(UINavigationController *)navigationController
                                   interactionControllerForAnimationController:(id <UIViewControllerAnimatedTransitioning>) animationController{
    return self.popTransition;
}

#pragma mark - UIGestureRecognizerDelegate
//只有一个vc时，不触发侧滑返回
- (BOOL)gestureRecognizerShouldBegin:(UIGestureRecognizer *)gestureRecognizer{
    if (self.navigationController.viewControllers.count > 1) {
        UIViewController *visibleVC = self.navigationController.visibleViewController;
        if (visibleVC.yh_interactivePopType == YHViewControllerInteractivePopTypeLeftScreen) {
            return YES;
        } else if(visibleVC.yh_interactivePopType == YHViewControllerInteractivePopTypeFollowNav
                  && self.navigationController.yh_interactivePopType == YHNavigationInteractivePopTypeLeftScreen){
            return YES;
        }
    }
    return NO;
}

@end
