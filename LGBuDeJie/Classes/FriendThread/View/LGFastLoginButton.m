//
//  LGFastLoginButton.m
//  LGBuDeJie
//
//  Created by 甘延娇 on 2019/3/22.
//  Copyright © 2019 itheima. All rights reserved.
//

#import "LGFastLoginButton.h"

@implementation LGFastLoginButton

- (void)layoutSubviews
{
    [super layoutSubviews];
    
    //设置图片
    self.imageView.xmg_centerX = self.xmg_width * 0.5;
    self.imageView.xmg_y = 3;
    [self.titleLabel sizeToFit];
    self.titleLabel.xmg_centerX = self.xmg_width * 0.5;
    self.titleLabel.xmg_y = self.xmg_height - self.titleLabel.xmg_height;
}

@end
