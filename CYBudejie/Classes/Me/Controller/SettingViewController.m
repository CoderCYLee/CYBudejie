//
//  SettingViewController.m
//  CYBudejie
//
//  Created by Cyrill on 16/5/3.
//  Copyright © 2016年 Cyrill. All rights reserved.
//

#import "SettingViewController.h"
#import <SDImageCache.h>
#import "CYOtherTableViewController.h"

@interface SettingViewController ()

@property (nonatomic, strong) UIImageView *imageView;

@end

@implementation SettingViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.title = @"设置";
    self.tableView.backgroundColor = CYGlobalColor;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 3;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell"];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"cell"];
    }
    
    if (indexPath.row == 0) {
        CGFloat size = [SDImageCache sharedImageCache].getSize / 1000.0 / 1000;
        cell.textLabel.text = [NSString stringWithFormat:@"清除缓存（已使用%.2fMB）", size];
        cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    } else if (indexPath.row == 1) {
        cell.textLabel.text = [NSString stringWithFormat:@"ActionExtension"];
    } else if (indexPath.row == 2) {
        cell.textLabel.text = [NSString stringWithFormat:@"Other"];
    } else if (indexPath.row == 3) {
        cell.textLabel.text = [NSString stringWithFormat:@"TodayExtension"];
    }
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    if (indexPath.row == 0) {
        [[SDImageCache sharedImageCache] clearDisk];
    } else if (indexPath.row == 1) {
        
        UIImage *image = [UIImage imageNamed:@"app_slogan"];
        
        UIActivityViewController *activityVC = [[UIActivityViewController alloc] initWithActivityItems:@[image] applicationActivities:nil];
        [self presentViewController:activityVC animated:YES completion:^{
            
        }];
        
    } else if (indexPath.row == 2) {
        CYOtherTableViewController *vc = [[CYOtherTableViewController alloc] init];
        [self.navigationController pushViewController:vc animated:YES];
        
    } else if (indexPath.row == 3) {
        
    }
}

@end
