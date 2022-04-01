//
//  YHViewController.m
//  YHTransitionKit
//
//  Created by ye_linux@126.com on 03/31/2022.
//  Copyright (c) 2022 ye_linux@126.com. All rights reserved.
//

#import "YHViewController.h"
#import "YHSecondViewController.h"
#import "YHThirdViewController.h"
#import "YHTabBarViewController.h"

@interface YHViewController ()

@end

@implementation YHViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
    self.yh_prefersNavigationBarType = YHViewControllerNavigationBarTypeShow;
}

- (IBAction)swShowHide:(UISwitch*)sender {
    if (self.yh_prefersNavigationBarType == YHViewControllerNavigationBarTypeShow) {
        self.yh_prefersNavigationBarType = YHViewControllerNavigationBarTypeHidden;
        sender.on = YES;
    } else {
        self.yh_prefersNavigationBarType = YHViewControllerNavigationBarTypeShow;
        sender.on = NO;
    }
}

- (IBAction)clickToShowNav:(id)sender {
    YHSecondViewController *vc = [[YHSecondViewController alloc] init];
    [self.navigationController pushViewController:vc animated:YES];
}

- (IBAction)clickToHideNav:(id)sender {
    YHThirdViewController *vc = [[YHThirdViewController alloc] init];
    [self.navigationController pushViewController:vc animated:YES];
}

- (IBAction)clickPresentVC:(id)sender {
    YHSecondViewController *vc = [[YHSecondViewController alloc] init];
    [self yh_presentViewController:vc
             animatedTransitioning:YHPresentDismissScaleRightAnimated.new
                        completion:^(YHBindDismissGestureBlock  _Nonnull bindDismissGestureBlock) {
        bindDismissGestureBlock(vc.view, YHPanRightDismissGesture.new);
    }];
}

- (IBAction)clickPresentNav:(id)sender {
    YHSecondViewController *vc = [[YHSecondViewController alloc] init];
    UINavigationController *nav = [[UINavigationController alloc] initWithRootViewController:vc];
    nav.navigationBar.translucent = NO;
    [self yh_presentViewController:nav
             animatedTransitioning:YHPresentDismissScaleRightAnimated.new
                        completion:^(YHBindDismissGestureBlock  _Nonnull bindDismissGestureBlock) {
        bindDismissGestureBlock(vc.view, YHPanRightDismissGesture.new);
    }];
}

- (IBAction)clickPresentTab:(id)sender {
    YHTabBarViewController *vc = [[YHTabBarViewController alloc] init];
    [self yh_presentViewController:vc
             animatedTransitioning:YHPresentDismissScaleRightAnimated.new
                        completion:^(YHBindDismissGestureBlock  _Nonnull bindDismissGestureBlock) {
        bindDismissGestureBlock(vc.viewControllers[0].view, YHPanRightDismissGesture.new);
        bindDismissGestureBlock(vc.viewControllers[1].view, YHPanRightDismissGesture.new);
    }];
}

-(UIStatusBarStyle)preferredStatusBarStyle{
    return UIStatusBarStyleLightContent;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)dealloc{
    NSLog(@"YHViewController dealloc");
}

@end
