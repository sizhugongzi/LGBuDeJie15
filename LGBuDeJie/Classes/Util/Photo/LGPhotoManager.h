//
//  LGPhotoManager.h
//  LGBuDeJie
//
//  Created by 甘延娇 on 2019/3/22.
//  Copyright © 2019 itheima. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface LGPhotoManager : NSObject

+ (void)savePhoto:(UIImage *)image albumTitle:(NSString *)albumTitle completionHandler:(void(^)(BOOL success, NSError * error))completionHandler;

@end

NS_ASSUME_NONNULL_END
