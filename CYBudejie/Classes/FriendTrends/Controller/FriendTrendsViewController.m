//
//  FriendTrendsViewController.m
//  CYBudejie
//
//  Created by Cyrill on 16/5/1.
//  Copyright © 2016年 Cyrill. All rights reserved.
//

#import "FriendTrendsViewController.h"
#import "RecommendViewController.h"


@interface FriendTrendsViewController ()

@end

@implementation FriendTrendsViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.view.backgroundColor = CYGlobalColor;
    
    [self setupNavBar];
    
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - private methods
- (void)setupNavBar
{
    self.navigationItem.title = @"我的关注";
    self.navigationItem.leftBarButtonItem = [UIBarButtonItem itemWithImage:@"friendsRecommentIcon" highImage:@"friendsRecommentIcon-click" target:self action:@selector(following)];
}

- (void)following
{
    RecommendViewController *vc = [[RecommendViewController alloc] init];
    [self.navigationController pushViewController:vc animated:YES];
}

@end
