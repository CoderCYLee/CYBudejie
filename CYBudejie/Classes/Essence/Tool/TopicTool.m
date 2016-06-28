//
//  TopicTool.m
//  CYBudejie
//
//  Created by Cyrill on 16/6/28.
//  Copyright © 2016年 Cyrill. All rights reserved.
//

#import "TopicTool.h"
#import "CYHTTPTool.h"

@implementation TopicTool
+ (void)topicWithParam:(TopicParam *)parame success:(TopicSuccess)success failure:(TopicFailure)failure
{
    [CYHTTPTool GET:CYMainURL params:parame.mj_keyValues success:^(id json) {
        !success ? : success([TopicResult mj_objectWithKeyValues:json]);
    } failture:failure];
}
@end
