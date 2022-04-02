//
//  YHSecondViewController.m
//  YHTransitionKit_Example
//
//  Created by chenyehong on 2022/3/31.
//  Copyright © 2022 ye_linux@126.com. All rights reserved.
//

#import "YHSecondViewController.h"

@interface YHSecondViewController ()

@end

@implementation YHSecondViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    self.title = @"Second";
    //特殊设置
    self.yh_prefersNavigationBarType = YHViewControllerNavigationBarTypeShow;//导航栏是否显示(必设)
    self.yh_navBackgroundColor = [UIColor colorWithRed:220/255.0 green:189/255.0 blue:206/255.0 alpha:1];//导航栏背景颜色(选设)
    self.yh_titleTextAttributes = @{NSForegroundColorAttributeName:[UIColor colorWithRed:20/255.0 green:122/255.0 blue:244/255.0 alpha:1]};//标题文本属性(选设)
//    self.yh_backgroundImage = [UIImage imageNamed:@"nav_bg_image"];//导航栏背景图片(选设)
    self.yh_shadowColor = UIColor.grayColor;//导航栏分割线颜色(选设)
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
