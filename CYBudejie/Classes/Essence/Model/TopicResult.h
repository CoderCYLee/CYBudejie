//
//  TopicResult.h
//  CYBudejie
//
//  Created by Cyrill on 16/6/28.
//  Copyright © 2016年 Cyrill. All rights reserved.
//

#import <Foundation/Foundation.h>

@class Topic;

@interface TopicResult : NSObject

@property (copy, nonatomic) NSString *maxtime;
/** 帖子的总数 */
@property (assign, nonatomic) int count;
/** 默认情况下，就是一页20个帖子情况下的最大页数 */
@property (assign, nonatomic) int page;
/** 帖子数据 */
//@property (strong, nonatomic) NSArray<Topic *> *list;
@property (strong, nonatomic) NSArray *list;

@end
