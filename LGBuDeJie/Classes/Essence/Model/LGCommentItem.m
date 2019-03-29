//
//  LGCommentItem.m
//  LGBuDeJie
//
//  Created by 甘延娇 on 2019/3/22.
//  Copyright © 2019 itheima. All rights reserved.
//

#import "LGCommentItem.h"
#import "LGUserItem.h"

@implementation LGCommentItem

-(NSString *) totalContent{
    return [NSString stringWithFormat:@"%@:%@",self.userItem.username,self.content];
}

@end
