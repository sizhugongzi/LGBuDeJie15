//
//  LGNavigationController.m
//  LGBuDeJie
//
//  Created by 甘延娇 on 2019/3/13.
//  Copyright © 2019 itheima. All rights reserved.
//

#import "LGNavigationController.h"
#import "LGBackView.h"

@interface LGNavigationController ()<UIGestureRecognizerDelegate>

@end

@implementation LGNavigationController

+ (void)load
{
    //统一设置导航条
    UINavigationBar *bar = [UINavigationBar appearanceWhenContainedIn:self,nil];
    NSDictionary *dict = @{
                           NSFontAttributeName:[UIFont boldSystemFontOfSize:20],
                           NSForegroundColorAttributeName:[UIColor purpleColor],
                           };
    bar.titleTextAttributes = dict;
    //设置导航条的背景图片
    [bar setBackgroundImage:[UIImage imageNamed:@"navigationbarBackgroundWhite"] forBarMetrics:UIBarMetricsDefault];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    //不要系统手势
    self.interactivePopGestureRecognizer.enabled = NO;
    id target = self.interactivePopGestureRecognizer.delegate;
    //创建Pan手势
    UIPanGestureRecognizer *pan = [[UIPanGestureRecognizer alloc] initWithTarget:target action:@selector(handleNavigationTransition:)];
    pan.delegate = self;
    [self.view addGestureRecognizer:pan];
}

- (void)pushViewController:(UIViewController *)viewController animated:(BOOL)animated
{
    //设置导航条返回按钮
    if (self.childViewControllers.count > 0) {
        LGBackView *backView = [LGBackView backViewWithImage:[UIImage imageNamed:@"navigationButtonReturn"] highImage:[UIImage imageNamed:@"navigationButtonReturnClick"] target:self action:@selector(back) title:@"返回"];
        viewController.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:backView];
        viewController.hidesBottomBarWhenPushed = YES;
    }
    [super pushViewController:viewController animated:animated];
}

- (void)back
{
    [self popViewControllerAnimated:YES];
}

#pragma mark - UIGestureRecognizerDelegate
//用来控制手势是否触发
- (BOOL)gestureRecognizer:(UIGestureRecognizer *)gestureRecognizer shouldReceiveTouch:(UITouch *)touch
{
    return self.childViewControllers.count > 1;
}

@end
