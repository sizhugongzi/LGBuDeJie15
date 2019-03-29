//
//  LGBackView.h
//  LGBuDeJie
//
//  Created by 甘延娇 on 2019/3/13.
//  Copyright © 2019 itheima. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface LGBackView : UIView

+ (instancetype)backViewWithImage:(UIImage *)imageNormal highImage:(UIImage *)imageHighlighted target:(id)target action: (SEL)action title:(NSString *)title;

@end

NS_ASSUME_NONNULL_END
