//
//  VoiceView.m
//  CYBudejie
//
//  Created by Cyrill on 16/6/28.
//  Copyright © 2016年 Cyrill. All rights reserved.
//

#import "VoiceView.h"
#import "Topic.h"

@implementation VoiceView

+ (instancetype)voiceView
{
    return [[[NSBundle mainBundle] loadNibNamed:NSStringFromClass(self) owner:nil options:nil] lastObject];
}

- (void)setTopic:(Topic *)topic
{
    [super setTopic:topic];
    
    self.lengthLabel.text = [NSString stringWithFormat:@"%02d:%02d", topic.voicetime / 60, topic.voicetime %60];
}

@end
