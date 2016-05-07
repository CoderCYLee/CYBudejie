//
//  RecommendViewController.m
//  CYBudejie
//
//  Created by Cyrill on 16/5/2.
//  Copyright © 2016年 Cyrill. All rights reserved.
//

#import "RecommendViewController.h"

@interface RecommendViewController () <UITableViewDelegate, UITableViewDataSource>

@property (weak, nonatomic) IBOutlet UITableView *categoryTableView;
@property (weak, nonatomic) IBOutlet UITableView *userTableView;

@end

@implementation RecommendViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    
    self.categoryTableView.contentInset = UIEdgeInsetsMake(64, 0, 0, 0);
    self.userTableView.contentInset = UIEdgeInsetsMake(64, 0, 0, 0);
    self.title = @"推荐关注";
    self.automaticallyAdjustsScrollViewInsets = NO;
    self.view.backgroundColor = CYGlobalColor;
    
    // 加载左边数据
    [self loadCategories];
    
    // 刷新控件
    [self setupRefresh];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - delegate

#pragma mark - <UITableViewDataSource>
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 10;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
//    if (tableView == self.categoryTableView) {
//        XMGRecommendCategoryCell *cell = [XMGRecommendCategoryCell cellWithTableView:tableView];
//        cell.category = self.categories[indexPath.row];
//        return cell;
//    } else {
//        XMGRecommendUserCell *cell = [XMGRecommendUserCell cellWithTableView:tableView];
//        cell.user = [XMGSelectedCategory users][indexPath.row];
//        return cell;
//    }
    
    UITableViewCell *cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"cell"];
    cell.textLabel.text = [NSString stringWithFormat:@"%ld", indexPath.row];
    return cell;
}

#pragma mark - <UITableViewDelegate>
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    
}

/**
 *  加载左边数据
 */
- (void)loadCategories
{
//    [SVProgressHUD show];

}

- (void)setupRefresh
{
//    self.userTableView.header = [MJRefreshNormalHeader headerWithRefreshingTarget:self refreshingAction:@selector(loadNewUsers)];
//    
//    self.userTableView.footer = [MJRefreshAutoNormalFooter footerWithRefreshingTarget:self refreshingAction:@selector(loadMoreUsers)];
//    self.userTableView.footer.hidden = YES;
}

@end
