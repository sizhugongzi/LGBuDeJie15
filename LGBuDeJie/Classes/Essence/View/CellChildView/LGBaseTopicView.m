//
//  LGBaseTopicView.m
//  LGBuDeJie
//
//  Created by 甘延娇 on 2019/3/15.
//  Copyright © 2019 itheima. All rights reserved.
//

#import "LGBaseTopicView.h"

@implementation LGBaseTopicView

+ (instancetype)viewForNib
{
    return [[[NSBundle mainBundle] loadNibNamed:NSStringFromClass(self) owner:nil options:nil] firstObject];
}

@end
