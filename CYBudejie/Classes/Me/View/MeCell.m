//
//  MeCell.m
//  CYBudejie
//
//  Created by Cyrill on 16/6/29.
//  Copyright © 2016年 Cyrill. All rights reserved.
//

#import "MeCell.h"

@implementation MeCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        self.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
        
        UIImageView *bgView = [[UIImageView alloc] init];
        bgView.image = [UIImage imageNamed:@"mainCellBackground"];
        self.backgroundView = bgView;
        
        self.textLabel.textColor = [UIColor darkGrayColor];
        self.textLabel.font = [UIFont systemFontOfSize:16];
    }
    return self;
}

- (void)layoutSubviews
{
    [super layoutSubviews];
    
    if (self.imageView.image == nil) return;
    
    self.imageView.cy_width = 30;
    self.imageView.cy_height = self.imageView.cy_width;
    self.imageView.cy_centerY = self.contentView.cy_height * 0.5;
    
    self.textLabel.cy_x = CGRectGetMaxX(self.imageView.frame) + 10;
}
@end
