//
//  TopicResult.m
//  CYBudejie
//
//  Created by Cyrill on 16/6/28.
//  Copyright © 2016年 Cyrill. All rights reserved.
//

#import "TopicResult.h"
#import "Topic.h"

@implementation TopicResult
+ (NSDictionary *)mj_replacedKeyFromPropertyName
{
    return @{@"page" : @"info.page", @"count" : @"info.count", @"maxtime" : @"info.maxtime"};
}

+ (NSDictionary *)mj_objectClassInArray
{
    return @{@"list" : [Topic class]};
}

@end
