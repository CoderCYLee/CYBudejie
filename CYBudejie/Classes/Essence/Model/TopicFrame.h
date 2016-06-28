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

@property (strong, nonatomic) Topic *topic;

@property (assign, nonatomic) CGFloat cellHeight;

@property (assign, nonatomic) CGRect contentFrame;

@end
