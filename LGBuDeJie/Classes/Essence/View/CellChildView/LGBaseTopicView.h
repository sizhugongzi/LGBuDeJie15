//
//  LGBaseTopicView.h
//  LGBuDeJie
//
//  Created by 甘延娇 on 2019/3/15.
//  Copyright © 2019 itheima. All rights reserved.
//

#import <UIKit/UIKit.h>

@class LGTopicItem;
NS_ASSUME_NONNULL_BEGIN

@interface LGBaseTopicView : UIView

@property (nonatomic,strong) LGTopicItem *topicItem;

+ (instancetype)viewForNib;

@end

NS_ASSUME_NONNULL_END
