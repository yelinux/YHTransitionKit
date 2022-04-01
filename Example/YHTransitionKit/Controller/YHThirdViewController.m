//
//  YHThirdViewController.m
//  YHTransitionKit_Example
//
//  Created by chenyehong on 2022/3/31.
//  Copyright © 2022 ye_linux@126.com. All rights reserved.
//

#import "YHThirdViewController.h"

@interface YHThirdViewController ()

@end

@implementation YHThirdViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    self.title = NSStringFromClass([self class]);
    self.yh_prefersNavigationBarType = YHViewControllerNavigationBarTypeHidden;
    NSLog(@"YHThirdViewController viewDidLoad");
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
