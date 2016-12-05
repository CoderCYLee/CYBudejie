//
//  TopicsViewController.m
//  CYBudejie
//
//  Created by Cyrill on 16/6/28.
//  Copyright © 2016年 Cyrill. All rights reserved.
//

#import "TopicsViewController.h"
#import "TopicTool.h"
#import "TopicFrame.h"
#import "TopicCell.h"
#import "NewViewController.h"
#import "CYCommentViewController.h"

@interface TopicsViewController ()

@property (nonatomic, strong) NSMutableArray *topicFrames;
@property (nonatomic, strong) TopicParam *param;
@property (nonatomic, strong) NSString *maxtime;

@end

@implementation TopicsViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
        
    [self setupTableView];
    
    [self setupRefresh];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - <代理方法>
- (NSInteger)tableView:(nonnull UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    self.tableView.mj_footer.hidden = (self.topicFrames.count == 0);
    return self.topicFrames.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    TopicCell *cell = [TopicCell cellWithTableView:tableView];
    cell.topicFrame = self.topicFrames[indexPath.row];
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    TopicFrame *f = self.topicFrames[indexPath.row];
    
    return f.cellHeight;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    CYCommentViewController *comment = [[CYCommentViewController alloc] init];
    comment.topicFrame = self.topicFrames[indexPath.row];
    [self.navigationController pushViewController:comment animated:YES];
}

#pragma mark - private methods
- (void)setupRefresh
{
    // header
    self.tableView.mj_header = [MJRefreshNormalHeader headerWithRefreshingTarget:self refreshingAction:@selector(loadNewTopics)];
    self.tableView.mj_header.lastUpdatedTimeKey = [NSString stringWithFormat:@"%@-%@-%zd", [self class], self.param.a, self.type];
    self.tableView.mj_header.automaticallyChangeAlpha = YES;
    [self.tableView.mj_header beginRefreshing];
    
    // footer
    self.tableView.mj_footer = [MJRefreshAutoNormalFooter footerWithRefreshingTarget:self refreshingAction:@selector(loadMoreTopics)];
    self.tableView.mj_footer.hidden = YES;
}

- (void)setupTableView
{
    self.tableView.backgroundColor = [UIColor clearColor];
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    self.tableView.contentInset = UIEdgeInsetsMake(104, 0, 49, 0);
    self.tableView.scrollIndicatorInsets = self.tableView.contentInset;
}

#pragma mark - 加载数据
- (void)loadNewTopics
{
    // 结束上啦
    [self.tableView.mj_footer endRefreshing];
    
    NSNumber *lastPage = self.param.page;
    
    self.param.page = @1;
    
    [TopicTool topicWithParam:self.param success:^(TopicResult *result) {
        self.maxtime = result.maxtime;
        
        [self.topicFrames removeAllObjects];
        
        NSMutableArray *newFrames = [NSMutableArray array];
        for (Topic *topic in result.list) {
            TopicFrame *f = [[TopicFrame alloc] init];
            f.topic = topic;
            [newFrames addObject:f];
        }
        [self.topicFrames addObjectsFromArray:newFrames];
        
        [self.tableView reloadData];
        [self.tableView.mj_header endRefreshing];
    } failure:^(NSError *error) {
        self.param.page = lastPage;
        [self.tableView.mj_header endRefreshing];
    }];
}

- (void)loadMoreTopics
{
    NSNumber *lastPage = self.param.page;
    self.param.page = @(self.param.page.intValue + 1);
    self.param.maxtime = self.maxtime;
    
    [TopicTool topicWithParam:self.param success:^(TopicResult *result) {
        self.maxtime = result.maxtime;
        
        NSMutableArray *newFrames = [NSMutableArray array];
        for (Topic *topic in result.list) {
            TopicFrame *f = [[TopicFrame alloc] init];
            f.topic = topic;
            [newFrames addObject:f];
        }
        [self.topicFrames addObjectsFromArray:newFrames];
        
        [self.tableView reloadData];
        
        [self.tableView.mj_footer endRefreshing];
    } failure:^(NSError *error) {
        self.param.page = lastPage;
        [self.tableView.mj_footer endRefreshing];
    }];
}


#pragma mark - setter and getter
- (TopicParam *)param
{
    if (!_param) {
        self.param = [[TopicParam alloc] init];
        self.param.a = [self.parentViewController isKindOfClass:[NewViewController class]] ? @"newlist" : @"list";
        self.param.c = @"data";
        self.param.type = self.type;
    }
    return _param;
}

- (NSMutableArray *)topicFrames
{
    if (!_topicFrames) {
        self.topicFrames = [NSMutableArray array];
    }
    return _topicFrames;
}



@end
