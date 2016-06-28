//
//  VideoView.m
//  CYBudejie
//
//  Created by Cyrill on 16/6/28.
//  Copyright © 2016年 Cyrill. All rights reserved.
//

#import "VideoView.h"
#import "Topic.h"

@implementation VideoView

+ (instancetype)videoView
{
    return [[[NSBundle mainBundle] loadNibNamed:NSStringFromClass(self) owner:nil options:nil] lastObject];
}

- (void)setTopic:(Topic *)topic
{
    [super setTopic:topic];
    
    self.lengthLabel.text = [NSString stringWithFormat:@"%02d:%02d", topic.videotime / 60, topic.videotime %60];
    
    if (topic.bigImage) {
        self.imageView.contentMode = UIViewContentModeScaleAspectFit;
    } else {
        self.imageView.contentMode = UIViewContentModeScaleToFill;
    }
}

@end
