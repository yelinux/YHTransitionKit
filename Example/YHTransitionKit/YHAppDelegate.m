//
//  YHAppDelegate.m
//  YHTransitionKit
//
//  Created by ye_linux@126.com on 03/31/2022.
//  Copyright (c) 2022 ye_linux@126.com. All rights reserved.
//

#import "YHAppDelegate.h"

//org.cocoapods.demo.YHTransitionKit-Example

@implementation YHAppDelegate

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    // Override point for customization after application launch.
    self.window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
    
    UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
    UIViewController *vc = [storyboard instantiateInitialViewController];
    vc.title = @"YHTransitionKit示例";

    UINavigationController *nav = [[UINavigationController alloc] initWithRootViewController:vc];
    //导航栏全局设置
    nav.yh_interactivePopType = YHNavigationInteractivePopTypeFullScreen;//全屏右滑返回手势(选设)
    nav.yh_pushPopAnimated = [[YHNavigationScaleAnimated alloc] init];//自定义动画（全屏右滑返回必设，其它情况选设）
    nav.yh_navBackgroundColor = [UIColor colorWithRed:20/255.0 green:122/255.0 blue:244/255.0 alpha:1];//背景颜色(选设)
    nav.yh_titleTextAttributes = @{NSForegroundColorAttributeName:UIColor.whiteColor};//标题文本属性(选设)
    nav.yh_shadowColor = UIColor.blueColor;//分割线颜色(选设)
    nav.navigationBar.translucent = NO;
    
    self.window.rootViewController = nav;
    
    [self.window makeKeyAndVisible];
    
    return YES;
}

- (void)applicationWillResignActive:(UIApplication *)application
{
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application
{
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}

- (void)applicationWillEnterForeground:(UIApplication *)application
{
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
}

- (void)applicationDidBecomeActive:(UIApplication *)application
{
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}

- (void)applicationWillTerminate:(UIApplication *)application
{
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}

@end
