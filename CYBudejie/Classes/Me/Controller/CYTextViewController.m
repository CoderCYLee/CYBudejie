//
//  CYTextViewController.m
//  CYBudejie
//
//  Created by Cyrill on 2016/12/8.
//  Copyright © 2016年 Cyrill. All rights reserved.
//

#import "CYTextViewController.h"

#ifdef __IPHONE_9_0
@interface CYTextViewController () <UIPreviewActionItem>
#else
@interface CYTextViewController ()
#endif

@property (nonatomic, copy) NSString * title1;
@property (weak, nonatomic) IBOutlet UILabel *lblText;

@end

@implementation CYTextViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    _lblText.text = self.title1;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - UIPreviewActionItem

#ifdef __IPHONE_9_0
-(NSArray<id<UIPreviewActionItem>> *)previewActionItems
{
    UIPreviewAction * act1 = [UIPreviewAction actionWithTitle:@"3D Touch" style:UIPreviewActionStyleDefault handler:^(UIPreviewAction * _Nonnull action, UIViewController * _Nonnull previewViewController) {
        
        //添加点击处理操作
        
    }];
    
    UIPreviewAction * act2 = [UIPreviewAction actionWithTitle:@"点个赞啊" style:UIPreviewActionStyleSelected handler:^(UIPreviewAction * _Nonnull action, UIViewController * _Nonnull previewViewController) {
        
    }];
    
    UIPreviewAction * act3 = [UIPreviewAction actionWithTitle:@"小心啊" style:UIPreviewActionStyleDestructive handler:^(UIPreviewAction * _Nonnull action, UIViewController * _Nonnull previewViewController) {
        
        
    }];
    
    return [NSArray arrayWithObjects:act1,act2,act3, nil];
}
#endif

@end
