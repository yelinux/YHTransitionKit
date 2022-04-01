//
//  YHDismissPanRightGesture.h
//  YHTransitionKit
//
//  Created by chenyehong on 2022/4/1.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface YHPanRightDismissGesture : UIPanGestureRecognizer

-(instancetype)initWithCoder:(NSCoder *)coder NS_UNAVAILABLE;
-(instancetype)initWithTarget:(nullable id)target action:(nullable SEL)action NS_UNAVAILABLE;

@end

NS_ASSUME_NONNULL_END
