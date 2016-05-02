//
//  CYHTTPTool.m
//  CYBudejie
//
//  Created by Cyrill on 16/5/2.
//  Copyright © 2016年 Cyrill. All rights reserved.
//

#import "CYHTTPTool.h"
#import <AFNetworking.h>

@implementation CYHTTPTool

+ (void)GET:(NSString *)url params:(NSDictionary *)params success:(CYRequestSuccess)success failture:(CYRequestFailture)failture
{
    [[AFHTTPSessionManager manager] GET:url parameters:params success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        !success ? : success(responseObject);
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        !failture ? : failture(error);
    }];
}

+ (void)POST:(NSString *)url params:(NSDictionary *)params success:(CYRequestSuccess)success failture:(CYRequestFailture)failture
{
    [[AFHTTPSessionManager manager] POST:url parameters:params success:^(NSURLSessionDataTask *task, id responseObject) {
        !success ? : success(responseObject);
    } failure:^(NSURLSessionDataTask *task, NSError *error) {
        !failture ? : failture(error);
    }];
}

@end
