//
//  LGLoginTextField.m
//  LGBuDeJie
//
//  Created by 甘延娇 on 2019/3/22.
//  Copyright © 2019 itheima. All rights reserved.
//

#import "LGLoginTextField.h"
#import "UITextField+Placeholder.h"

@implementation LGLoginTextField

//当文本框开始编辑的时候，必须要成为第一响应者
//作用：成为第一响应者
- (BOOL)becomeFirstResponder
{
    //快速去设置 占位文字颜色
    self.placeholderColor = [UIColor redColor];
    return [super becomeFirstResponder];
}

//当文本框结束编辑的时候，注销掉第一响应者
- (BOOL)resignFirstResponder
{
    //快速去设置 占位文字颜色
    self.placeholderColor = [UIColor whiteColor];
    return [super resignFirstResponder];
}

- (void)awakeFromNib
{
    [super awakeFromNib];
    
    self.tintColor = [UIColor whiteColor];
    self.placeholderColor = [UIColor whiteColor];
}

@end
