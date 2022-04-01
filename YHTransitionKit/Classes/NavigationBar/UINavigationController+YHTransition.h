//
//  UINavigationController+YHTransition.h
//  YHTransitionKit
//
//  Created by chenyehong on 2022/3/31.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

typedef NS_ENUM(NSInteger , YHNavigationInteractivePopType) {
    /// 无侧滑
    YHNavigationInteractivePopTypeNone,
    /// 左侧侧滑
    YHNavigationInteractivePopTypeLeftScreen,
    /// 全屏侧滑
    YHNavigationInteractivePopTypeFullScreen
};

@interface UINavigationController (YHTransition)

/// 自定义转场动画
@property (nonatomic, strong) id<UIViewControllerAnimatedTransitioning> yh_pushPopAnimated;
/// 侧滑返回方式，如果设置全屏侧滑，必须设置自定义转场动画yh_pushPopAnimated
@property (nonatomic, assign) YHNavigationInteractivePopType yh_interactivePopType;

@end

NS_ASSUME_NONNULL_END
