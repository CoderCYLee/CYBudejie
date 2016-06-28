//
//  PictureView.m
//  CYBudejie
//
//  Created by Cyrill on 16/6/28.
//  Copyright © 2016年 Cyrill. All rights reserved.
//

#import "PictureView.h"
#import "M13ProgressViewRing.h"
#import "Topic.h"
#import "ShowPictureViewController.h"

@interface PictureView()

@property (weak, nonatomic) IBOutlet M13ProgressViewRing *progressView;
@property (weak, nonatomic) IBOutlet UIImageView *gifView;
@property (weak, nonatomic) IBOutlet UIButton *seeBigButton;

@end

@implementation PictureView

+ (instancetype)pictureView
{
    return [[[NSBundle mainBundle] loadNibNamed:NSStringFromClass(self) owner:nil options:nil] lastObject];
}

- (void)awakeFromNib
{
    [super awakeFromNib];
    
    self.progressView.secondaryColor = [UIColor lightGrayColor];
    self.progressView.primaryColor = [UIColor colorWithRed:0.5 green:0.5 blue:0.5 alpha:0.5];
    
    
    // 给图片添加监听器
    self.imageView.userInteractionEnabled = YES;
    [self.imageView addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(showPicture)]];
}

- (void)showPicture
{
    ShowPictureViewController *showPicture = [[ShowPictureViewController alloc] init];
    showPicture.topic = self.topic;
    [[UIApplication sharedApplication].keyWindow.rootViewController presentViewController:showPicture animated:YES completion:nil];
}

- (void)setTopic:(Topic *)topic
{
    [super setTopic:topic];
    
    [self.imageView sd_setImageWithURL:[NSURL URLWithString:topic.image2] placeholderImage:nil options:0 progress:^(NSInteger receivedSize, NSInteger expectedSize) {
        self.progressView.hidden = NO;
        [self.progressView setProgress:1.0 * receivedSize / expectedSize animated:YES];
    } completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, NSURL *imageURL) {
        self.progressView.hidden = YES;
    }];
    self.gifView.hidden = ![topic.image2.pathExtension.lowercaseString isEqualToString:@"gif"];
    if (topic.isBigImage) {
        self.imageView.contentMode = UIViewContentModeTop;
        self.seeBigButton.hidden = NO;
    } else {
        self.imageView.contentMode = UIViewContentModeScaleToFill;
        self.seeBigButton.hidden = YES;
    }
}

@end
