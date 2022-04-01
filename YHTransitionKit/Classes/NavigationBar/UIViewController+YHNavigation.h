//
//  UIViewController+YHNavigation.h
//  YHNavigationBarExample
//
//  Created by chenyehong on 2021/4/19.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

typedef NS_ENUM(NSInteger , YHViewControllerInteractivePopType) {
    /// 跟随navigationController
    YHViewControllerInteractivePopTypeFollowNav,
    /// 无侧滑
    YHViewControllerInteractivePopTypeNone,
    /// 左侧侧滑
    YHViewControllerInteractivePopTypeLeftScreen,
    /// 全屏侧滑
    YHViewControllerInteractivePopTypeFullScreen
};

typedef NS_ENUM(NSInteger , YHViewControllerNavigationBarType) {
    /// 未设置
    YHViewControllerNavigationBarTypeNone,
    /// 显示导航栏
    YHViewControllerNavigationBarTypeShow,
    /// 隐藏导航栏
    YHViewControllerNavigationBarTypeHidden
};

@interface UIViewController (YHNavigation)

/// 显示or隐藏导航栏
@property (nonatomic, assign) YHViewControllerNavigationBarType yh_prefersNavigationBarType;
/// 侧滑返回方式
@property (nonatomic, assign) YHViewControllerInteractivePopType yh_interactivePopType;
/// 导航栏背景颜色
@property (nonatomic, strong) UIColor *yh_navBackgroundColor;
/// 导航栏标题样式
@property (nonatomic, copy) NSDictionary<NSAttributedStringKey, id> *yh_titleTextAttributes;
/// 导航栏背景图片
@property (nonatomic, strong) UIImage *yh_backgroundImage;
/// 导航栏分割线颜色
@property (nonatomic, strong) UIColor *yh_shadowColor;

@end

NS_ASSUME_NONNULL_END
