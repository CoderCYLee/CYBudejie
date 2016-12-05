//
//  CYCommentHeaderView.m
//  CYBudejie
//
//  Created by Cyrill on 2016/12/5.
//  Copyright © 2016年 Cyrill. All rights reserved.
//

#import "CYCommentHeaderView.h"

@interface CYCommentHeaderView ()

/** 文字标签 */
@property (nonatomic, weak) UILabel *label;

@end

@implementation CYCommentHeaderView

+ (instancetype)headerViewWithTableView:(UITableView *)tableView
{
    static NSString *ID = @"header";
    CYCommentHeaderView *header = [tableView dequeueReusableHeaderFooterViewWithIdentifier:ID];
    if (header == nil) { // 缓存池中没有, 自己创建
        header = [[CYCommentHeaderView alloc] initWithReuseIdentifier:ID];
    }
    return header;
}

- (instancetype)initWithReuseIdentifier:(NSString *)reuseIdentifier
{
    if (self = [super initWithReuseIdentifier:reuseIdentifier]) {
        self.contentView.backgroundColor = CYGlobalColor;
        
        // 创建label
        UILabel *label = [[UILabel alloc] init];
        label.cy_width = 200;
        label.cy_x = 10;
        label.autoresizingMask = UIViewAutoresizingFlexibleHeight;
        [self.contentView addSubview:label];
        self.label = label;
    }
    return self;
}

- (void)setTitle:(NSString *)title
{
    _title = [title copy];
    
    self.label.text = title;
}

@end
