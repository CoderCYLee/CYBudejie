//
//  TopicTool.h
//  CYBudejie
//
//  Created by Cyrill on 16/6/28.
//  Copyright © 2016年 Cyrill. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Topic.h"
#import "TopicParam.h"
#import "TopicResult.h"

typedef void (^TopicSuccess)(TopicResult *result);
typedef void (^TopicFailure)(NSError *error);

@interface TopicTool : NSObject
+ (void)topicWithParam:(TopicParam *)parame success:(TopicSuccess)success failure:(TopicFailure)failure;
@end
