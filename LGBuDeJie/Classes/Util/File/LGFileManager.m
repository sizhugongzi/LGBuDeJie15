//
//  LGFileManager.m
//  LGBuDeJie
//
//  Created by 甘延娇 on 2019/3/22.
//  Copyright © 2019 itheima. All rights reserved.
//

#import "LGFileManager.h"

@implementation LGFileManager

+ (void)getDirectorySize:(NSString *)directoryPath completion:(void(^)(int))completion
{
    //GCD
    dispatch_async(dispatch_get_global_queue(0, 0), ^{
        //创建文件管理者
        NSFileManager *mgr = [NSFileManager defaultManager];
        BOOL isDirectory = NO;
        BOOL isExists = [mgr fileExistsAtPath:directoryPath isDirectory:& isDirectory];
        
        if (!isExists || !isDirectory) {
            //抛异常
            NSException *excp = [NSException exceptionWithName:@"FileError" reason:@"小笨蛋，传入路径不存在，或者不是文件夹路径" userInfo:nil];
            
            [excp raise];
        }
        //创建文件夹所有子路径数组
        NSArray *subpaths = [mgr subpathsAtPath:directoryPath];
        //遍历
        int totalSize = 0;
        for (NSString *subPath in subpaths) {
            NSString *filePath = [directoryPath stringByAppendingPathComponent:subPath];
            //判断是否是隐藏文件
            if ([filePath containsString:@".DS"]) continue;
            
            //判断是否是文件夹
            BOOL isDirectory = NO;
            BOOL isExists = [mgr fileExistsAtPath:filePath isDirectory:& isDirectory];
            if (!isExists || isDirectory) continue;
            //获取文件属性
            NSDictionary *attr = [mgr attributesOfItemAtPath:filePath error:nil];
            totalSize += [attr fileSize];
        }
        dispatch_async(dispatch_get_main_queue(), ^{
            if (completion) {
                completion(totalSize);
            }
        });
    });
}

+ (void)removeDirectoryPath:(NSString *)directoryPath
{
    //创建文件管理者
    NSFileManager *mgr = [NSFileManager defaultManager];
    BOOL isDirectory = NO;
    BOOL isExists = [mgr fileExistsAtPath:directoryPath isDirectory:& isDirectory];
    
    if (!isExists || !isDirectory) {
        //抛异常
        @throw [NSException exceptionWithName:@"FileError" reason:@"小笨蛋，传入路径不存在，或者不是文件夹路径" userInfo:nil];
    }
    [[NSFileManager defaultManager] removeItemAtPath:directoryPath error:nil];
    [[NSFileManager defaultManager] createDirectoryAtPath:directoryPath withIntermediateDirectories:YES attributes:nil error:nil];
}

+ (void)directorySizeString:(NSString *)directoryPath completion:(void(^)(NSString *))strCompletion
{
    //获取cache尺寸
    [LGFileManager getDirectorySize:directoryPath completion:^(int totalSize){
        NSInteger size = totalSize;
        
        NSString *str = @"清除缓存";
        
        if (size > 1000 * 1000) {
            CGFloat sizeF = size / 1000.0 /1000.0;
            str = [NSString stringWithFormat:@"%@(%.1fMB)",str,sizeF];
        }else if (size > 1000){
            CGFloat sizeF = size / 1000.0 ;
            str = [NSString stringWithFormat:@"%@(%.1fKB)",str,sizeF];
        }else if (size > 0){
            str = [NSString stringWithFormat:@"%@(%ldB)",str,size];
        }
        str = [str stringByReplacingOccurrencesOfString:@".0" withString:@""];
        if (strCompletion) {
            strCompletion(str);
        }
    }];
}

@end
