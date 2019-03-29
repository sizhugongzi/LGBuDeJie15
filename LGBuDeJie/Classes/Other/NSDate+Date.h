//
//  NSDate+Date.h
//  LGBuDeJie
//
//  Created by 甘延娇 on 2019/3/22.
//  Copyright © 2019 itheima. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface NSDate (Date)

- (BOOL)isThisYear;

- (BOOL)isThisToday;

- (BOOL)isThisYesterday;

- (NSDateComponents *)datalWithNow;

@end

NS_ASSUME_NONNULL_END
