//
//  MeViewController.m
//  CYBudejie
//
//  Created by Cyrill on 16/5/1.
//  Copyright © 2016年 Cyrill. All rights reserved.
//

#import "MeViewController.h"

@interface MeViewController ()

@end

@implementation MeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
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
    self.navigationItem.title = @"我的";
    self.navigationItem.rightBarButtonItems = @[
                                                [UIBarButtonItem itemWithImage:@"mine-setting-icon" highImage:@"mine-setting-icon-click" target:self action:@selector(setting)],
                                                [UIBarButtonItem itemWithImage:@"mine-moon-icon" highImage:@"mine-moon-icon-click" target:self action:@selector(moon)]
                                                ];
}

- (void)setting
{
    
}

- (void)moon
{
    
}

@end
