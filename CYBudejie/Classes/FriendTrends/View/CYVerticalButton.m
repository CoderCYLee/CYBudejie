//
//  CYVerticalButton.m
//  CYBudejie
//
//  Created by Cyrill on 16/6/29.
//  Copyright © 2016年 Cyrill. All rights reserved.
//

#import "CYVerticalButton.h"

@implementation CYVerticalButton

- (instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        [self setup];
    }
    return self;
}

- (void)awakeFromNib
{
    [self setup];
}

- (void)layoutSubviews
{
    [super layoutSubviews];
    
    // 调整图片
    self.imageView.cy_x = 0;
    self.imageView.cy_y = 0;
    self.imageView.cy_width = self.cy_width;
    self.imageView.cy_height = self.imageView.cy_width;
    
    // 调整文字
    self.titleLabel.cy_x = 0;
    self.titleLabel.cy_y = self.imageView.cy_height;
    self.titleLabel.cy_width = self.cy_width;
    self.titleLabel.cy_height = self.cy_height - self.titleLabel.cy_y;
}

- (void)setup
{
    self.titleLabel.textAlignment = NSTextAlignmentCenter;
}

@end
