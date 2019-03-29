//
//  LGSubTagTableViewCell.h
//  LGBuDeJie
//
//  Created by 甘延娇 on 2019/3/22.
//  Copyright © 2019 itheima. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "LGSubTagItem.h"

@class LGSubTagItem;
NS_ASSUME_NONNULL_BEGIN

@interface LGSubTagTableViewCell : UITableViewCell

@property (nonatomic,strong) LGSubTagItem *item;
+ (instancetype)cell;

@end

NS_ASSUME_NONNULL_END
