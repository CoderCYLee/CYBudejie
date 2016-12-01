//
//  ContentView.m
//  CYBudejie
//
//  Created by Cyrill on 16/6/28.
//  Copyright © 2016年 Cyrill. All rights reserved.
//

#import "ContentView.h"

@implementation ContentView

- (void)awakeFromNib
{
    [super awakeFromNib];
    // 如果出现尺寸发生问题，可能是因为这个属性导致的
    self.autoresizingMask = UIViewAutoresizingNone;
    self.clipsToBounds = YES;
}

@end
