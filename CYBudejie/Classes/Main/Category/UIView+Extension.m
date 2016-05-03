//
//  UIView+Extension.m
//  CYBudejie
//
//  Created by Cyrill on 16/5/1.
//  Copyright © 2016年 Cyrill. All rights reserved.
//

#import "UIView+Extension.h"

@implementation UIView (Extension)
- (void)setCy_x:(CGFloat)cy_x
{
    CGRect frame = self.frame;
    frame.origin.x = cy_x;
    self.frame = frame;
}

- (void)setCy_y:(CGFloat)cy_y
{
    CGRect frame = self.frame;
    frame.origin.y = cy_y;
    self.frame = frame;
}

- (void)setCy_width:(CGFloat)cy_width
{
    CGRect frame = self.frame;
    frame.size.width = cy_width;
    self.frame = frame;
}

- (void)setCy_height:(CGFloat)cy_height
{
    CGRect frame = self.frame;
    frame.size.height = cy_height;
    self.frame = frame;
}

- (CGFloat)cy_x
{
    return self.frame.origin.x;
}

- (CGFloat)cy_y
{
    return self.frame.origin.y;
}

- (CGFloat)cy_width
{
    return self.frame.size.width;
}

- (CGFloat)cy_height
{
    return self.frame.size.height;
}

- (void)setCy_centerX:(CGFloat)cy_centerX
{
    CGPoint center = self.center;
    center.x = cy_centerX;
    self.center = center;
}

- (void)setCy_centerY:(CGFloat)cy_centerY
{
    CGPoint center = self.center;
    center.y = cy_centerY;
    self.center = center;
}

- (CGFloat)cy_centerX
{
    return self.center.x;
}

- (CGFloat)cy_centerY
{
    return self.center.y;
}
@end
