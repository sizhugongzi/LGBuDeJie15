//
//  LGADViewController.m
//  LGBuDeJie
//
//  Created by 甘延娇 on 2019/3/22.
//  Copyright © 2019 itheima. All rights reserved.
//

#import "LGADViewController.h"
#import <UIImageView+WebCache.h>
#import <FLAnimatedImage.h>
#import "LGTabBarController.h"
#import "LGADItem.h"


@interface LGADViewController ()

@property (weak, nonatomic) IBOutlet UIButton *jumpButton;
@property (weak, nonatomic) IBOutlet UIImageView *launchImageView;
@property (weak, nonatomic) IBOutlet UIView *containerView;

@property (nonatomic,weak) NSTimer *timer;
@property (nonatomic,strong) LGADItem *adItem;

@end

@implementation LGADViewController

- (IBAction)jump:(UIButton *)sender {
    //倒计时结束
    LGTabBarController *tabBarVc = [[LGTabBarController alloc] init];
    //进入到主界面
    [UIApplication sharedApplication].keyWindow.rootViewController = tabBarVc;
    //销毁定时器
    [_timer invalidate];
    _timer = nil;
}

//每隔一秒就会调用
- (void)timeChange
{
    static int count = 3;
    count -- ;
    //设置按钮文字
    [self.jumpButton setTitle:[NSString stringWithFormat:@"跳过(%d)",count] forState:UIControlStateNormal];
    if (count == -1) {
        [self jump:nil];
    }
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    //设置启动图片
    [self setupLaunchImageView];
    //加载数据
    [self loadADData];
}

#pragma mark - 加载广告数据
- (void)loadADData
{
    LGADItem *adItem = [[LGADItem alloc] init];
    self.adItem = adItem;
    adItem.adURL = @"http://ubmcmm.baidustatic.com/media/v1/0f000ntDpKKxxAOxmTK7lf.gif";
    
    FLAnimatedImage *image = [[FLAnimatedImage alloc] initWithAnimatedGIFData:[NSData dataWithContentsOfURL:[NSURL URLWithString:adItem.adURL]]];
    
    FLAnimatedImageView *imageView = [[FLAnimatedImageView alloc ] init ];
    imageView.userInteractionEnabled = YES;
    imageView.animatedImage = image;
    imageView.frame = CGRectMake(0, 0, 375, 667);
    [self.containerView addSubview:imageView];
    //添加点按手势
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tap)];
    [imageView addGestureRecognizer:tap];
}

#pragma mark - 点击广告图片就会调用
-(void)tap
{
    //进入广告界面
    NSString *baiduURL = @"https://www.baidu.com";
    NSURL *url = [NSURL URLWithString:baiduURL];
    if ([[UIApplication sharedApplication] canOpenURL:url]) {
        [[UIApplication sharedApplication] openURL:url];
    }
}

- (void)setupLaunchImageView
{
    //根据屏幕去加载不同图片
    UIImage *image = nil;
    if (iPhoneX) {
        image = [UIImage imageNamed:@"iPhoneX@3x.png" ];
    }else if (iPhone6P) {
        image = [UIImage imageNamed:@"LaunchImage-800-Portrait-736h@3x.png" ];
    }else if (iPhone6) {
        image = [UIImage imageNamed:@"LaunchImage-800-667h@2x.png" ];
    }else if (iPhone5) {
        image = [UIImage imageNamed:@"LaunchImage-568h@2x.png" ];
    }
    _launchImageView.image = image;
}

@end
