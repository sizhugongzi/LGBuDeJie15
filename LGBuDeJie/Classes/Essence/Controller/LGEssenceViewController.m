//
//  LGEssenceViewController.m
//  LGBuDeJie
//
//  Created by 甘延娇 on 2019/3/12.
//  Copyright © 2019 itheima. All rights reserved.
//

#import "LGEssenceViewController.h"
#import "UIBarButtonItem+Item.h"
#import "LGBaseTopicTableViewController.h"
#import "LGTopicItem.h"

@interface LGEssenceViewController ()

@end

@implementation LGEssenceViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    //设置导航条内容
    [self setupNavigationBar];
    
    //添加所有的子控制器
    [self setupAllChildViewController];
}

-(void)setupAllChildViewController
{
    //全部
    LGBaseTopicTableViewController *allTableVC = [[LGBaseTopicTableViewController alloc] init];
    allTableVC.title = @"全部";
    allTableVC.type = @(LGTopicItemTypeAll);
    [self addChildViewController:allTableVC];
    //视频
    LGBaseTopicTableViewController *videoTableVC = [[LGBaseTopicTableViewController alloc] init];
    videoTableVC.title = @"视频";
    videoTableVC.type = @(LGTopicItemTypeVideo);
    [self addChildViewController:videoTableVC];
    //声音
    LGBaseTopicTableViewController *voiceTableVC = [[LGBaseTopicTableViewController alloc] init];
    voiceTableVC.title = @"声音";
    voiceTableVC.type = @(LGTopicItemTypeVoice);
    [self addChildViewController:voiceTableVC];
    //图片
    LGBaseTopicTableViewController *pictureTableVC = [[LGBaseTopicTableViewController alloc] init];
    pictureTableVC.title = @"图片";
    pictureTableVC.type = @(LGTopicItemTypePicture);
    [self addChildViewController:pictureTableVC];
    //段子
    LGBaseTopicTableViewController *textTableVC = [[LGBaseTopicTableViewController alloc] init];
    textTableVC.title = @"段子";
    textTableVC.type = @(LGTopicItemTypeText);
    [self addChildViewController:textTableVC];
}

- (void)setupNavigationBar
{
    //设置导航条内容
    self.navigationItem.titleView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"MainTitle"]];
    //左边
    self.navigationItem.leftBarButtonItem = [UIBarButtonItem itemWithImage:[UIImage imageNamed:@"nav_coin_icon"] highImage:[UIImage imageNamed:@"nav_coin_icon_click"] target:self action:@selector(game)];
    //右边
    UIBarButtonItem *item = [UIBarButtonItem itemWithImage:[UIImage imageNamed:@"mine-setting-icon"] highImage:[UIImage imageNamed:@"mine-setting-icon-click"] target:self action:@selector(setting)];
    self.navigationItem.rightBarButtonItem = item;
}

- (void)game
{
    NSLog(@"点击了精华控制器右边的游戏按钮");
}

- (void)setting
{
    NSLog(@"点击了精华控制器右边的设置按钮");
}

@end
