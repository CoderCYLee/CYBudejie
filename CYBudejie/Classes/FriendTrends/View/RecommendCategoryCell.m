//
//  RecommendCategoryCell.m
//  CYBudejie
//
//  Created by Cyrill on 16/5/7.
//  Copyright © 2016年 Cyrill. All rights reserved.
//

#import "RecommendCategoryCell.h"
#import "RecommendCategory.h"

@interface RecommendCategoryCell ()
/** 选中时显示的指示器控件 */
@property (weak, nonatomic) IBOutlet UIView *selectedIndicator;
@end

@implementation RecommendCategoryCell

- (void)awakeFromNib {
    [super awakeFromNib];
    
    self.backgroundColor = CYColor(244, 244, 244);
    self.selectedIndicator.backgroundColor = CYColor(219, 21, 26);
    
}

- (void)layoutSubviews
{
    [super layoutSubviews];
    
    // 重新调整内部textLabel的frame
    self.textLabel.cy_y = 2;
    self.textLabel.cy_height = self.contentView.cy_height - 2 * self.textLabel.cy_y;
}

/**
 * 可以在这个方法中监听cell的选中和取消选中
 */
- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
    
    self.selectedIndicator.hidden = !selected;
    self.textLabel.textColor = selected ? self.selectedIndicator.backgroundColor : CYColor(78, 78, 78);
}

- (void)setCategory:(RecommendCategory *)category
{
    _category = category;
    
    self.textLabel.text = category.name;
}

@end
