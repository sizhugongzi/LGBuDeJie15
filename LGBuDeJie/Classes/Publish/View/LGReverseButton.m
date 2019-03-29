//
//  LGReverseButton.m
//  LGBuDeJie
//
//  Created by 甘延娇 on 2019/3/22.
//  Copyright © 2019 itheima. All rights reserved.
//

#import "LGReverseButton.h"

@implementation LGReverseButton

- (void)layoutSubviews {
    [super layoutSubviews];
    // 设置imageView位置
    self.imageView.xmg_x = 0;
    self.imageView.xmg_y = 0;
    self.imageView.xmg_width = self.xmg_width;
    self.imageView.xmg_height = self.imageView.xmg_width;
    
    // 设置textLabel位置
    self.titleLabel.xmg_x = 0;
    self.titleLabel.textAlignment = NSTextAlignmentCenter;
    self.titleLabel.xmg_y = self.imageView.xmg_height;
    self.titleLabel.xmg_width = self.xmg_width;
    self.titleLabel.xmg_height = self.xmg_height - self.titleLabel.xmg_y;
}

@end
