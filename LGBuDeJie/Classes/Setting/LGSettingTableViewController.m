//
//  LGSettingTableViewController.m
//  LGBuDeJie
//
//  Created by 甘延娇 on 2019/3/13.
//  Copyright © 2019 itheima. All rights reserved.
//

#import "LGSettingTableViewController.h"
#import <SDImageCache.h>
#import "LGFileManager.h"
#import <SVProgressHUD.h>

static NSString * const ID = @"cell";

@interface LGSettingTableViewController ()

@property (nonatomic,strong) NSString *str;

@end

@implementation LGSettingTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [SVProgressHUD showWithStatus:@"正在计算缓存尺寸"];
    
    [LGFileManager directorySizeString:CachePath completion:^(NSString *str) {
        [SVProgressHUD dismiss];
        self.str = str;
        [self.tableView reloadData];
    }];
    
    [self.tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:ID];
}

#pragma mark - Table view data source
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 1;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:ID];
    
    cell.textLabel.text = _str;
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    //清除缓存
    [LGFileManager removeDirectoryPath:CachePath];
    
    _str = @"清除缓存";
    
    //刷新表格
    [self.tableView reloadData];
}
@end
