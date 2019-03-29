//
//  LGCategoryItem.h
//  LGBuDeJie
//
//  Created by 甘延娇 on 2019/3/27.
//  Copyright © 2019 itheima. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface LGCategoryItem : NSObject

@property (nonatomic,copy) NSString *name;
@property (nonatomic,assign) NSInteger id;

//保存当前分类的用户组
@property (nonatomic,strong) NSMutableArray *users;
@property (nonatomic,assign) NSInteger page;
@property (nonatomic,assign) NSInteger total_page;

@end

NS_ASSUME_NONNULL_END
