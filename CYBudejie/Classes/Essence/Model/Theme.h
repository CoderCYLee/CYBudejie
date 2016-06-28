//
//  Theme.h
//  CYBudejie
//
//  Created by Cyrill on 16/6/28.
//  Copyright © 2016年 Cyrill. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Theme : NSObject

/**	标签的id,如：微视频的id为55 */
@property (copy, nonatomic) NSString *theme_id;
/**	帖子的所属分类的标签名字 */
@property (copy, nonatomic) NSString *theme_name;
/**	 */
@property (assign, nonatomic) int theme_type;

@end
