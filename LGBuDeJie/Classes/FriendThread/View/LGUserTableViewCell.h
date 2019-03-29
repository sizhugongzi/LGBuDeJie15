//
//  LGUserTableViewCell.h
//  LGBuDeJie
//
//  Created by 甘延娇 on 2019/3/27.
//  Copyright © 2019 itheima. All rights reserved.
//

#import <UIKit/UIKit.h>

@class LGUserModel;
NS_ASSUME_NONNULL_BEGIN

@interface LGUserTableViewCell : UITableViewCell

@property (nonatomic,strong) LGUserModel *user;

@end

NS_ASSUME_NONNULL_END
