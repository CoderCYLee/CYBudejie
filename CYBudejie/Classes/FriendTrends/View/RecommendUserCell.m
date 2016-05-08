//
//  RecommendUserCell.m
//  CYBudejie
//
//  Created by Cyrill on 16/5/7.
//  Copyright © 2016年 Cyrill. All rights reserved.
//

#import "RecommendUserCell.h"

#import "RecommendUser.h"
#import <UIImageView+WebCache.h>


@interface RecommendUserCell()
@property (weak, nonatomic) IBOutlet UIImageView *headerImageView;
@property (weak, nonatomic) IBOutlet UILabel *screenNameLabel;
@property (weak, nonatomic) IBOutlet UILabel *fansCountLabel;
@end

@implementation RecommendUserCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (void)setUser:(RecommendUser *)user
{
    _user = user;
    
    self.screenNameLabel.text = user.screen_name;
    
    NSString *fansCount = nil;
    if (user.fans_count < 10000) {
        fansCount = [NSString stringWithFormat:@"%zd人关注", user.fans_count];
    } else { // 大于等于10000
        fansCount = [NSString stringWithFormat:@"%.1f万人关注", user.fans_count / 10000.0];
    }
    self.fansCountLabel.text = fansCount;
    
    UIImage *im = [UIImage imageNamed:@"defaultUserIcon"];
    UIImage *placeholder = [self circleImage:im];
    [self.headerImageView sd_setImageWithURL:[NSURL URLWithString:user.header] placeholderImage:placeholder completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, NSURL *imageURL) {
        self.headerImageView.image = image ? [self circleImage:image] : placeholder;
    }];
}

- (UIImage *)circleImage:(UIImage *)img
{
    // NO代表透明
    UIGraphicsBeginImageContextWithOptions(img.size, NO, 0.0);
    
    // 获得上下文
    CGContextRef ctx = UIGraphicsGetCurrentContext();
    
    // 添加一个圆
    CGRect rect = CGRectMake(0, 0, img.size.width, img.size.height);
    CGContextAddEllipseInRect(ctx, rect);
    
    // 裁剪
    CGContextClip(ctx);
    
    // 将图片画上去
    [img drawInRect:rect];
    
    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    
    UIGraphicsEndImageContext();
    
    return image;
}
@end
