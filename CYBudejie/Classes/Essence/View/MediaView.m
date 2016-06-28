//
//  MediaView.m
//  CYBudejie
//
//  Created by Cyrill on 16/6/28.
//  Copyright © 2016年 Cyrill. All rights reserved.
//

#import "MediaView.h"
#import "Topic.h"

@interface MediaView()

@property (weak, nonatomic) IBOutlet UILabel *playCountLabel;

@end

@implementation MediaView

- (void)setTopic:(Topic *)topic
{
    [super setTopic:topic];
    
    self.playCountLabel.text = [NSString stringWithFormat:@"%d播放", topic.playcount];
    [self.imageView sd_setImageWithURL:[NSURL URLWithString:topic.image2]];
}

@end
