//
//  LGCommentTopicView.m
//  LGBuDeJie
//
//  Created by 甘延娇 on 2019/3/22.
//  Copyright © 2019 itheima. All rights reserved.
//

#import "LGCommentTopicView.h"
#import "LGCommentItem.h"
#import "LGUserItem.h"
#import "LGTopicItem.h"

@interface LGCommentTopicView ()

@property (weak, nonatomic) IBOutlet UILabel *totalView;
@property (weak, nonatomic) IBOutlet UIView *voiceView;
@property (weak, nonatomic) IBOutlet UILabel *nameView;
@property (weak, nonatomic) IBOutlet UIButton *voiceButton;

@end

//以后只要界面没有问题，但是莫名其妙的报一些约束冲突，这时候考虑自动拉伸属性（IOS6）

@implementation LGCommentTopicView

- (void)awakeFromNib
{
    [super awakeFromNib];
    
    self.autoresizingMask = UIViewAutoresizingNone;
}

- (void)setTopicItem:(LGTopicItem *)topicItem
{
    [super setTopicItem:topicItem];
    
    if (topicItem.topComment.content.length) {
        //文字
        self.voiceView.hidden = YES;
        self.totalView.hidden = NO;
        
        self.totalView.text = topicItem.topComment.totalContent;
    }else{
        //音频
        self.voiceView.hidden = NO;
        self.totalView.hidden = YES;
        
        self.nameView.text = topicItem.topComment.userItem.username;
        [self.voiceButton setTitle:topicItem.topComment.voicetime forState:UIControlStateNormal];
    }
}

@end
