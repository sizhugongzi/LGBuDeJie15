//
//  LGTopicViewModel.h
//  LGBuDeJie
//
//  Created by 甘延娇 on 2019/3/14.
//  Copyright © 2019 itheima. All rights reserved.
//

#import <UIKit/UIKit.h>

@class LGTopicItem;
NS_ASSUME_NONNULL_BEGIN

@interface LGTopicViewModel : UIView

@property (nonatomic,copy) LGTopicItem *topicItem;

@property (nonatomic,assign) CGRect topViewFrame;
@property (nonatomic,assign) CGRect middleViewFrame;
@property (nonatomic,assign) CGRect commentViewFrame;
@property (nonatomic,assign) CGRect bottomViewFrame;
@property (nonatomic,assign) CGFloat cellH;

@end

NS_ASSUME_NONNULL_END
