//
//  RecommendCategory.m
//  CYBudejie
//
//  Created by Cyrill on 16/5/7.
//  Copyright © 2016年 Cyrill. All rights reserved.
//

#import "RecommendCategory.h"

@implementation RecommendCategory

+ (NSDictionary *)replacedKeyFromPropertyName
{
    return @{@"ID" : @"id"};
}

- (NSMutableArray *)users
{
    if (!_users) {
        _users = [NSMutableArray array];
    }
    return _users;
}

@end
