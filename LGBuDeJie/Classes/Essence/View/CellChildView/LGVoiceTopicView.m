//
//  LGVoiceTopicView.m
//  LGBuDeJie
//
//  Created by 甘延娇 on 2019/3/22.
//  Copyright © 2019 itheima. All rights reserved.
//

#import "LGVoiceTopicView.h"
#import "LGTopicItem.h"
#import <UIImageView+WebCache.h>

@interface LGVoiceTopicView ()

@property (weak, nonatomic) IBOutlet UIImageView *pictureView;
@property (weak, nonatomic) IBOutlet UILabel *playCountView;
@property (weak, nonatomic) IBOutlet UILabel *timeView;

@end

@implementation LGVoiceTopicView

- (void)setTopicItem:(LGTopicItem *)topicItem
{
    [super setTopicItem: topicItem];
    
    [_pictureView sd_setImageWithURL:[NSURL URLWithString:topicItem.image0]];
    
    _playCountView.text = [NSString stringWithFormat:@"%@播放",topicItem.playcount];
    
    NSInteger second = topicItem.voicetime % 60;
    NSInteger minute = topicItem.voicetime / 60;
    
    _timeView.text = [NSString stringWithFormat:@"%02ld:%02ld",minute,second];
}

@end
