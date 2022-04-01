//
//  YHTabSub3ViewController.m
//  YHTransitionKit_Example
//
//  Created by chenyehong on 2022/4/1.
//  Copyright © 2022 ye_linux@126.com. All rights reserved.
//

#import "YHTabSub3ViewController.h"

@interface YHTabSub3ViewController ()

@end

@implementation YHTabSub3ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    self.title = @"tab3";
}

- (IBAction)clickDismiss:(id)sender {
    [self dismissViewControllerAnimated:YES completion:nil];
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
