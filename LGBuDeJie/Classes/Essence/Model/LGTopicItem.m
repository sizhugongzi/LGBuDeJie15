//
//  LGTopicItem.m
//  LGBuDeJie
//
//  Created by 甘延娇 on 2019/3/14.
//  Copyright © 2019 itheima. All rights reserved.
//

#import "LGTopicItem.h"
#import "LGCommentItem.h"
#import <MJExtension/MJExtension.h>

@implementation LGTopicItem

+ (NSDictionary *)mj_objectClassInArray
{
    return @{@"top_cmt":@"LGCommentItem"};
}

- (void)setTop_cmt:(NSArray *)top_cmt
{
    _top_cmt = top_cmt;
    
    if (_top_cmt.count) {
        
        _top_cmt = _top_cmt.firstObject;
    }
}

@end
