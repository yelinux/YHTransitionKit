//
//  UIGestureRecognizer+YHDismiss.h
//  YHTransitionKit
//
//  Created by chenyehong on 2022/4/1.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@protocol YHDismissProcessDelegate <NSObject>

- (void)yhDismissStart;
- (void)yhDismissProgress: (CGFloat)progress;
- (void)yhDismissFinish;
- (void)yhDismissCancel;

@end

@interface UIGestureRecognizer (YHDismiss)

@property (nonatomic, weak) id<YHDismissProcessDelegate> dismissDelegate;

@end

NS_ASSUME_NONNULL_END
