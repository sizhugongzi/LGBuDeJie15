//
//  LGFriendThreadViewController.m
//  LGBuDeJie
//
//  Created by 甘延娇 on 2019/3/12.
//  Copyright © 2019 itheima. All rights reserved.
//

#import "LGFriendThreadViewController.h"
#import "UIBarButtonItem+Item.h"
#import "LGLoginViewController.h"
#import "LGRecommendViewController.h"


@interface LGFriendThreadViewController ()

@property (weak, nonatomic) IBOutlet UIButton *loginButton;

@end

@implementation LGFriendThreadViewController

//点击了登录按钮
- (IBAction)clickLogin:(id)sender {
    
    UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"LGLoginViewController" bundle:nil];
    
    //加载箭头指向控制器
    LGLoginViewController *loginViewController = [storyboard instantiateInitialViewController];
    [self presentViewController:loginViewController animated:YES completion:nil];
}

- (void)viewDidLoad {
    [super viewDidLoad];
   
    //设置导航条内容
    [self setupNavigationBar];
}
-(void)setupNavigationBar
{
    //设置导航条内容
    self.navigationItem.title = @"我的关注";
    //右边
    self.navigationItem.leftBarButtonItem = [UIBarButtonItem itemWithImage:[UIImage imageNamed:@"friendsRecommentIcon"] highImage:[UIImage imageNamed:@"friendsRecommentIcon-click"] target:self action:@selector(recomondClick)];
}
-(void)recomondClick
{
    LGRecommendViewController *recommendViewController = [[LGRecommendViewController alloc] init];
    [self.navigationController pushViewController:recommendViewController animated:YES];
}

@end
