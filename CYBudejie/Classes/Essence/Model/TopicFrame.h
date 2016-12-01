//
//  TopicFrame.h
//  CYBudejie
//
//  Created by Cyrill on 16/6/28.
//  Copyright © 2016年 Cyrill. All rights reserved.
//

#import <Foundation/Foundation.h>
@class Topic;

@interface TopicFrame : NSObject

@property (nonatomic, strong) Topic *topic;

@property (nonatomic, readonly, assign) CGFloat cellHeight;

@property (nonatomic, assign) CGRect contentFrame;

@end
