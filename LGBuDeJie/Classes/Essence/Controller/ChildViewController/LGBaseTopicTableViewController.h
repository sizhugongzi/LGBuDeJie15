//
//  LGBaseTopicTableViewController.h
//  LGBuDeJie
//
//  Created by 甘延娇 on 2019/3/22.
//  Copyright © 2019 itheima. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface LGBaseTopicTableViewController : UITableViewController

@property (nonatomic,strong) NSNumber *type;

- (void)reload;

@end

NS_ASSUME_NONNULL_END
