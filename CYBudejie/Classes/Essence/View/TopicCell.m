//
//  TopicCell.m
//  CYBudejie
//
//  Created by Cyrill on 16/6/28.
//  Copyright © 2016年 Cyrill. All rights reserved.
//

#import "TopicCell.h"
#import "Topic.h"
#import "TopicFrame.h"
#import "CYUser.h"
#import "CYComment.h"

#import "VideoView.h"
#import "VoiceView.h"
#import "PictureView.h"

@interface TopicCell()

/** 头像 */
@property (weak, nonatomic) IBOutlet UIImageView *iconView;
/** 昵称 */
@property (weak, nonatomic) IBOutlet UILabel *nameLabel;
/** 时间 */
@property (weak, nonatomic) IBOutlet UILabel *createdAtLabel;
/** 文字 */
@property (weak, nonatomic) IBOutlet UILabel *text_label;
/** 最热评论的内容 */
@property (weak, nonatomic) IBOutlet UILabel *topCmtContentLabel;
/** 最热评论的整体 */
@property (weak, nonatomic) IBOutlet UIView *topCmtView;
/** “踩”按钮 */
@property (weak, nonatomic) IBOutlet UIButton *caiButton;
/** “分享”按钮 */
@property (weak, nonatomic) IBOutlet UIButton *shareButton;
/** “评论”按钮 */
@property (weak, nonatomic) IBOutlet UIButton *commentButton;
/** “顶”按钮 */
@property (weak, nonatomic) IBOutlet UIButton *dingButton;
/** 是否位新浪会员 */
@property (weak, nonatomic) IBOutlet UIImageView *vipView;

/** 视频内容 */
@property (weak, nonatomic) VideoView *videoView;
/** 音频内容 */
@property (weak, nonatomic) VoiceView *voiceView;
/** 图片内容 */
@property (weak, nonatomic) PictureView *pictureView;

@end

@implementation TopicCell

+ (instancetype)cell
{
    return [[[NSBundle mainBundle] loadNibNamed:NSStringFromClass(self) owner:nil options:nil] firstObject];
}


- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)drawRect:(CGRect)rect
{
    [[UIImage imageNamed:@"mainCellBackground"] drawInRect:rect];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (void)setupButton:(UIButton *)button count:(int)count placeholder:(NSString *)placeholder
{
    if (count > 10000) {
        placeholder = [NSString stringWithFormat:@"%.1f", count / 10000.0];
        placeholder = [placeholder stringByReplacingOccurrencesOfString:@".0" withString:@""];
    } else if (count != 0) {
        placeholder = [NSString stringWithFormat:@"%d", count];
    }
    [button setTitle:placeholder forState:UIControlStateNormal];
}


#pragma mark - public methods
+ (instancetype)cellWithTableView:(UITableView *)tableView
{
    static NSString *ID = @"topic";
    TopicCell *cell = [tableView dequeueReusableCellWithIdentifier:ID];
    if (cell == nil) {
        cell = [[[NSBundle mainBundle] loadNibNamed:NSStringFromClass(self) owner:nil options:nil] lastObject];
    }
    return cell;
}

- (void)setFrame:(CGRect)frame
{
    frame.origin.x = CYCellMargin;
    frame.origin.y += CYCellMargin;
    frame.size.width -= 2 * CYCellMargin;
    frame.size.height -= CYCellMargin;
    [super setFrame:frame];
}

- (void)setTopicFrame:(TopicFrame *)topicFrame
{
    _topicFrame = topicFrame;
    
    Topic *topic = topicFrame.topic;
    // 顶部中间
    [self.iconView sd_setImageWithURL:[NSURL URLWithString:topic.profile_image] placeholderImage:[UIImage imageNamed:@"defaultUserIcon"]];
    self.nameLabel.text = topic.name;
    self.createdAtLabel.text = topic.created_at;
    self.text_label.text = topic.text;
    self.vipView.hidden = !topic.isSina_v;
    
    // 底部按钮
    [self setupButton:self.dingButton count:topic.love placeholder:@"顶"];
    [self setupButton:self.caiButton count:topic.hate placeholder:@"踩"];
    [self setupButton:self.shareButton count:topic.repost placeholder:@"分享"];
    [self setupButton:self.commentButton count:topic.comment placeholder:@"评论"];
    
    // 中间内容
    ContentView *contentView = nil;
    if (topic.type == CYTopicsTypePicture) {
        contentView = self.pictureView;
        self.voiceView.hidden = YES;
        self.videoView.hidden = YES;
    } else if (topic.type == CYTopicsTypeVideo) {
        contentView = self.videoView;
        self.pictureView.hidden = YES;
        self.voiceView.hidden = YES;
    } else if (topic.type == CYTopicsTypeVoice) {
        contentView = self.voiceView;
        self.pictureView.hidden = YES;
        self.videoView.hidden = YES;
    } else {
        self.pictureView.hidden = YES;
        self.videoView.hidden = YES;
        self.voiceView.hidden = YES;
    }
    
    // 处理热门评论
    CYComment *cmt = [topic.top_cmt firstObject];
    if (cmt) {
        self.topCmtView.hidden = NO;
        self.topCmtContentLabel.text = [NSString stringWithFormat:@"%@ : %@", cmt.user.username, cmt.content];
    } else {
        self.topCmtView.hidden = YES;
    }
    
    contentView.hidden = NO;
    contentView.frame = topicFrame.contentFrame;
    contentView.topic = topic;
}

- (VideoView *)videoView
{
    if (!_videoView) {
        [self.contentView addSubview:_videoView = [VideoView videoView]];
    }
    return _videoView;
}

- (VoiceView *)voiceView
{
    if (!_voiceView) {
        [self.contentView addSubview:_voiceView = [VoiceView voiceView]];
    }
    return _voiceView;
}

- (PictureView *)pictureView
{
    if (!_pictureView) {
        [self.contentView addSubview:_pictureView = [PictureView pictureView]];
    }
    return _pictureView;
}

@end
