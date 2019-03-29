//
//  UIImage+Render.m
//  LGBuDeJie
//
//  Created by 甘延娇 on 2019/3/13.
//  Copyright © 2019 itheima. All rights reserved.
//

#import "UIImage+Render.h"

@implementation UIImage (Render)

+ (UIImage *)imageNamedWithOriginal:(NSString *)name
{
    UIImage *selImage = [UIImage imageNamed:name];
    [selImage imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    return selImage;
}

@end
