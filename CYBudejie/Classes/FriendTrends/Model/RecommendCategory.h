//
//  RecommendCategory.h
//  CYBudejie
//
//  Created by Cyrill on 16/5/7.
//  Copyright © 2016年 Cyrill. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface RecommendCategory : NSObject

/** id */
@property (nonatomic, assign) NSInteger ID;
/** <#注释#> */
@property (nonatomic, copy) NSString *desc;
/** 总数 */
@property (nonatomic, assign) NSInteger count;
/** 名字 */
@property (nonatomic, copy) NSString *name;

/** 这个类别对应的用户数据 */
@property (nonatomic, strong) NSMutableArray *users;
/** 总数 */
@property (nonatomic, assign) NSInteger total;
/** 当前页码 */
@property (nonatomic, assign) NSInteger currentPage;

@end
