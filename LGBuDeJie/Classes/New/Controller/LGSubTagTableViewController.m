//
//  LGSubTagTableViewController.m
//  LGBuDeJie
//
//  Created by 甘延娇 on 2019/3/22.
//  Copyright © 2019 itheima. All rights reserved.
//

#import "LGSubTagTableViewController.h"
#import "AFHTTPSessionManager+Manager.h"
#import "LGSubTagItem.h"
#import <MJExtension/MJExtension.h>
#import "LGSubTagTableViewCell.h"

@interface LGSubTagTableViewController ()

@property (nonatomic,strong) NSArray *tags;

@end

@implementation LGSubTagTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    self.tableView.backgroundColor = [UIColor customColor];
    //发送网络请求加载数据
    [self loadData];
}

- (void)loadData
{
    AFHTTPSessionManager *mgr = [AFHTTPSessionManager xl_manger];
    NSMutableDictionary *parameters = [NSMutableDictionary dictionary];
    parameters[@"a"] = @"tag_recommend";
    parameters[@"c"] = @"topic";
    parameters[@"action"] = @"sub";
    [mgr GET:LGBaseUrl parameters:parameters progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        //字典数组转模型数组
        self.tags = [LGSubTagItem mj_objectArrayWithKeyValuesArray:responseObject];
        
        [self.tableView reloadData];
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        
    }];
}

#pragma mark - Table view data source
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.tags.count;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *ID = @"cell";
    LGSubTagTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:ID];
    if (cell == nil) {
        cell = [LGSubTagTableViewCell cell];
    }
    cell.item = self.tags[indexPath.row];
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 60 + 10;
}

@end
