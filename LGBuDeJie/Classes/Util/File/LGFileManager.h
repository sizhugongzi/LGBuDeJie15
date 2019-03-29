//
//  LGFileManager.h
//  LGBuDeJie
//
//  Created by 甘延娇 on 2019/3/22.
//  Copyright © 2019 itheima. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface LGFileManager : NSObject

/**
 指定一个文件夹的路径，获取当前文件夹路径
 参数directoryPath：文件夹路径
 返回：文件夹路径尺寸
 */
+ (void)getDirectorySize:(NSString *)directoryPath completion:(void(^)(int))completion;

/**
 指定一个文件夹路径，删除这个文件夹
 */
+ (void)removeDirectoryPath:(NSString *)directoryPath;

/**
 指定一个文件夹路径，直接帮你获取当前文件夹尺寸字符串
 */
+ (void)directorySizeString:(NSString *)directoryPath completion:(void(^)(NSString *))strCompletion;

@end

NS_ASSUME_NONNULL_END
