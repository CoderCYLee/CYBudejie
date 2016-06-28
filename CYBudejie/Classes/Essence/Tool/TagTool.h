//
//  TagTool.h
//  CYBudejie
//
//  Created by Cyrill on 16/6/28.
//  Copyright © 2016年 Cyrill. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "TagsParam.h"

typedef void (^TagsSuccess)(NSArray *tags);
typedef void (^TagsFailure)(NSError *error);

@interface TagTool : NSObject
+ (void)tagsWithParam:(TagsParam *)parame success:(TagsSuccess)success failure:(TagsFailure)failure;
@end
