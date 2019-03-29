//
//  LGTopicCell.m
//  LGBuDeJie
//
//  Created by 甘延娇 on 2019/3/14.
//  Copyright © 2019 itheima. All rights reserved.
//

#import "LGTopicCell.h"
#import "LGTopTopicView.h"
#import "LGTopicItem.h"
#import "LGTopicViewModel.h"
#import "LGPictureTopicView.h"
#import "LGVideoTopicView.h"
#import "LGVoiceTopicView.h"
#import "LGCommentTopicView.h"
#import "LGBottomTopicView.h"

@interface LGTopicCell ()

@property (nonatomic,strong) LGTopTopicView *topTopicView;
@property (nonatomic,strong) LGPictureTopicView *pictureView;
@property (nonatomic,strong) LGVideoTopicView *videoView;
@property (nonatomic,strong) LGVoiceTopicView *voiceView;
@property (nonatomic,strong) LGCommentTopicView *commentView;
@property (nonatomic,strong) LGBottomTopicView *bottomtView;

@end

@implementation LGTopicCell

- (void)setFrame:(CGRect)frame
{
    frame.size.height -= 10;
    frame.origin.y += 10;
    
    [super setFrame:frame];
}

- (void)setViewModel:(LGTopicViewModel *)viewModel
{
    _viewModel = viewModel;
    
    //顶部View
    _topTopicView.topicItem = viewModel.topicItem;
    _topTopicView.frame = viewModel.topViewFrame;
    
    //中间View
    if (viewModel.topicItem.type == LGTopicItemTypePicture) {
        _pictureView.topicItem = viewModel.topicItem;
        _pictureView.frame = viewModel.middleViewFrame;
        
        _videoView.hidden = YES;
        _voiceView.hidden = YES;
        _pictureView.hidden = NO;
        
    }else if (viewModel.topicItem.type == LGTopicItemTypeVideo){
        _videoView.topicItem = viewModel.topicItem;
        _videoView.frame = viewModel.middleViewFrame;
        
        _videoView.hidden = NO;
        _pictureView.hidden = YES;
        _voiceView.hidden = YES;
    }else if (viewModel.topicItem.type == LGTopicItemTypeVoice){
        _voiceView.topicItem = viewModel.topicItem;
        _voiceView.frame = viewModel.middleViewFrame;
        
        _videoView.hidden = YES;
        _pictureView.hidden = YES;
        _voiceView.hidden = NO;
    }else{
        _videoView.hidden = YES;
        _pictureView.hidden = YES;
        _voiceView.hidden = YES;
    }
    //设置最热评论
    if (viewModel.topicItem.topComment) {
        _commentView.hidden = NO;
        _commentView.topicItem = viewModel.topicItem;
        _commentView.frame = viewModel.commentViewFrame;
    }else{
        _commentView.hidden = YES;
    }
    //设置底部View
    _bottomtView.topicItem = viewModel.topicItem;
    _bottomtView.frame = viewModel.bottomViewFrame;
}

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        //顶部view
        LGTopTopicView *topTopicView = [LGTopTopicView viewForNib];
        _topTopicView = topTopicView;
        [self.contentView addSubview:topTopicView];
        //2中间(视频，声音，图片)
        //图片
        LGPictureTopicView *pictureView = [LGPictureTopicView viewForNib];
        [self.contentView addSubview:pictureView];
        _pictureView = pictureView;
        //视频
        LGVideoTopicView *videoView = [LGVideoTopicView viewForNib];
        [self.contentView addSubview:videoView];
        _videoView = videoView;
        //声音
        LGVoiceTopicView *voiceView = [LGVoiceTopicView viewForNib];
        [self.contentView addSubview:voiceView];
        _voiceView = voiceView;
        //最新评论
        LGCommentTopicView *commentView = [LGCommentTopicView viewForNib];
        [self.contentView addSubview:commentView];
        _commentView = commentView;
        //底部
        LGBottomTopicView *bottomtView = [LGBottomTopicView viewForNib];
        [self.contentView addSubview:bottomtView];
        _bottomtView = bottomtView;
    }
    return self;
}

@end
