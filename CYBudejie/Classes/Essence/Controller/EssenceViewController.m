//
//  EssenceViewController.m
//  CYBudejie
//
//  Created by Cyrill on 16/5/1.
//  Copyright © 2016年 Cyrill. All rights reserved.
//

#import "EssenceViewController.h"

@interface EssenceViewController () <UIScrollViewDelegate>

@property (weak, nonatomic) UIScrollView *contentView;
@property (weak, nonatomic) UIView       *titlesView;

@end

@implementation EssenceViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    
    [self setupContentView];
    
//    [self setupTitlesView];
    
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


@end
