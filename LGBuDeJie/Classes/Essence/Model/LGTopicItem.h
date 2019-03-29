//
//  LGTopicItem.h
//  LGBuDeJie
//
//  Created by 甘延娇 on 2019/3/14.
//  Copyright © 2019 itheima. All rights reserved.
//

#import <Foundation/Foundation.h>

@class LGCommentItem;

typedef enum : NSUInteger{
    LGTopicItemTypeAll = 1,
    LGTopicItemTypePicture = 10,
    LGTopicItemTypeVideo = 41,
    LGTopicItemTypeVoice = 31,
    LGTopicItemTypeText = 29
} LGTopicItemType;

NS_ASSUME_NONNULL_BEGIN

@interface LGTopicItem : NSObject

//枚举
@property (nonatomic,assign) LGTopicItemType type;

//1顶部View
@property (nonatomic,strong) NSString *profile_image;
@property (nonatomic,strong) NSString *screen_name;
@property (nonatomic,strong) NSString *text;
@property (nonatomic,strong) NSString *create_time;

//2中间图片的View
@property (nonatomic,strong) NSString *image0;
@property (nonatomic,assign) BOOL is_gif;
@property (nonatomic,assign) CGFloat width;
@property (nonatomic,assign) CGFloat height;
@property (nonatomic,assign) BOOL is_bigPicture;

@property (nonatomic,strong) UIImage *localImage;

//视频
@property (nonatomic,strong) NSString *videourl;
@property (nonatomic,assign) NSInteger videotime;
@property (nonatomic,strong) NSString *playcount;
//声音
@property (nonatomic,strong) NSString *voiceurl;
@property (nonatomic,assign) NSInteger voicetime;

//处理最热评论数据
@property (nonatomic,strong) NSArray *top_cmt;
@property (nonatomic,strong) LGCommentItem *topComment;

//底部View属性
@property (nonatomic,assign) CGFloat cai;
@property (nonatomic,assign) CGFloat ding;
@property (nonatomic,assign) CGFloat comment;
@property (nonatomic,assign) CGFloat repost;

@end

NS_ASSUME_NONNULL_END
