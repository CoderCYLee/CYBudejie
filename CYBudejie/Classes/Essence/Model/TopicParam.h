//
//  TopicParam.h
//  CYBudejie
//
//  Created by Cyrill on 16/6/28.
//  Copyright © 2016年 Cyrill. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface TopicParam : NSObject

@property (copy, nonatomic) NSString *maxtime;
/** 精华：list，新帖：newlist */
@property (copy, nonatomic) NSString *a;
/** 帖子：data */
@property (copy, nonatomic) NSString *c;
@property (assign, nonatomic) NSNumber *page;
@property (assign, nonatomic) NSNumber *per;
@property (assign, nonatomic) CYTopicsType type;

@end
