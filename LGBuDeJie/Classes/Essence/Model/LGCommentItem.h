//
//  LGCommentItem.h
//  LGBuDeJie
//
//  Created by 甘延娇 on 2019/3/22.
//  Copyright © 2019 itheima. All rights reserved.
//

#import <Foundation/Foundation.h>

@class LGUserItem;
NS_ASSUME_NONNULL_BEGIN

@interface LGCommentItem : NSObject

@property (nonatomic,strong) NSString *voiceuri;
@property (nonatomic,strong) NSString *voicetime;
@property (nonatomic,strong) NSString *content;
@property (nonatomic,strong) LGUserItem *userItem;
@property (nonatomic,strong) NSString *totalContent;

@end

NS_ASSUME_NONNULL_END
