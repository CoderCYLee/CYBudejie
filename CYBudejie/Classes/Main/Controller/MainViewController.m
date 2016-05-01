//
//  MainViewController.m
//  CYBudejie
//
//  Created by Cyrill on 16/5/1.
//  Copyright © 2016年 Cyrill. All rights reserved.
//

#import "MainViewController.h"
#import "NavigationViewController.h"

#import "EssenceViewController.h"
#import "NewViewController.h"
#import "FriendTrendsViewController.h"
#import "MeViewController.h"

@interface MainViewController ()

@end

@implementation MainViewController

+ (void)initialize
{
    
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    
    // 初始化所有的子控制器
    [self setupChildViewControllers];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - provate methods
/**
 * 初始化所有的子控制器
 */
- (void)setupChildViewControllers
{
    EssenceViewController *essence = [[EssenceViewController alloc] init];
    [self setupOneChildViewController:essence title:@"精华" image:@"tabBar_essence_icon" selectedImage:@"tabBar_essence_click_icon"];
    
    NewViewController *new = [[NewViewController alloc] init];
    [self setupOneChildViewController:new title:@"新帖" image:@"tabBar_new_icon" selectedImage:@"tabBar_new_click_icon"];
    
    FriendTrendsViewController *friends = [[FriendTrendsViewController alloc] init];
    [self setupOneChildViewController:friends title:@"关注" image:@"tabBar_friendTrends_icon" selectedImage:@"tabBar_friendTrends_click_icon"];
    
    MeViewController *me = [[MeViewController alloc] init];
    [self setupOneChildViewController:me title:@"我" image:@"tabBar_me_icon" selectedImage:@"tabBar_me_click_icon"];
}

- (void)setupOneChildViewController:(UIViewController *)vc title:(NSString *)title image:(NSString *)image selectedImage:(NSString *)selectedImage
{
    vc.tabBarItem.title = title;
    vc.tabBarItem.image = [UIImage imageNamed:image];
    vc.tabBarItem.selectedImage = [UIImage imageNamed:selectedImage];
    [self addChildViewController:[[NavigationViewController alloc] initWithRootViewController:vc]];
}

@end
