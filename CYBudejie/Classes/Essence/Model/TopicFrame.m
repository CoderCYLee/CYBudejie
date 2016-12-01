//
//  TopicFrame.m
//  CYBudejie
//
//  Created by Cyrill on 16/6/28.
//  Copyright © 2016年 Cyrill. All rights reserved.
//

#import "TopicFrame.h"
#import "Topic.h"

@interface TopicFrame ()


@end

@implementation TopicFrame {
    CGFloat _cellHeight;
}

- (void)setTopic:(Topic *)topic
{
    _topic = topic;
}

- (CGFloat)cellHeight
{
    if (!_cellHeight) {
        
        // 文字相关
        CGFloat textX = 10;
        CGFloat textY = 50;
        CGFloat textW = [UIScreen mainScreen].bounds.size.width - 2 * textX - 2 * CYCellMargin;
        CGFloat textH = [self.topic.text boundingRectWithSize:CGSizeMake(textW, MAXFLOAT) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName : [UIFont systemFontOfSize:16]} context:nil].size.height;
        
        // 最大的Y值
        CGFloat maxY = textY + textH + 10;
        
        // 中间的内容
        if (self.topic.type != CYTopicsTypeWord) {
            CGFloat contentX = textX;
            CGFloat contentY = maxY;
            CGFloat contentW = textW;
            CGFloat widthScale = self.topic.width / contentW;
            CGFloat contentH = self.topic.height / widthScale;
            if (self.topic.type == CYTopicsTypeVideo && contentH > 250) {
                contentH = 250;
                self.topic.bigImage = YES;
            }
            
            if (contentH > 2000) {
                contentH = 300;
                self.topic.bigImage = YES;
            }
            self.contentFrame = CGRectMake(contentX, contentY, contentW, contentH);
            maxY = contentY + contentH + 10;
        }
        
        // cell的高度
        _cellHeight = maxY + 40;
        
    }
    return _cellHeight;
}

- (BOOL)isEqual:(TopicFrame *)object
{
    return [self.topic.id isEqualToString:object.topic.id];
}

@end
