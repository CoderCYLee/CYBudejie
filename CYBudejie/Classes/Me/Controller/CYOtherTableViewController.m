//
//  CYOtherTableViewController.m
//  CYBudejie
//
//  Created by Cyrill on 2016/12/8.
//  Copyright © 2016年 Cyrill. All rights reserved.
//

#import "CYOtherTableViewController.h"
#import "CYTextViewController.h"

#define SYSTEM_VERSION_EQUAL_TO(v)                  ([[[UIDevice currentDevice] systemVersion] compare:v options:NSNumericSearch] == NSOrderedSame)
#define SYSTEM_VERSION_GREATER_THAN(v)              ([[[UIDevice currentDevice] systemVersion] compare:v options:NSNumericSearch] == NSOrderedDescending)
#define SYSTEM_VERSION_GREATER_THAN_OR_EQUAL_TO(v)  ([[[UIDevice currentDevice] systemVersion] compare:v options:NSNumericSearch] != NSOrderedAscending)
#define SYSTEM_VERSION_LESS_THAN(v)                 ([[[UIDevice currentDevice] systemVersion] compare:v options:NSNumericSearch] == NSOrderedAscending)
#define SYSTEM_VERSION_LESS_THAN_OR_EQUAL_TO(v)     ([[[UIDevice currentDevice] systemVersion] compare:v options:NSNumericSearch] != NSOrderedDescending)

@interface CYOtherTableViewController ()<UIViewControllerPreviewingDelegate>

@property (nonatomic, strong) NSArray *dataArray;

@end

@implementation CYOtherTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self.tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:@"cell"];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.dataArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell" forIndexPath:indexPath];
    
    cell.textLabel.text = self.dataArray[indexPath.row];
    
#ifdef __IPHONE_9_0
    if ([self Check3DTouch])
    {
        [self registerForPreviewingWithDelegate:self sourceView:cell];
    }
#endif
    
    return cell;
}

#pragma mark - Table view delegate
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
}

#pragma mark -UIViewControllerPreviewing Delegate

#ifdef __IPHONE_9_0

//Peek代理方法
-(UIViewController *)previewingContext:(id<UIViewControllerPreviewing>)previewingContext viewControllerForLocation:(CGPoint)location
{
    //获得当前cell的indexPath
    NSIndexPath * indexPath = [self.tableView indexPathForCell:(UITableViewCell *)previewingContext.sourceView];
    
    CYTextViewController * textVC = [[CYTextViewController alloc] init];
//    [textVC setValue:self.dataArray[indexPath.row] forKey:@"title1"];
    
    return textVC;
}

//pop代理方法
-(void)previewingContext:(id<UIViewControllerPreviewing>)previewingContext commitViewController:(UIViewController *)viewControllerToCommit
{
    [self showViewController:viewControllerToCommit sender:self];
}

#pragma mark - 3D touch Check
/**
 检测是否支持3D Touch

 @return YES || NO
 */
- (BOOL)Check3DTouch
{
    if (self.traitCollection.forceTouchCapability == UIForceTouchCapabilityAvailable)
    {
        return YES;
    }
    
    return NO;
}

#endif


- (NSArray *)dataArray
{
    if (!_dataArray) {
        _dataArray = @[@"3DTouch"];
    }
    return _dataArray;
}

@end
