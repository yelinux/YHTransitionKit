//
//  YHTabBarViewController.m
//  YHTransitionKit_Example
//
//  Created by chenyehong on 2022/4/1.
//  Copyright © 2022 ye_linux@126.com. All rights reserved.
//

#import "YHTabBarViewController.h"
#import "YHTabSub1ViewController.h"
#import "YHTabSub2ViewController.h"
#import "YHTabSub3ViewController.h"

@interface YHTabBarViewController ()

@property (nonatomic, strong) YHTabSub1ViewController *vc1;
@property (nonatomic, strong) YHTabSub2ViewController *vc2;
@property (nonatomic, strong) YHTabSub3ViewController *vc3;

@end

@implementation YHTabBarViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    _vc1 = [[YHTabSub1ViewController alloc] init];
    _vc2 = [[YHTabSub2ViewController alloc] init];
    [_vc2 loadViewIfNeeded];
    _vc3 = [[YHTabSub3ViewController alloc] init];
    [_vc3 loadViewIfNeeded];
    
    [self setupChildVc:_vc1];
    [self setupChildVc:_vc2];
    [self setupChildVc:_vc3];
}

- (void)setupChildVc:(UIViewController *)vc{
    UINavigationController *nav = [[UINavigationController alloc] initWithRootViewController:vc];
    nav.yh_navBackgroundColor = UIColor.whiteColor;
    nav.yh_titleTextAttributes = @{NSForegroundColorAttributeName:[UIColor colorWithRed:20/255.0 green:122/255.0 blue:244/255.0 alpha:1]};
    [self addChildViewController:nav];
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
