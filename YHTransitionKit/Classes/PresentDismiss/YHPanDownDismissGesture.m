//
//  YHPanDownDismissGesture.m
//  YHTransitionKit
//
//  Created by chenyehong on 2022/4/1.
//

#import "YHPanDownDismissGesture.h"
#import "UIGestureRecognizer+YHDismiss.h"

@implementation YHPanDownDismissGesture

-(instancetype)init{
    if (self = [super init]) {
        [self addTarget:self action:@selector(panGestureAction:)];
        self.delegate = self;
    }
    return self;
}

- (void)panGestureAction:(UIPanGestureRecognizer *)gesture {
    // 进度
    CGFloat progress = [gesture translationInView:gesture.view].y / gesture.view.bounds.size.height * 1.2;
    progress = MIN(1.0f, MAX(0.0f, progress));
    CGPoint velocity = [gesture velocityInView:gesture.view];
    if (gesture.state == UIGestureRecognizerStateBegan) {
        [self.dismissDelegate yhDismissStart];
    } else if (gesture.state == UIGestureRecognizerStateChanged) {
        [self.dismissDelegate yhDismissProgress:progress];
    } else if (gesture.state == UIGestureRecognizerStateEnded || gesture.state == UIGestureRecognizerStateCancelled) {
        if (velocity.y > 500 || progress > 0.5) {
            [self.dismissDelegate yhDismissFinish];
        } else {
            [self.dismissDelegate yhDismissCancel];
        }
    }
}

#pragma mark - UIGestureRecognizerDelegate
- (BOOL)gestureRecognizerShouldBegin:(UIPanGestureRecognizer *)gestureRecognizer{
    CGFloat touchY = [gestureRecognizer translationInView:gestureRecognizer.view].y;
    if (touchY > 0) {
        return YES;
    }
    return NO;
}

@end
