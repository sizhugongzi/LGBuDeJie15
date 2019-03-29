//
//  AFHTTPSessionManager+Manager.m
//  LGBuDeJie
//
//  Created by 甘延娇 on 2019/3/14.
//  Copyright © 2019 itheima. All rights reserved.
//

#import "AFHTTPSessionManager+Manager.h"

@implementation AFHTTPSessionManager (Manager)

+ (instancetype)xl_manger
{
    AFHTTPSessionManager *mgr = [AFHTTPSessionManager manager];
    AFJSONResponseSerializer *response = [AFJSONResponseSerializer serializer];
    response.acceptableContentTypes = [NSSet setWithObjects:@"application/json",@"text/json",@"text/javascript",@"text/html",nil];
    mgr.responseSerializer = response;
    return mgr;
}

@end
