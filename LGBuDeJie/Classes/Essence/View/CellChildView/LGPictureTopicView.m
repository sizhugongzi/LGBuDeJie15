//
//  LGPictureTopicView.m
//  LGBuDeJie
//
//  Created by 甘延娇 on 2019/3/15.
//  Copyright © 2019 itheima. All rights reserved.
//

#import "LGPictureTopicView.h"
#import <UIImageView+WebCache.h>
#import "LGTopicItem.h"
#import "LGSeeBigPictureViewController.h"
#import <DALabeledCircularProgressView.h>

@interface LGPictureTopicView ()

@property (weak, nonatomic) IBOutlet UIImageView *gifView;
@property (weak, nonatomic) IBOutlet UIImageView *pictureView;
@property (weak, nonatomic) IBOutlet UIButton *seeBigButton;
@property (weak, nonatomic) IBOutlet DALabeledCircularProgressView *progressView;

@end

@implementation LGPictureTopicView

- (void)awakeFromNib
{
    [super awakeFromNib];
    _progressView.progressLabel.textColor = [UIColor whiteColor];
    _progressView.progressTintColor = [UIColor redColor];
    _progressView.trackTintColor = [UIColor lightGrayColor];
    _progressView.roundedCorners = 5;
}

- (void)touchesEnded:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    //弹出查看大图View
    LGSeeBigPictureViewController *seeBigPictureViewController = [[LGSeeBigPictureViewController alloc] init];
    seeBigPictureViewController.item = self.topicItem;
    [[UIApplication sharedApplication].keyWindow.rootViewController presentViewController:seeBigPictureViewController animated:YES completion:nil];
}

- (void)setTopicItem:(LGTopicItem *)topicItem
{
    [super setTopicItem:topicItem];
    
    _progressView.progress = 0;
    _progressView.progressLabel.text = @"0%";
    
    NSString *fileName = [topicItem.image0 stringByReplacingOccurrencesOfString:@"/" withString:@""];
    
    //先从沙盒中获取之前裁剪图片
    NSString *filePath = [CachePath stringByAppendingPathComponent:fileName];
    NSData *data = [NSData dataWithContentsOfFile:filePath];
    UIImage *image = [UIImage imageWithData:data];
    
    if (image) {
        topicItem.localImage = image;
        self.pictureView.image = image;
    }else{
        [_pictureView sd_setImageWithURL:[NSURL URLWithString:topicItem.image0] placeholderImage:nil options:SDWebImageRetryFailed progress:^(NSInteger receivedSize, NSInteger expectedSize, NSURL * _Nullable targetURL) {
            //进度的Block在子线程调用
            if (expectedSize == -1) return ;
            
            CGFloat progress = 1.0 * receivedSize / expectedSize;
            
            NSString *str =  [NSString stringWithFormat:@"%.1f%%",progress * 100];
            
            dispatch_sync(dispatch_get_main_queue(), ^{
                self->_progressView.progressLabel.text = str;
                
                self->_progressView.progress = progress;
            });
            
            
        } completed:^(UIImage * _Nullable image, NSError * _Nullable error, SDImageCacheType cacheType, NSURL * _Nullable imageURL) {
            //加载完图片就会调用
            if (image.size.height < 10000) return ;
            
            CGFloat imageW = LGScreenW - 20;
            CGFloat imageH = imageW / image.size.width * image.size.height;
            //开启图形上下文
            UIGraphicsBeginImageContext(CGSizeMake(imageW, imageH));
            //画图
            [image drawInRect:CGRectMake(0, 0, imageW, imageH)];
            //取图
            image = UIGraphicsGetImageFromCurrentImageContext();
            //关闭上下文
            UIGraphicsEndImageContext();
            
            self.pictureView.image = image;
            topicItem.localImage = image;
            
            //图片转NSData
           NSString *fileName = [topicItem.image0 stringByReplacingOccurrencesOfString:@"/" withString:@""];
            NSString *filePath = [CachePath stringByAppendingPathComponent:fileName];
            NSData *data = [NSData dataWithContentsOfFile:filePath];
            [data writeToFile:filePath atomically:YES];
            
        }];
    }
    
    _gifView.hidden = !topicItem.is_gif;
    
    //做大图处理
    _seeBigButton.hidden = !topicItem.is_bigPicture;
    
    if (topicItem.is_bigPicture) {
        //设置图片内容模式
        _pictureView.contentMode = UIViewContentModeTop;
        _pictureView.clipsToBounds = YES;
    }else {
        _pictureView.contentMode = UIViewContentModeScaleToFill;
        _pictureView.clipsToBounds = NO;
    }
}
@end
