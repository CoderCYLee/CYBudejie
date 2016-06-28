//
//  TopicsViewController.h
//  CYBudejie
//
//  Created by Cyrill on 16/6/28.
//  Copyright © 2016年 Cyrill. All rights reserved.
//

#import <UIKit/UIKit.h>

@class TopicParam;

@interface TopicsViewController : UITableViewController

/** 帖子的类型 */
@property (nonatomic) CYTopicsType type;

@end
