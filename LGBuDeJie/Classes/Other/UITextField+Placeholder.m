//
//  UITextField+Placeholder.m
//  LGBuDeJie
//
//  Created by 甘延娇 on 2019/3/22.
//  Copyright © 2019 itheima. All rights reserved.
//

#import "UITextField+Placeholder.h"

@implementation UITextField (Placeholder)

//设置占位文字颜色
- (void)setPlaceholderColor:(UIColor *)placeholderColor
{
    //快速去设置 占位文字颜色
    UILabel *placeholderLabel = [self valueForKeyPath:@"placeholderLabel"];
    placeholderLabel.textColor = placeholderColor;
}

- (UIColor *)placeholderColor
{
    UILabel *placeholderLabel = [self valueForKeyPath:@"placeholderLabel"];
    return placeholderLabel.textColor;
}

@end
