//
//  CYPublishView.m
//  CYBudejie
//
//  Created by Cyrill on 2016/12/1.
//  Copyright © 2016年 Cyrill. All rights reserved.
//

#import "CYPublishView.h"
#import "CYVerticalButton.h"
#import <POP.h>

#define CYRootView [UIApplication sharedApplication].keyWindow.rootViewController.view

static CGFloat const CYAnimationDelay = 0.1;
static CGFloat const CYSpringFactor = 10;

@interface CYPublishView ()

@end

@implementation CYPublishView

+ (instancetype)publishView
{
    return [[[NSBundle mainBundle] loadNibNamed:NSStringFromClass(self) owner:nil options:nil] lastObject];
}

static UIWindow *window_;

+ (void)show
{
    // 创建窗口
    window_ = [[UIWindow alloc] init];
    window_.frame = [UIScreen mainScreen].bounds;
    window_.backgroundColor = [[UIColor whiteColor] colorWithAlphaComponent:0.8];
    window_.hidden = NO;
    
    CYPublishView *publishView = [CYPublishView publishView];
    publishView.frame  =window_.frame;
    [window_ addSubview:publishView];
}

- (void)awakeFromNib {
    [super awakeFromNib];
    
//    CYRootView.userInteractionEnabled = NO;
    // 让不能点击
    self.userInteractionEnabled = NO;
    
    // 数据
    NSArray *images = @[@"publish-video", @"publish-picture", @"publish-text", @"publish-audio", @"publish-review", @"publish-offline"];
    NSArray *titles = @[@"发视频", @"发图片", @"发段子", @"发声音", @"审帖", @"离线下载"];
    
    // 中间的6个按钮
    int maxCols = 3;
    CGFloat buttonW = 72;
    CGFloat buttonH = buttonW + 30;
    CGFloat buttonStartY = (kScreenH - 2 * buttonH) * 0.5;
    CGFloat buttonStartX = 20;
    CGFloat xMargin = (kScreenW - 2 * buttonStartX - maxCols * buttonW) / (maxCols - 1);
    
    for (int i = 0; i<images.count; i++) {
        CYVerticalButton *button = [[CYVerticalButton alloc] init];
        button.tag = i;
        [button addTarget:self action:@selector(buttonClick:) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:button];
        
        // 设置内容
        button.titleLabel.font = [UIFont systemFontOfSize:14];
        [button setTitle:titles[i] forState:UIControlStateNormal];
        [button setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        [button setImage:[UIImage imageNamed:images[i]] forState:UIControlStateNormal];
        
        // 计算X/Y
        int row = i / maxCols;
        int col = i % maxCols;
        CGFloat buttonX = buttonStartX + col * (xMargin + buttonW);
        CGFloat buttonEndY = buttonStartY + row * buttonH;
        CGFloat buttonBeginY = buttonEndY - kScreenH;
        
        // 按钮动画
        POPSpringAnimation *anim = [POPSpringAnimation animationWithPropertyNamed:kPOPViewFrame];
        anim.fromValue = [NSValue valueWithCGRect:CGRectMake(buttonX, buttonBeginY, buttonW, buttonH)];
        anim.toValue = [NSValue valueWithCGRect:CGRectMake(buttonX, buttonEndY, buttonW, buttonH)];
        anim.springBounciness = CYSpringFactor;
        anim.springSpeed = CYSpringFactor;
        anim.beginTime = CACurrentMediaTime() + CYAnimationDelay * i;
        [button pop_addAnimation:anim forKey:nil];
    }
    
    // 添加标语
    // initWithImage 这样是默认会设置frame的，为  （0,0,image.size）
    UIImageView *sloganView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"app_slogan"]];
//    UIImageView *sloganView = [[UIImageView alloc] initWithFrame:CGRectZero];
//    sloganView.image = [UIImage imageNamed:@"app_slogan"];
    sloganView.cy_y = kScreenH * 0.2 - kScreenH;
    [self addSubview:sloganView];
    
    // 标语动画
    POPSpringAnimation *anim = [POPSpringAnimation animationWithPropertyNamed:kPOPViewCenter];
    CGFloat centerX = kScreenW * 0.5;
    CGFloat centerEndY = kScreenH * 0.2;
    CGFloat centerBeginY = centerEndY - kScreenH;
    anim.fromValue = [NSValue valueWithCGPoint:CGPointMake(centerX, centerBeginY)];
    anim.toValue = [NSValue valueWithCGPoint:CGPointMake(centerX, centerEndY)];
    anim.beginTime = CACurrentMediaTime() + images.count * CYAnimationDelay;
    anim.springBounciness = CYSpringFactor;
    anim.springSpeed = CYSpringFactor;
    [anim setCompletionBlock:^(POPAnimation *animation, BOOL finished) {
        // 标语动画执行完毕, 恢复点击事件
        self.userInteractionEnabled = YES;
//        CYRootView.userInteractionEnabled = YES;
        
    }];
    [sloganView pop_addAnimation:anim forKey:nil];

}

/**
 pop和Core Animation的区别
 1.Core Animation的动画只能添加到layer上
 2.pop的动画能添加到任何对象
 3.pop的底层并非基于Core Animation, 是基于CADisplayLink
 4.Core Animation的动画仅仅是表象, 并不会真正修改对象的frame\size等值
 5.pop的动画实时修改对象的属性, 真正地修改了对象的属性
 
 
 */

/**
 * 先执行退出动画, 动画完毕后执行completionBlock
 */
- (void)cancelWithCompletionBlock:(void (^)())completionBlock
{
    /*
     POPBasicAnimation  // 基本动画
     POPSpringAnimation // 弹簧动画
     POPDecayAnimation  // 衰减动画
     */
//    CYRootView.userInteractionEnabled = NO;
    // 让控制器的view不能被点击
    self.userInteractionEnabled = NO;
    
    int beginIndex = 1;
    
    for (int i = beginIndex; i<self.subviews.count; i++) {
        UIView *subview = self.subviews[i];
        
        POPBasicAnimation *anim = [POPBasicAnimation animationWithPropertyNamed:kPOPViewCenter];
        CGFloat centerY = subview.cy_centerY + kScreenH;
        // 动画的执行节奏(一开始很慢, 后面很快)
        anim.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseIn];
        anim.toValue = [NSValue valueWithCGPoint:CGPointMake(subview.cy_centerX, centerY)];
        anim.beginTime = CACurrentMediaTime() + (i - beginIndex) * CYAnimationDelay;
        [subview pop_addAnimation:anim forKey:nil];
        
        // 监听最后一个动画
        if (i == self.subviews.count - 1) {
            [anim setCompletionBlock:^(POPAnimation *anim, BOOL finished) {
                
//                CYRootView.userInteractionEnabled = YES;
                [self removeFromSuperview];
                
                // 销毁窗口
                window_ = nil;
                
                // 执行传进来的completionBlock参数
                !completionBlock ? : completionBlock();
            }];
        }
    }
}

- (void)buttonClick:(UIButton *)button
{
    [self cancelWithCompletionBlock:^{
        if (button.tag == 0) {
            CYLog(@"发视频");
        } else if (button.tag == 1) {
            CYLog(@"发图片");
        }
    }];
}

- (IBAction)cancel {
    [self cancelWithCompletionBlock:nil];
}

@end
