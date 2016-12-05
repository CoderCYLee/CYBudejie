//
//  Topic.h
//  CYBudejie
//
//  Created by Cyrill on 16/6/28.
//  Copyright © 2016年 Cyrill. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Topic : NSObject

@property (copy, nonatomic) NSString *id;
/** 发帖人的昵称 */
@property (copy, nonatomic) NSString *name;
/** 系统审核通过后创建帖子的时间 */
@property (copy, nonatomic) NSString *created_at;
/** 帖子的内容 */
@property (copy, nonatomic) NSString *text;
/** 帖子的类型 */
@property (assign, nonatomic) CYTopicsType type;
/** 头像的图片url地址 */
@property (copy, nonatomic) NSString *profile_image;
/** 踩的人数 */
@property (assign, nonatomic) int hate;
/** 帖子的被评论数量 */
@property (assign, nonatomic) int comment;
/** 转发的数量 */
@property (assign, nonatomic) int repost;
/** 顶的数量 */
@property (assign, nonatomic) int love;
/** 主题 */
@property (strong, nonatomic) NSArray *themes;
/** 是否为新浪会员 */
@property (assign, nonatomic, getter=isSina_v) BOOL sina_v;
/** 最热评论(期望这个数组中存放的是CYComment模型) */
@property (nonatomic, strong) NSArray *top_cmt;


/****** 图片相关 ******/
/** 配图 */
@property (copy, nonatomic) NSString *image2;
/** 是否为gif图片 */
@property (assign, nonatomic) BOOL is_gif;
/** 视频或图片类型帖子的宽度 */
@property (assign, nonatomic) CGFloat width;
/** 视频或图片类型帖子的高度 */
@property (assign, nonatomic) CGFloat height;


/** 小图片的URL */
@property (nonatomic, copy) NSString *small_image;
/** 中图片的URL */
@property (nonatomic, copy) NSString *middle_image;
/** 大图片的URL */
@property (nonatomic, copy) NSString *large_image;

/****** 音频相关 ******/
/** 音频的时长 */
@property (assign, nonatomic) int voicetime;
/** 播放次数 */
@property (assign, nonatomic) int playcount;
/** 音频的播放地址 */
@property (copy, nonatomic) NSString *voiceuri;

/****** 视频相关 ******/
/** 视频的播放地址 */
@property (copy, nonatomic) NSString *videouri;
/** 视频的时长 */
@property (assign, nonatomic) int videotime;

/****** 额外添加的属性 ******/
@property (assign, nonatomic, getter=isBigImage) BOOL bigImage;

@end
