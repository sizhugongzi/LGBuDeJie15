//
//  LGBackView.m
//  LGBuDeJie
//
//  Created by 甘延娇 on 2019/3/13.
//  Copyright © 2019 itheima. All rights reserved.
//

#import "LGBackView.h"
#import "UIView+Frame.h"

@implementation LGBackView

+ (instancetype)backViewWithImage:(UIImage *)imageNormal highImage:(UIImage *)imageHighlighted target:(id)target action: (SEL)action title:(NSString *)title
{
    UIButton *backButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [backButton setTitle:title forState:UIControlStateNormal];
    [backButton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [backButton setTitleColor:[UIColor redColor] forState:UIControlStateHighlighted];
    [backButton setImage:imageNormal forState:UIControlStateNormal];
    [backButton setImage:imageHighlighted forState:UIControlStateHighlighted];
    backButton.xmg_x -= 20;
    [backButton sizeToFit];
    [backButton addTarget:target action:action forControlEvents:UIControlEventTouchUpInside];
    LGBackView *view = [[LGBackView alloc] initWithFrame:backButton.bounds];
    [view addSubview:backButton];
    return view;
}

@end
