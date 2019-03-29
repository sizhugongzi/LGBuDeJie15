//
//  UIBarButtonItem+Item.h
//  LGBuDeJie
//
//  Created by 甘延娇 on 2019/3/13.
//  Copyright © 2019 itheima. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface UIBarButtonItem (Item)

+ (instancetype)itemWithImage:(UIImage *)imageNormal highImage:(UIImage *)imageHighlighted target:(id)target action:(SEL)action;

+ (instancetype)itemWithImage:(UIImage *)imageNormal imageSelected:(UIImage *)imageSelected target:(id)target action:(SEL)action;

@end

NS_ASSUME_NONNULL_END
