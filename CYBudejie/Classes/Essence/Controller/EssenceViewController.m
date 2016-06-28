//
//  EssenceViewController.m
//  CYBudejie
//
//  Created by Cyrill on 16/5/1.
//  Copyright © 2016年 Cyrill. All rights reserved.
//

#import "EssenceViewController.h"
#import "TitleButton.h"
#import "TopicsViewController.h"

@interface EssenceViewController () <UIScrollViewDelegate>

@property (weak, nonatomic) UIScrollView *contentView;
@property (weak, nonatomic) UIView       *titlesView;
@property (weak, nonatomic) TitleButton  *selectedButton;
@property (weak, nonatomic) UIView       *sliderView;
@property (strong, nonatomic) MASConstraint *sliderViewCenterX;

@end

@implementation EssenceViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self setupChildViewControllers];
    
    [self setupNavBar];
    
    [self setupContentView];
    
    [self setupTitlesView];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)setupContentView
{
    UIScrollView *contentView = [[UIScrollView alloc] init];
    contentView.backgroundColor = CYGlobalColor;
    contentView.frame = self.view.bounds;
    contentView.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
    contentView.delegate = self;
    contentView.showsHorizontalScrollIndicator = NO;
    contentView.showsVerticalScrollIndicator = NO;
    contentView.pagingEnabled = YES;
    contentView.contentSize = CGSizeMake(contentView.cy_width * self.childViewControllers.count, 0);
    [self.view addSubview:contentView];
    self.contentView = contentView;
}

- (void)setupNavBar
{
    self.automaticallyAdjustsScrollViewInsets = NO;
    self.navigationItem.titleView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"MainTitle"]];
    self.navigationItem.leftBarButtonItem = [UIBarButtonItem itemWithImage:@"MainTagSubIcon" highImage:@"MainTagSubIconClick" target:self action:@selector(tagSub)];
}

- (void)tagSub
{
    
}

- (void)setupTitlesView
{
    UIView *titlesView = [[UIView alloc] init];
    titlesView.backgroundColor = [UIColor colorWithRed:1.0 green:1.0 blue:1.0 alpha:0.9];
    titlesView.autoresizingMask = UIViewAutoresizingFlexibleWidth;
    titlesView.frame = CGRectMake(0, 64, self.view.frame.size.width, 40);
    [self.view addSubview:titlesView];
    self.titlesView = titlesView;
    
    TitleButton *button = [self setupTitleButton:@"全部"];
    [self setupTitleButton:@"视频"];
    [self setupTitleButton:@"声音"];
    [self setupTitleButton:@"图片"];
    [self setupTitleButton:@"段子"];
    [self titleClick:button];
    [self switchController:0];
    
    // 底部滑条
    UIView *sliderView = [[UIView alloc] init];
    sliderView.backgroundColor = [UIColor redColor];
    [self.titlesView addSubview:sliderView];
    self.sliderView = sliderView;
    
    [sliderView makeConstraints:^(MASConstraintMaker *make) {
        make.size.equalTo(CGSizeMake([[button titleForState:UIControlStateNormal] sizeWithAttributes:@{NSFontAttributeName : button.titleLabel.font}].width, 3));
        make.bottom.equalTo(self.titlesView);
        self.sliderViewCenterX = make.centerX.equalTo(button);
    }];
}

- (void)setupChildViewControllers
{
    [self setupOneChildViewController:CYTopicsTypeAll];
    [self setupOneChildViewController:CYTopicsTypeVideo];
    [self setupOneChildViewController:CYTopicsTypeVoice];
    [self setupOneChildViewController:CYTopicsTypePicture];
    [self setupOneChildViewController:CYTopicsTypeWord];
}

- (void)setupOneChildViewController:(CYTopicsType)type
{
    TopicsViewController *vc = [[TopicsViewController alloc] init];
    vc.type = type;
    [self addChildViewController:vc];
}

- (TitleButton *)setupTitleButton:(NSString *)title
{
    TitleButton *button = [TitleButton buttonWithType:UIButtonTypeCustom];
    [button setTitle:title forState:UIControlStateNormal];
    [button addTarget:self action:@selector(titleClick:) forControlEvents:UIControlEventTouchUpInside];
    [self.titlesView addSubview:button];
    
    [button makeConstraints:^(MASConstraintMaker *make) {
        make.width.equalTo(self.titlesView).multipliedBy(0.2);
        make.top.bottom.equalTo(self.titlesView);
        NSUInteger index = self.titlesView.subviews.count - 1;
        if (index == 0) {
            make.left.equalTo(self.titlesView);
        } else {
            make.left.equalTo([self.titlesView.subviews[index - 1] right]);
        }
    }];
    
    return button;
}

- (void)titleClick:(TitleButton *)button
{
    self.selectedButton.enabled = YES;
    button.enabled = NO;
    self.selectedButton = button;
    
    // 消除约束
    [self.sliderViewCenterX uninstall];
    self.sliderViewCenterX = nil;
    
    // 添加约束
    [self.sliderView makeConstraints:^(MASConstraintMaker *make) {
        self.sliderViewCenterX = make.centerX.equalTo(button);
    }];
    [UIView animateWithDuration:0.25 animations:^{
        [self.sliderView layoutIfNeeded];
    }];
    
    int index = (int)[self.titlesView.subviews indexOfObject:button];
    [self.contentView setContentOffset:CGPointMake(index * self.contentView.frame.size.width, self.contentView.contentOffset.y) animated:YES];
    
}

- (void)switchController:(int)index
{
    TopicsViewController *vc = self.childViewControllers[index];
    vc.view.cy_y = 0;
    vc.view.cy_width = self.contentView.cy_width;
    vc.view.cy_height = self.contentView.cy_height;
    vc.view.cy_x = vc.view.cy_width * index;
    [self.contentView addSubview:vc.view];
}

#pragma mark - <UIScrollViewDelegate>
- (void)scrollViewDidEndDecelerating:(nonnull UIScrollView *)scrollView
{
    int index = scrollView.contentOffset.x / scrollView.frame.size.width;
    [self titleClick:self.titlesView.subviews[index]];
    [self switchController:index];
}

- (void)scrollViewDidEndScrollingAnimation:(nonnull UIScrollView *)scrollView
{
    [self switchController:(int)(scrollView.contentOffset.x / scrollView.frame.size.width)];
}

@end
