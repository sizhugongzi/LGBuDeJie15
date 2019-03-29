//
//  LGBottomTopicView.m
//  LGBuDeJie
//
//  Created by 甘延娇 on 2019/3/22.
//  Copyright © 2019 itheima. All rights reserved.
//

#import "LGBottomTopicView.h"
#import "LGTopicItem.h"

@interface LGBottomTopicView ()

@property (weak, nonatomic) IBOutlet UIButton *dingView;
@property (weak, nonatomic) IBOutlet UIButton *caiView;
@property (weak, nonatomic) IBOutlet UIButton *shareView;
@property (weak, nonatomic) IBOutlet UIButton *commentView;

@end

@implementation LGBottomTopicView

- (void)setTopicItem:(LGTopicItem *)topicItem
{
    [super setTopicItem:topicItem];
    [self setupButton:_dingView count:topicItem.ding title:@"赞"];
    [self setupButton:_caiView count:topicItem.cai title:@"踩"];
    [self setupButton:_shareView count:topicItem.repost title:@"分享"];
    [self setupButton:_commentView count:topicItem.comment title:@"评论"];
}

- (void)setupButton:(UIButton *)btn count:(CGFloat)count title:(NSString *)title
{
    NSString *str = @"赞";
    
    if (count > 10000) {
        count = count / 10000;
        str = [NSString stringWithFormat:@"%.1f万",count];
    }else if (count > 0){
        str = [NSString stringWithFormat:@"%.0f",count];
    }
    str = [str stringByReplacingOccurrencesOfString:@".0" withString:@""];
    
    [btn setTitle:str forState:UIControlStateNormal];
}

@end
