//
//  LGMeTableViewController.m
//  LGBuDeJie
//
//  Created by 甘延娇 on 2019/3/12.
//  Copyright © 2019 itheima. All rights reserved.
//

#import "LGMeTableViewController.h"
#import "UIBarButtonItem+Item.h"
#import "LGSettingTableViewController.h"
#import "LGSquareItem.h"
#import <MJExtension/MJExtension.h>
#import "LGSquareCollectionViewCell.h"
#import <SafariServices/SafariServices.h>
#import "AFHTTPSessionManager+Manager.h"

static NSInteger const cols = 4;
static CGFloat const margin = 1;
#define itemWH (LGScreenW - (cols - 1) * margin) / cols

static NSString *const ID = @"cell";

@interface LGMeTableViewController ()<UICollectionViewDataSource,UICollectionViewDelegate>

@property (nonatomic,strong) NSMutableArray *squareList;
@property (nonatomic,weak) UICollectionView *collectionView;

@end

@implementation LGMeTableViewController

-(void)setupFootView
{
    //创建布局
    UICollectionViewLayout *flowLayout = ({
        UICollectionViewFlowLayout *flowLayout = [[UICollectionViewFlowLayout alloc] init];
        flowLayout.itemSize = CGSizeMake(itemWH, itemWH);
        flowLayout.minimumLineSpacing = margin;
        flowLayout.minimumInteritemSpacing = margin;
        flowLayout;
    });
    //创建UICollectionView
    UICollectionView *collectionView = ({
        //UICollectionView默认是黑色
        UICollectionView *collectionView = [[UICollectionView alloc] initWithFrame:CGRectMake(0, 0, 0, 300) collectionViewLayout:flowLayout];
        collectionView.backgroundColor = [UIColor clearColor];
        collectionView.dataSource = self;
        collectionView.delegate = self;
        _collectionView = collectionView;
        collectionView;
    });
    self.tableView.tableFooterView = collectionView;
    //注册collectionView
    [collectionView registerNib:[UINib nibWithNibName:@"LGSquareCollectionViewCell" bundle:nil] forCellWithReuseIdentifier:ID];
}

#pragma mark UICollectionViewDelegate
- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    LGSquareItem *item = self.squareList[indexPath.row];
    NSURL *url = [NSURL URLWithString:item.url];
    SFSafariViewController *safariVc = [[SFSafariViewController alloc] initWithURL:url];
    [self presentViewController:safariVc animated:YES completion:nil];
}

#pragma mark - UICollectionViewDataSource
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return self.squareList.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    LGSquareCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:ID forIndexPath:indexPath];
    cell.item = _squareList[indexPath.row];
    cell.backgroundColor = [UIColor whiteColor];
    return cell;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    //设置导航条内容
    [self setupNavigationBar];
    //设置tableView底部视图
    [self setupFootView];
    //请求服务器数据
    [self loadData];
    //设置分组样式tableView的组间距
    self.tableView.sectionHeaderHeight = 0;
    self.tableView.sectionFooterHeight = 10;
    self.tableView.contentInset = UIEdgeInsetsMake(-25, 0, 0, 0);
}

- (void)loadData
{
    AFHTTPSessionManager *mgr = [AFHTTPSessionManager xl_manger];
    
    NSMutableDictionary *parameters = [NSMutableDictionary dictionary];
    parameters[@"a"] = @"square";
    parameters[@"c"] = @"topic";
    
    [mgr GET:LGBaseUrl parameters:parameters progress:nil success:^(NSURLSessionDataTask * _Nonnull task, NSDictionary *  _Nullable responseObject) {
        //字典数组转模型数组
        self.squareList = [LGSquareItem mj_objectArrayWithKeyValuesArray:responseObject[@"square_list"]];
        [self.squareList removeLastObject];
        //补齐缺口
        [self resloveData];
        //计算内容高度
        NSInteger rows = (self.squareList.count - 1) / cols + 1;
        CGFloat collectionH = rows * itemWH + (rows - 1) * margin;
        self.collectionView.xmg_height = collectionH;
        //刷新表格
        [self.collectionView reloadData];
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {

    }];
}

//补齐缺口
- (void)resloveData
{
    NSInteger count = self.squareList.count;
    NSInteger extre = count % cols;
    if (extre) {
        extre = cols - extre;
        for (int i = 0; i < extre; i++) {
            LGSquareItem *item = [[LGSquareItem alloc] init];
            [self.squareList addObject:item];
        }
    }
}

- (void)setupNavigationBar
{
    //设置导航条内容
    self.navigationItem.title = @"我的";
    //右边
    UIBarButtonItem *nightModeItem = [UIBarButtonItem itemWithImage:[UIImage imageNamed:@"mine-moon-icon"] imageSelected:[UIImage imageNamed:@"mine-sun-icon-click"] target:self action:@selector(nightModeClick:)];
    UIBarButtonItem *settingItem = [UIBarButtonItem itemWithImage:[UIImage imageNamed:@"mine-setting-icon"] highImage:[UIImage imageNamed:@"mine-setting-icon-click"] target:self action:@selector(settingClick)];
    self.navigationItem.rightBarButtonItems = @[settingItem,nightModeItem];
    
}

- (void)nightModeClick:(UIButton *)btn
{
    btn.selected = !btn.selected;
}

- (void)settingClick
{
    LGSettingTableViewController *settingTableViewController = [[LGSettingTableViewController alloc] init];
    settingTableViewController.hidesBottomBarWhenPushed = YES;
    [self.navigationController pushViewController:settingTableViewController animated:YES];
}


@end
