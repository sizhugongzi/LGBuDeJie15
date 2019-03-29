//
//  LGTopicViewModel.m
//  LGBuDeJie
//
//  Created by 甘延娇 on 2019/3/14.
//  Copyright © 2019 itheima. All rights reserved.
//

#import "LGTopicViewModel.h"
#import "LGTopicItem.h"
#import "LGCommentItem.h"

@implementation LGTopicViewModel

- (void)setTopicItem:(LGTopicItem *)topicItem
{
    _topicItem = topicItem;
    
    //计算cell高度
    CGFloat topX = 0;
    CGFloat topY = 0;
    CGFloat topW = LGScreenW;
    CGFloat margin = 10;
    CGFloat textY = 55;
    CGFloat textW = LGScreenW - 2 * margin;
    CGFloat textH = [topicItem.text sizeWithFont:[UIFont systemFontOfSize:17] constrainedToSize:CGSizeMake(textW, MAXFLOAT)].height;
    CGFloat topH = textY + textH;
    
    _topViewFrame = CGRectMake(topX, topY, topW, topH);
    
    _cellH = CGRectGetMaxY(_topViewFrame) + margin;
    
    //计算中间View
    if (topicItem.type != LGTopicItemTypeText) {
        CGFloat middleX = margin;
        CGFloat middleY = _cellH;
        CGFloat middleW = textW;
        CGFloat middleH = textW / topicItem.width * topicItem.height;
        if (middleH > LGScreenH) {
            middleH = 300;
            topicItem.is_bigPicture = YES;
        }
        _middleViewFrame = CGRectMake(middleX, middleY, middleW, middleH);
        _cellH = CGRectGetMaxY(_middleViewFrame) + margin;
    }
    
    //最热评论View
    if (topicItem.topComment) {
        CGFloat commentX = 0;
        CGFloat commentY = _cellH;
        CGFloat commentW = LGScreenW;
        CGFloat commentH = 43;
        if (topicItem.topComment.content.length) {
            CGFloat textH = [topicItem.topComment.totalContent sizeWithFont:[UIFont systemFontOfSize:17] constrainedToSize:CGSizeMake(textW, MAXFLOAT)].height;
            commentH = 21 + textH;
        }
        _commentViewFrame = CGRectMake(commentX, commentY, commentW, commentH);
        _cellH = CGRectGetMaxY(_commentViewFrame) + margin;
    }
    //底部View
    CGFloat buttonX = 0;
    CGFloat buttonY = _cellH;
    CGFloat buttonW = LGScreenW;
    CGFloat buttonH = 35;
    _bottomViewFrame = CGRectMake(buttonX, buttonY, buttonW, buttonH);
    _cellH  = CGRectGetMaxY(_bottomViewFrame);
    
    _cellH += 10;
}

@end
