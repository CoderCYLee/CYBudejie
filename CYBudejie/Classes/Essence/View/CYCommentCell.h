//
//  CYCommentCell.h
//  CYBudejie
//
//  Created by Cyrill on 2016/12/5.
//  Copyright © 2016年 Cyrill. All rights reserved.
//

#import <UIKit/UIKit.h>

@class CYComment;

@interface CYCommentCell : UITableViewCell
/** 评论 */
@property (nonatomic, strong) CYComment *comment;
@end
