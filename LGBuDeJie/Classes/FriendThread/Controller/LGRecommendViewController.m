//
//  LGRecommendViewController.m
//  LGBuDeJie
//
//  Created by 甘延娇 on 2019/3/27.
//  Copyright © 2019 itheima. All rights reserved.
//

#import "LGRecommendViewController.h"
#import "LGCategoryTableViewCell.h"
#import "AFHTTPSessionManager+Manager.h"
#import <MJExtension/MJExtension.h>
#import "LGCategoryItem.h"
#import "LGUserTableViewCell.h"
#import "LGUserModel.h"
#import <MJRefresh/MJRefresh.h>

static NSString * const categoryID = @"categoryCell";
static NSString * const userID = @"userCell";

@interface LGRecommendViewController ()<UITableViewDataSource,UITableViewDelegate>

@property (weak, nonatomic) IBOutlet UITableView *categoryTableView;
@property (weak, nonatomic) IBOutlet UITableView *userTableView;
@property (nonatomic,strong) NSArray *categorys;
@property (nonatomic,strong) LGCategoryItem *selectedCategory;
@property (nonatomic,strong) AFHTTPSessionManager *mgr;

@end

@implementation LGRecommendViewController

- (AFHTTPSessionManager *)mgr
{
    if (_mgr == nil) {
        _mgr = [AFHTTPSessionManager xl_manger];
    }
    return _mgr;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    //设置tableView
    [self setupTableView];
    //加载分类数据
    [self loadCategoryData];
    //上下拉添加更多数据
    [self setupRefresh];
}

- (void)setupRefresh
{
    MJRefreshNormalHeader *header = [MJRefreshNormalHeader headerWithRefreshingTarget:self refreshingAction:@selector(loadNewUserData)];
    self.userTableView.mj_header = header;
    
    MJRefreshAutoNormalFooter *footer = [MJRefreshAutoNormalFooter footerWithRefreshingTarget:self refreshingAction:@selector(loadMoreUserData)];
    self.userTableView.mj_footer = footer;
}
//加载更多用户数据
- (void)loadMoreUserData
{
    [self.mgr.tasks makeObjectsPerformSelector:@selector(cancel)];
    
    NSMutableDictionary *parameters = [NSMutableDictionary dictionary];
    parameters[@"a"] = @"list";
    parameters[@"c"] = @"subscribe";
    //获取当前分类ID
    parameters[@"category_id"] = @(self.selectedCategory.id);
    parameters[@"page"] = @(self.selectedCategory.page);
    
    [self.mgr GET:LGBaseUrl parameters:parameters progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        
         self.selectedCategory.page ++;
        
        [self.userTableView.mj_footer endRefreshing];
        
        NSArray *arr = [LGUserModel mj_objectArrayWithKeyValuesArray:responseObject[@"list"]];
        [self.selectedCategory.users addObjectsFromArray:arr];
        [self.userTableView reloadData];
        
        self.userTableView.mj_footer.hidden = self.selectedCategory.page > self.selectedCategory.total_page;
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        
    }];
}
//加载用户数据
- (void)loadNewUserData
{
    [self.mgr.tasks makeObjectsPerformSelector:@selector(cancel)];
    
    self.selectedCategory.page = 1;
    
    NSMutableDictionary *parameters = [NSMutableDictionary dictionary];
    parameters[@"a"] = @"list";
    parameters[@"c"] = @"subscribe";
    //获取当前分类ID
    parameters[@"category_id"] = @(self.selectedCategory.id);
    
    [self.mgr GET:LGBaseUrl parameters:parameters progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        
        self.selectedCategory.total_page = [responseObject[@"total_page"] integerValue];
        self.selectedCategory.page ++;
        
        [self.userTableView.mj_header endRefreshing];
        
        self.selectedCategory.users = [LGUserModel mj_objectArrayWithKeyValuesArray:responseObject[@"list"]];
        [self.userTableView reloadData];
        
        self.userTableView.mj_footer.hidden = self.selectedCategory.page > self.selectedCategory.total_page;
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        
    }];
}

//加载分类数据
- (void)loadCategoryData
{
    AFHTTPSessionManager *mgr = [AFHTTPSessionManager xl_manger];
    NSMutableDictionary *parameters = [NSMutableDictionary dictionary];
    parameters[@"a"] = @"category";
    parameters[@"c"] = @"subscribe";
    
    [mgr GET:LGBaseUrl parameters:parameters progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        
        self.categorys = [LGCategoryItem mj_objectArrayWithKeyValuesArray:responseObject[@"list"]];
        [self.categoryTableView reloadData];
        
        NSIndexPath *indexPath = [NSIndexPath indexPathForRow:0 inSection:0];
        [self.categoryTableView selectRowAtIndexPath:indexPath animated:YES scrollPosition:UITableViewScrollPositionNone];
        [self tableView:self.categoryTableView didSelectRowAtIndexPath:indexPath];
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        
    }];
}

- (void)setupTableView
{
    self.categoryTableView.dataSource = self;
    self.categoryTableView.delegate = self;
    self.userTableView.dataSource = self;
    
    self.categoryTableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    self.userTableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    
    [self.categoryTableView registerNib:[UINib nibWithNibName:NSStringFromClass([LGCategoryTableViewCell class]) bundle:nil] forCellReuseIdentifier:categoryID];
    
    [self.userTableView registerNib:[UINib nibWithNibName:NSStringFromClass([LGUserTableViewCell class]) bundle:nil] forCellReuseIdentifier:userID];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (tableView == _categoryTableView) {
        return self.categorys.count;
    }else{
        return self.selectedCategory.users.count;
    }
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (tableView == _categoryTableView) {
        
        LGCategoryTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:categoryID forIndexPath:indexPath];
        cell.category = self.categorys[indexPath.row];
        return cell;
    }else{
        
        LGUserTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:userID forIndexPath:indexPath];
        cell.user = self.selectedCategory.users[indexPath.row];
        return cell;
    }
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (tableView == _categoryTableView) {
        _selectedCategory = self.categorys[indexPath.row];
        
        [self.userTableView reloadData];
        
        self.userTableView.mj_footer.hidden = self.selectedCategory.page > self.selectedCategory.total_page;
        
        if (self.selectedCategory.users == nil) {
            
            self.userTableView.mj_footer.hidden = YES;
            
            [self.userTableView.mj_header beginRefreshing];
        }
    }
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (tableView == _categoryTableView) return 50;
    
    
    return 66;
}

@end
