//
//  TopicCell.h
//  CYBudejie
//
//  Created by Cyrill on 16/6/28.
//  Copyright © 2016年 Cyrill. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "TopicFrame.h"

@interface TopicCell : UITableViewCell

+ (instancetype)cell;

+ (instancetype)cellWithTableView:(UITableView *)tableView;

@property (nonatomic, strong) TopicFrame *topicFrame;

@end
