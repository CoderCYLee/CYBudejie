//
//  CYCommentViewController.h
//  CYBudejie
//
//  Created by Cyrill on 2016/12/5.
//  Copyright © 2016年 Cyrill. All rights reserved.
//

#import <UIKit/UIKit.h>

@class TopicFrame;

@interface CYCommentViewController : UIViewController

/** 帖子模型 */
@property (nonatomic, strong) TopicFrame *topicFrame;

@end
