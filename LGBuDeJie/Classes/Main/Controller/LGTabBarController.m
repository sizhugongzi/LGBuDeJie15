//
//  LGTabBarController.m
//  LGBuDeJie
//
//  Created by 甘延娇 on 2019/3/12.
//  Copyright © 2019 itheima. All rights reserved.
//

#import "LGTabBarController.h"
#import "LGEssenceViewController.h"
#import "LGNewViewController.h"
#import "LGPublishViewController.h"
#import "LGFriendThreadViewController.h"
#import "LGMeTableViewController.h"
#import "UIImage+Render.h"
#import "LGNavigationController.h"
#import "LGPublishViewController.h"

@interface LGTabBarController ()<UITabBarControllerDelegate>

@property (nonatomic,weak) UIViewController *selectViewController;
@property (nonatomic,strong) UIButton *plusButton;

@end

@implementation LGTabBarController

//懒加载
- (UIButton *)plusButton
{
    if (!_plusButton) {
        UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
        _plusButton = button;
        [button setImage:[UIImage imageNamed:@"tabBar_publish_icon"] forState:UIControlStateNormal];
        [button setImage:[UIImage imageNamed:@"tabBar_publish_click_icon"] forState:UIControlStateHighlighted];
        [button sizeToFit];
        [self.tabBar addSubview:button];
    }
    return _plusButton;
}

//第一次使用当前类或者子类的时候也会调用 ⚠️可能会调用多次
+ (void)initialize
{
    if (self == [LGTabBarController class]) {
        UITabBarItem *item = [UITabBarItem appearance];
        NSDictionary *dict = @{
                               NSForegroundColorAttributeName:[UIColor blackColor],
                               NSFontAttributeName:[UIFont boldSystemFontOfSize:14]
                               };
        [item setTitleTextAttributes:dict forState:UIControlStateNormal];
    }
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.delegate = self;
    
    //设置➕按钮位置
    self.plusButton.center = CGPointMake(self.tabBar.frame.size.width * 0.5, self.tabBar.frame.size.height * 0.5);
   
    //添加所有的子控制器
    [self addAllChildViewControllers];
    //设置UITabBarItem
    [self setupAllTitleTarBarItems];
    
    [self plusButtonClick];
    
    self.selectViewController = self.childViewControllers[0];
}

#pragma mark --- UITabBarControllerDelegate
- (void)tabBarController:(UITabBarController *)tabBarController didSelectViewController:(UIViewController *)viewController
{
    //是否重复点击
    if (self.selectViewController == viewController) {
        //刷新当前控制器
        [[NSNotificationCenter defaultCenter] postNotificationName:@"repeatClickTab" object:nil];
    }
    self.selectViewController = viewController;
}

- (void)plusButtonClick
{
    [self.plusButton addTarget:self action:@selector(run) forControlEvents:UIControlEventTouchUpInside];
}

- (void)run
{
    LGPublishViewController *publishViewController = [[LGPublishViewController alloc] init];
    [self presentViewController:publishViewController animated:YES completion:nil];
}

- (void)addAllChildViewControllers
{
    //精华
    LGEssenceViewController *essenceViewController = [[LGEssenceViewController alloc] init];
    LGNavigationController *essenceNavigationController = [[LGNavigationController alloc] initWithRootViewController:essenceViewController];
    [self addChildViewController:essenceNavigationController];
    //新帖
    LGNewViewController *newViewController = [[LGNewViewController alloc] init];
    LGNavigationController *newNavigationController = [[LGNavigationController alloc] initWithRootViewController:newViewController];
    [self addChildViewController:newNavigationController];
    //发布
    LGPublishViewController *publishViewController = [[LGPublishViewController alloc] init];
    [self addChildViewController:publishViewController];
    //关注
    LGFriendThreadViewController *friendThreadViewController = [[LGFriendThreadViewController alloc] init];
    LGNavigationController *friendThreadNavigationController = [[LGNavigationController alloc] initWithRootViewController:friendThreadViewController];
    friendThreadViewController.view.backgroundColor = [UIColor customColor];
    [self addChildViewController:friendThreadNavigationController];
    //我
    UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"LGMeTableViewController" bundle:nil];
    LGMeTableViewController *meViewController = [storyboard instantiateInitialViewController];
    meViewController.view.backgroundColor = [UIColor customColor];
    LGNavigationController *meNavigationController = [[LGNavigationController alloc] initWithRootViewController:meViewController];
    [self addChildViewController:meNavigationController];
}

- (void)setupAllTitleTarBarItems
{
    //精华
    LGEssenceViewController *essenceViewController = self.childViewControllers[0];
    essenceViewController.tabBarItem.title = @"精华";
    essenceViewController.tabBarItem.image = [UIImage imageNamedWithOriginal:@"tabBar_essence_icon"];
    essenceViewController.tabBarItem.selectedImage = [UIImage imageNamedWithOriginal:@"tabBar_essence_click_icon"];
    //新帖
    LGNewViewController *newViewController = self.childViewControllers[1];
    newViewController.tabBarItem.title = @"新帖";
    newViewController.tabBarItem.image = [UIImage imageNamedWithOriginal:@"tabBar_new_icon"];
    newViewController.tabBarItem.selectedImage = [UIImage imageNamedWithOriginal:@"tabBar_new_click_icon"];
    //发布
    LGPublishViewController *publishViewController = self.childViewControllers[2];
    publishViewController.tabBarItem.enabled = NO;
    //关注
    LGFriendThreadViewController *friendThreadViewController = self.childViewControllers[3];
    friendThreadViewController.tabBarItem.title = @"关注";
    friendThreadViewController.tabBarItem.image = [UIImage imageNamedWithOriginal:@"tabBar_friendTrends_icon"];
    friendThreadViewController.tabBarItem.selectedImage = [UIImage imageNamedWithOriginal:@"tabBar_friendTrends_click_icon"];
    //我
    LGMeTableViewController *meViewController = self.childViewControllers[4];
    meViewController.tabBarItem.title = @"我";
    meViewController.tabBarItem.image = [UIImage imageNamedWithOriginal:@"tabBar_me_icon"];
    meViewController.tabBarItem.selectedImage = [UIImage imageNamedWithOriginal:@"tabBar_me_click_icon"];
}


@end
