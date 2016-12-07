//
//  CYCommentViewController.m
//  CYBudejie
//
//  Created by Cyrill on 2016/12/5.
//  Copyright © 2016年 Cyrill. All rights reserved.
//

#import "CYCommentViewController.h"
#import "CYComment.h"
#import "TopicCell.h"
#import "Topic.h"
#import "CYCommentHeaderView.h"
#import "CYCommentCell.h"

static NSString * const CYCommentId = @"comment";

@interface CYCommentViewController () <UITableViewDelegate, UITableViewDataSource>

/** 工具条底部间距 */
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *bottomSapce;
@property (weak, nonatomic) IBOutlet UITableView *tableView;

/** 最热评论 */
@property (nonatomic, strong) NSArray *hotComments;
/** 最新评论 */
@property (nonatomic, strong) NSMutableArray *latestComments;

/** 保存帖子的top_cmt */
@property (nonatomic, strong) CYComment *saved_top_cmt;

/** 保存当前的页码 */
@property (nonatomic, assign) NSInteger page;

/** 管理者 */
@property (nonatomic, strong) AFHTTPSessionManager *manager;

@end

@implementation CYCommentViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self setupBasic];
    
    [self setupHeader];
    
    [self setupRefresh];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

- (void)dealloc
{
    [[NSNotificationCenter defaultCenter] removeObserver:self];
    
    
    // 恢复帖子的top_cmt
//    if (self.saved_top_cmt) {
//        self.topicFrame.topic.top_cmt = self.saved_top_cmt;
//        [self.topicFrame.topic setValue:@0 forKeyPath:@"cellHeight"];
//    }
    
    [self.manager invalidateSessionCancelingTasks:YES];
}

#pragma mark - <UITableViewDelegate>
- (void)scrollViewWillBeginDragging:(UIScrollView *)scrollView
{
    [self.view endEditing:YES];
}

#pragma mark - <UITableViewDataSource>
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    NSInteger hotCount = self.hotComments.count;
    NSInteger latestCount = self.latestComments.count;
    
    if (hotCount) return 2; // 有"最热评论" + "最新评论" 2组
    if (latestCount) return 1; // 有"最新评论" 1 组
    return 0;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    NSInteger hotCount = self.hotComments.count;
    NSInteger latestCount = self.latestComments.count;
    
    // 隐藏尾部控件
    tableView.mj_footer.hidden = (latestCount == 0);
    
    if (section == 0) {
        return hotCount ? hotCount : latestCount;
    }
    
    // 非第0组
    return latestCount;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    // 先从缓存池中找header
    CYCommentHeaderView *header = [CYCommentHeaderView headerViewWithTableView:tableView];
    
    // 设置label的数据
    NSInteger hotCount = self.hotComments.count;
    if (section == 0) {
        header.title = hotCount ? @"最热评论" : @"最新评论";
    } else {
        header.title = @"最新评论";
    }
    return header;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    CYComment *comment = [self commentInIndexPath:indexPath];
    
    CYCommentCell *cell = [tableView dequeueReusableCellWithIdentifier:CYCommentId];
//    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    cell.comment = comment;
    
    return cell;
}

- (void)setupBasic {
    self.title = @"评论";
    self.navigationItem.rightBarButtonItem = [UIBarButtonItem itemWithImage:@"comment_nav_item_share_icon" highImage:@"comment_nav_item_share_icon_click" target:nil action:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardWillChangeFrame:) name:UIKeyboardWillChangeFrameNotification object:nil];
    
    self.tableView.backgroundColor = CYGlobalColor;
    // 自适应的cell height
    self.tableView.estimatedRowHeight = 44.0;
    self.tableView.rowHeight = UITableViewAutomaticDimension;
    
    [self.tableView registerNib:[UINib nibWithNibName:NSStringFromClass([CYCommentCell class]) bundle:nil] forCellReuseIdentifier:CYCommentId];
}

- (void)keyboardWillChangeFrame:(NSNotification *)note
{
    // 键盘显示\隐藏完毕的frame
    CGRect frame = [note.userInfo[UIKeyboardFrameEndUserInfoKey] CGRectValue];
    // 修改底部约束
    self.bottomSapce.constant = kScreenH - frame.origin.y;
    // 动画时间
    CGFloat duration = [note.userInfo[UIKeyboardAnimationDurationUserInfoKey] doubleValue];
    // 动画 及时刷新
    [UIView animateWithDuration:duration animations:^{
        [self.view layoutIfNeeded];
    }];
}

/**
 * 返回第section组的所有评论数组
 */
- (NSArray *)commentsInSection:(NSInteger)section
{
    if (section == 0) {
        return self.hotComments.count ? self.hotComments : self.latestComments;
    }
    return self.latestComments;
}

- (CYComment *)commentInIndexPath:(NSIndexPath *)indexPath
{
    return [self commentsInSection:indexPath.section][indexPath.row];
}

- (void)setupHeader {
    // 创建header
    UIView *header = [[UIView alloc] init];
    
//    // 清空top_cmt
//    if (self.topicFrame.topic.top_cmt) {
//        self.saved_top_cmt = self.topicFrame.topic.top_cmt;
//        self.topicFrame.topic.top_cmt = nil;
//        [self.topicFrame.topic setValue:@0 forKeyPath:@"cellHeight"];
//    }
    
    // 添加cell
    TopicCell *cell = [TopicCell cell];
    cell.topicFrame = self.topicFrame;
    cell.mj_size = CGSizeMake(kScreenW, self.topicFrame.cellHeight);
    [header addSubview:cell];
    
    // header的高度
    header.cy_height = self.topicFrame.cellHeight + 10;
    
    // 设置header
    self.tableView.tableHeaderView = header;
}

- (void)setupRefresh {
    self.tableView.mj_header = [MJRefreshNormalHeader headerWithRefreshingTarget:self refreshingAction:@selector(loadNewComments)];
    [self.tableView.mj_header beginRefreshing];
    
    self.tableView.mj_footer = [MJRefreshAutoNormalFooter footerWithRefreshingTarget:self refreshingAction:@selector(loadMoreComments)];
    self.tableView.mj_footer.hidden = YES;
}

- (void)loadMoreComments {
    
    // 结束之前的所有请求
    // 这样做连session都不好使了
//    [self.manager invalidateSessionCancelingTasks:YES];
    [self.manager.tasks makeObjectsPerformSelector:@selector(cancel)];
    
    // 页码
    NSInteger page = self.page + 1;
    
    // 参数
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    params[@"a"] = @"dataList";
    params[@"c"] = @"comment";
    params[@"data_id"] = self.topicFrame.topic.ID;
    params[@"page"] = @(page);
    
    CYComment *cmt = [self.latestComments lastObject];
    params[@"lastcid"] = cmt.ID;
    
    [self.manager GET:CYMainURL parameters:params progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        // 没有数据
        if (![responseObject isKindOfClass:[NSDictionary class]]) {
            self.tableView.mj_footer.hidden = YES;
            return;
        }
        
        // 最新评论
        NSArray *newComments = [CYComment mj_objectArrayWithKeyValuesArray:responseObject[@"data"]];
        [self.latestComments addObjectsFromArray:newComments];
        
        // 页码
        self.page = page;
        
        // 刷新数据
        [self.tableView reloadData];
        
        // 控制footer状态
        NSInteger total = [responseObject[@"total"] integerValue];
        if (self.latestComments.count >= total) {
            self.tableView.mj_footer.hidden = YES;
        } else {
            // 结束刷新状态
            [self.tableView.mj_footer endRefreshing];
        }
        
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        
        [self.tableView.mj_footer endRefreshing];
        
    }];
}

- (void)loadNewComments
{
    // 结束之前的所有请求
    [self.manager.tasks makeObjectsPerformSelector:@selector(cancel)];
    
    // 参数
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    params[@"a"] = @"dataList";
    params[@"c"] = @"comment";
    params[@"data_id"] = self.topicFrame.topic.ID;
    params[@"hot"] = @"1";
    
    [self.manager GET:CYMainURL parameters:params progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        // 最热评论
        self.hotComments = [CYComment mj_objectArrayWithKeyValuesArray:responseObject[@"hot"]];
        
        // 最新评论
        self.latestComments = [CYComment mj_objectArrayWithKeyValuesArray:responseObject[@"data"]];
        
        // 页码
        self.page = 1;
        
        [self.tableView reloadData];
        [self.tableView.mj_header endRefreshing];
        
        // 控制footer的状态
        NSInteger total = [responseObject[@"total"] integerValue];
        if (self.latestComments.count >= total) { // 全部加载完毕
            self.tableView.mj_footer.hidden = YES;
        }
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        [self.tableView.mj_header endRefreshing];
    }];
    
}

- (AFHTTPSessionManager *)manager
{
    if (!_manager) {
        _manager = [AFHTTPSessionManager manager];
    }
    return _manager;
}

@end
