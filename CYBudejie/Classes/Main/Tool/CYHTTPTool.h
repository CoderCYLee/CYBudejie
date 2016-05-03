//
//  CYHTTPTool.h
//  CYBudejie
//
//  Created by Cyrill on 16/5/2.
//  Copyright © 2016年 Cyrill. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef void (^CYRequestSuccess)(id json);
typedef void (^CYRequestFailture)(NSError *error);

@interface CYHTTPTool : NSObject

+ (void)GET:(NSString *)url params:(NSDictionary *)params success:(CYRequestSuccess)success failture:(CYRequestFailture)failture;

+ (void)POST:(NSString *)url params:(NSDictionary *)params success:(CYRequestSuccess)success failture:(CYRequestFailture)failture;

@end
