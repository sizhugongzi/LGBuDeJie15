//
//  LGTopTopicView.m
//  LGBuDeJie
//
//  Created by 甘延娇 on 2019/3/14.
//  Copyright © 2019 itheima. All rights reserved.
//

#import "LGTopTopicView.h"
#import <UIImageView+WebCache.h>
#import "LGTopicItem.h"
#import "NSDate+Date.h"

@interface LGTopTopicView ()

@property (weak, nonatomic) IBOutlet UIImageView *iconView;
@property (weak, nonatomic) IBOutlet UILabel *nameLabel;
@property (weak, nonatomic) IBOutlet UILabel *timeLabel;
@property (weak, nonatomic) IBOutlet UILabel *textLabel;

@end

@implementation LGTopTopicView

- (void)setTopicItem:(LGTopicItem *)topicItem
{
    [super setTopicItem:topicItem];
    
    [_iconView sd_setImageWithURL:[NSURL URLWithString:topicItem.profile_image]];
    _nameLabel.text = topicItem.screen_name;
    _textLabel.text = topicItem.text;
    //处理时间
    _timeLabel.text = [self timeStr:topicItem];
}

- (IBAction)clickMore:(id)sender {
    UIAlertController *alertVc = [UIAlertController alertControllerWithTitle:nil message:nil preferredStyle:0];
    UIAlertAction *action = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
        NSLog(@"点击了取消");
    }];
    [alertVc addAction:action];
    UIViewController *rootVc = [UIApplication sharedApplication].keyWindow.rootViewController;
    [rootVc presentViewController:alertVc animated:YES completion:nil];
}

- (NSString *)timeStr:(LGTopicItem *)topicItem
{
    NSString *str = topicItem.create_time;
    //发帖日期字符串转发帖日期对象
    NSDateFormatter *fmt = [[NSDateFormatter alloc] init];
    fmt.dateFormat = @"yyyy-MM-dd HH:mm:ss";
    //获取发帖日期对象
    NSDate *createDate = [fmt dateFromString:str];
    //获取发帖日期与当前日期时间差值
    NSDateComponents *detalCmp = [createDate datalWithNow];
    
    if ([createDate  isThisYear]) {//今年
        
        if ([createDate isThisToday]) {//今天
            
            if (detalCmp.hour > 1) {
                
                str = [NSString stringWithFormat:@"%ld小时前",detalCmp.hour];
                
            }else if (detalCmp.minute >= 1){
                
                str = [NSString stringWithFormat:@"%ld分钟前",detalCmp.minute];
                
            }else{//刚刚
                str = @"刚刚";
            }
        }else if ([createDate isThisYesterday]){//昨天
            fmt.dateFormat = @"昨天 HH:mm";
            str = [fmt stringFromDate:createDate];
        }else{//昨天之前
            fmt.dateFormat = @"MM-dd HH:mm:ss";
            str = [fmt stringFromDate:createDate];
        }
    }
    return str;
}


@end
