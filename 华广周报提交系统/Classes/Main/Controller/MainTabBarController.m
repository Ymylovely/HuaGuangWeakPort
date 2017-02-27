//
//  MainTabBarController.m
//  华广周报提交系统
//
//  Created by 孙 华 on 2016/11/2.
//  Copyright © 2016年 hg. All rights reserved.
//

#import "MainTabBarController.h"
#import "MainNavigationController.h"
#import "HomeViewController.h"
#import "OtherViewController.h"
@interface MainTabBarController ()

@end

@implementation MainTabBarController

- (void)viewDidLoad {
    [super viewDidLoad];
    HomeViewController *hvc = [HomeViewController new];
    OtherViewController *ovc = [OtherViewController new];
    hvc.title = @"周报";
    ovc.title = @"我的";
    hvc.tabBarItem.image = [UIImage imageNamed:@"iconfont-shouye-0"];
    hvc.tabBarItem.selectedImage = [UIImage imageNamed:@"iconfont-shouye"];
    ovc.tabBarItem.image = [UIImage imageNamed:@"iconfont-wode-0"];
    ovc.tabBarItem.selectedImage = [UIImage imageNamed:@"iconfont-wode"];
    self.viewControllers = @[NAVI(hvc),NAVI(ovc)];
    self.tabBar.tintColor = MainColor;
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
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
