//
//  RecommendCategoryCell.h
//  CYBudejie
//
//  Created by Cyrill on 16/5/7.
//  Copyright © 2016年 Cyrill. All rights reserved.
//

#import <UIKit/UIKit.h>
@class RecommendCategory;

@interface RecommendCategoryCell : UITableViewCell
/** 类别模型 */
@property (nonatomic, strong) RecommendCategory *category;
@end
