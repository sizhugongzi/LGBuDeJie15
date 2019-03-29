//
//  UIBarButtonItem+Item.m
//  LGBuDeJie
//
//  Created by 甘延娇 on 2019/3/13.
//  Copyright © 2019 itheima. All rights reserved.
//

#import "UIBarButtonItem+Item.h"

@implementation UIBarButtonItem (Item)

+ (instancetype)itemWithImage:(UIImage *)imageNormal highImage:(UIImage *)imageHighlighted target:(id)target action:(SEL)action
{
    UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
    [btn setImage:imageNormal forState:UIControlStateNormal];
    [btn setImage:imageHighlighted forState:UIControlStateHighlighted];
    [btn sizeToFit];
    [btn addTarget:target action:action forControlEvents:UIControlEventTouchUpInside];
    UIView *view = [[UIView alloc] initWithFrame:btn.bounds];
    [view addSubview:btn];
    return [[UIBarButtonItem alloc] initWithCustomView:view];
}

+ (instancetype)itemWithImage:(UIImage *)imageNormal imageSelected:(UIImage *)imageSelected target:(id)target action:(SEL)action
{
    UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
    [btn setImage:imageNormal forState:UIControlStateNormal];
    [btn setImage:imageSelected forState:UIControlStateSelected];
    [btn sizeToFit];
    [btn addTarget:target action:action forControlEvents:UIControlEventTouchUpInside];
    UIView *view = [[UIView alloc] initWithFrame:btn.bounds];
    [view addSubview:btn];
    return [[UIBarButtonItem alloc] initWithCustomView:view];
}

@end
