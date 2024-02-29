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

@interface YHViewController ()<UINavigationControllerDelegate, UIImagePickerControllerDelegate>

@property (nonatomic, strong) UIImagePickerController *picker;

@end

@implementation YHViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    self.yh_prefersNavigationBarType = YHViewControllerNavigationBarTypeShow;//导航栏是否显示(必设)
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
    [self yh_presentViewController:vc//模态跳转
             animatedTransitioning:YHPresentDismissScaleRightAnimated.new//自定义跳转动画-从右向左
                        completion:^(YHBindDismissGestureBlock  _Nonnull bindDismissGestureBlock) {
        bindDismissGestureBlock(vc.view, YHPanRightDismissGesture.new);//跳转结束，绑定返回手势
    }];
}

- (IBAction)clickPresentNav:(id)sender {
    YHSecondViewController *vc = [[YHSecondViewController alloc] init];
    UINavigationController *nav = [[UINavigationController alloc] initWithRootViewController:vc];
    nav.navigationBar.translucent = NO;
    [self yh_presentViewController:nav//模态跳转
             animatedTransitioning:YHPresentDismissScaleBottomAnimated.new//自定义跳转动画-从下向上
                        completion:^(YHBindDismissGestureBlock  _Nonnull bindDismissGestureBlock) {
        bindDismissGestureBlock(vc.view, YHPanDownDismissGesture.new);//跳转结束，绑定返回手势
    }];
}

- (IBAction)clickPresentTab:(id)sender {
    YHTabBarViewController *vc = [[YHTabBarViewController alloc] init];
    [self yh_presentViewController:vc//模态跳转
             animatedTransitioning:YHPresentDismissScaleRightAnimated.new//自定义跳转动画-从右向左
                        completion:^(YHBindDismissGestureBlock  _Nonnull bindDismissGestureBlock) {
        bindDismissGestureBlock(vc.viewControllers[0].view, YHPanRightDismissGesture.new);//跳转结束，绑定返回手势
        bindDismissGestureBlock(vc.viewControllers[1].view, YHPanRightDismissGesture.new);//跳转结束，绑定返回手势
    }];
}

- (IBAction)clickCamera:(id)sender {
    self.picker = [[UIImagePickerController alloc] init];
    self.picker.delegate = self;
    self.picker.sourceType = UIImagePickerControllerSourceTypeCamera;
    self.picker.cameraDevice = UIImagePickerControllerCameraDeviceRear;
    [self presentViewController:self.picker animated:YES completion:nil];
}

// MARK: - UINavigationControllerDelegate, UIImagePickerControllerDelegate
- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary<UIImagePickerControllerInfoKey,id> *)info {
    NSLog(@"%s", __func__);
    [picker dismissViewControllerAnimated:YES completion:nil];
}

- (void)imagePickerControllerDidCancel:(UIImagePickerController *)picker {
    NSLog(@"%s", __func__);
    [picker dismissViewControllerAnimated:YES completion:nil];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
