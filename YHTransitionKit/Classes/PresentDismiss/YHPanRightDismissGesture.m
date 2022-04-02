//
//  YHPresentDismissPanGestureRecognizer.m
//  YHTransitionKit
//
//  Created by chenyehong on 2022/4/1.
//

#import "YHPanRightDismissGesture.h"
#import "UIGestureRecognizer+YHDismiss.h"

@implementation YHPanRightDismissGesture

-(instancetype)init{
    if (self = [super init]) {
        [self addTarget:self action:@selector(panGestureAction:)];
        self.delegate = self;
    }
    return self;
}

- (void)panGestureAction:(UIPanGestureRecognizer *)gesture {
    // 进度
    CGFloat progress = [gesture translationInView:gesture.view].x / gesture.view.bounds.size.width * 1.2;
    progress = MIN(1.0f, MAX(0.0f, progress));
    CGPoint velocity = [gesture velocityInView:gesture.view];
    if (gesture.state == UIGestureRecognizerStateBegan) {
        [self.dismissDelegate yhDismissStart];
    } else if (gesture.state == UIGestureRecognizerStateChanged) {
        [self.dismissDelegate yhDismissProgress:progress];
    } else if (gesture.state == UIGestureRecognizerStateEnded || gesture.state == UIGestureRecognizerStateCancelled) {
        if (velocity.x > 500 || progress > 0.5) {
            [self.dismissDelegate yhDismissFinish];
        } else {
            [self.dismissDelegate yhDismissCancel];
        }
    }
}

#pragma mark - UIGestureRecognizerDelegate
- (BOOL)gestureRecognizerShouldBegin:(UIPanGestureRecognizer *)gestureRecognizer{
    CGFloat touchX = [gestureRecognizer translationInView:gestureRecognizer.view].x;
    if (touchX > 0) {
        return YES;
    }
    return NO;
}

@end
