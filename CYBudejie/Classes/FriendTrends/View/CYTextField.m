//
//  CYTextField.m
//  CYBudejie
//
//  Created by Cyrill on 16/6/29.
//  Copyright © 2016年 Cyrill. All rights reserved.
//

#import "CYTextField.h"

static NSString * const CYPlacerholderColorKeyPath = @"_placeholderLabel.textColor";

@implementation CYTextField

- (void)awakeFromNib
{
    // 设置光标颜色和文字颜色一致
    self.tintColor = self.textColor;
    
    // 不成为第一响应者
    [self resignFirstResponder];
}

/**
 * 当前文本框聚焦时就会调用
 */
- (BOOL)becomeFirstResponder
{
    // 修改占位文字颜色
    [self setValue:self.textColor forKeyPath:CYPlacerholderColorKeyPath];
    return [super becomeFirstResponder];
}

/**
 * 当前文本框失去焦点时就会调用
 */
- (BOOL)resignFirstResponder
{
    // 修改占位文字颜色
    [self setValue:[UIColor grayColor] forKeyPath:CYPlacerholderColorKeyPath];
    return [super resignFirstResponder];
}

/**
 运行时(Runtime):
 * 苹果官方一套C语言库
 * 能做很多底层操作(比如访问隐藏的一些成员变量\成员方法....)
 */

@end
