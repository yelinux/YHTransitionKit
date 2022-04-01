//
//  YHNavigationFullScreenPopGesture.m
//  YHNavigationBarExample
//
//  Created by chenyehong on 2021/4/20.
//

#import "YHNavigationFullScreenPopGesture.h"
#import "UIViewController+YHNavigation.h"
#import "UINavigationController+YHTransition.h"

@interface YHNavigationFullScreenPopGesture()<UIGestureRecognizerDelegate>
/// 当前处理的导航控制器
@property (nonatomic, weak) UINavigationController *navigationController;
@property (nonatomic, assign) CGFloat touchBeginX;

@end

@implementation YHNavigationFullScreenPopGesture

-(instancetype)initWithTarget:(id)target action:(SEL)action navigationController:(UINavigationController *)navigationController{
    if (self = [super initWithTarget:target action:action]) {
        self.delegate = self;
        self.navigationController = navigationController;
    }
    return self;
}

-(void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    [super touchesBegan:touches withEvent:event];
    self.touchBeginX = [[touches anyObject] locationInView:self.view].x;
}

#pragma mark - UIGestureRecognizerDelegate
- (BOOL)gestureRecognizerShouldBegin:(UIPanGestureRecognizer *)gestureRecognizer{
    if (self.navigationController.yh_pushPopAnimated) {
        CGFloat touchX = [gestureRecognizer translationInView:gestureRecognizer.view].x;
        if (self.navigationController.viewControllers.count > 1 && touchX > 0) {
            UIViewController *visibleVC = self.navigationController.visibleViewController;
            if (visibleVC.yh_interactivePopType == YHViewControllerInteractivePopTypeFullScreen) {
                return YES;
            }
            if (visibleVC.yh_interactivePopType == YHViewControllerInteractivePopTypeLeftScreen && self.touchBeginX < 50) {
                return YES;
            }
            if(visibleVC.yh_interactivePopType == YHViewControllerInteractivePopTypeFollowNav){
                if (self.navigationController.yh_interactivePopType == YHNavigationInteractivePopTypeLeftScreen && self.touchBeginX < 50) {
                    return YES;
                }
                if (self.navigationController.yh_interactivePopType == YHNavigationInteractivePopTypeFullScreen) {
                    return YES;
                }
            }
        }
    }
    return NO;
}

@end
