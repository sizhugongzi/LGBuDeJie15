//
//  LGLoginViewController.m
//  LGBuDeJie
//
//  Created by 甘延娇 on 2019/3/22.
//  Copyright © 2019 itheima. All rights reserved.
//

#import "LGLoginViewController.h"
#import "LGLoginRegisterView.h"

@interface LGLoginViewController ()

@property (weak, nonatomic) IBOutlet UIView *middleView;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *leadingCons;

@end

@implementation LGLoginViewController

- (IBAction)dismiss:(id)sender {
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (IBAction)clickRegister:(UIButton *)sender {
    sender.selected = !sender.selected;
    
    //移动中间View
    _leadingCons.constant = _leadingCons.constant == 0? -LGScreenW:0;
    [UIView animateWithDuration:0.25 animations:^{
        [self.view layoutIfNeeded];
    }];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    /*
     xib使用注意点
     1.一个控件从xib加载，需要取设置尺寸？默认跟xib尺寸i一样
     2.一个控件从xib加载，需不需要去再次确定尺寸和位置？
     3.在viewDidLoad中，去设置尺寸，参考为屏幕不会有问题，参考控制器View的子控件就会有问题
     viewDidLoad这个时候，还不会执行约束
     */
    //创建登录View
    LGLoginRegisterView *loginView = [LGLoginRegisterView loginView];
    
    [_middleView addSubview:loginView];
    
    //创建注册View
    LGLoginRegisterView *registerView = [LGLoginRegisterView registerView];
    
    [_middleView addSubview:registerView];
}

//计算好所有子控件的位置完成的时候调用
//执行完约束
- (void)viewDidLayoutSubviews
{
    [super viewDidLayoutSubviews];
    
    _middleView.subviews[0].frame = CGRectMake(0, 0, _middleView.xmg_width * 0.5, _middleView.xmg_height);
    
    _middleView.subviews[1].frame = CGRectMake(_middleView.xmg_width * 0.5, 0, _middleView.xmg_width * 0.5, _middleView.xmg_height);
}

@end
