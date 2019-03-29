//
//  LGBaseViewController.m
//  LGBuDeJie
//
//  Created by 甘延娇 on 2019/3/14.
//  Copyright © 2019 itheima. All rights reserved.
//

#import "LGBaseViewController.h"
#import "LGBaseTopicTableViewController.h"

static NSString * const ID = @"cell";

@interface LGBaseViewController ()<UICollectionViewDataSource,UICollectionViewDelegate>

@property (nonatomic,weak) UIScrollView *topScrollView;
@property (nonatomic,weak) UICollectionView *bottomCollectionView;
@property (nonatomic,weak) UIButton *selectedButton;
@property (nonatomic,strong) NSMutableArray *btns;
@property (nonatomic,weak) UIView *underLine;
@property (nonatomic,assign) BOOL isInitial;

@end

@implementation LGBaseViewController

- (NSMutableArray *)btns
{
    if (_btns == nil) {
        _btns = [NSMutableArray array];
    }
    return _btns;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor redColor];
    //添加底部内容View
    [self setupButtonContainerView];
    //添加顶部标题View
    [self setupTopTitleView];
    //取消自动添加额外滚动区域
    self.automaticallyAdjustsScrollViewInsets = NO;
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
    if (_isInitial == NO) {
        //添加所有标题按钮
        [self setupAllTitleButton];
        _isInitial = YES;
    }
}

#pragma mark --- 点击标题的时候会调用
- (void)titleClick:(UIButton *)button
{
    NSInteger i = button.tag;
    
    if (button == self.selectedButton) {
        //获取当前控制器
        LGBaseTopicTableViewController *baseTopicTableViewController = self.childViewControllers[i];
        //刷新当前控制器的View
        [baseTopicTableViewController reload];
    }
    
    [self selButton:button];
    
    //滚动对应的位置
    CGFloat offsetX = i * LGScreenW;
    _bottomCollectionView.contentOffset = CGPointMake(offsetX, 0);
}

#pragma mark --- 选中标题
- (void)selButton:(UIButton *)button
{
    _selectedButton.selected = NO;
    button.selected = YES;
    _selectedButton = button;
    //移动下划线
    [UIView animateWithDuration:0.25 animations:^{
        self.underLine.xmg_centerX = button.xmg_centerX;
    }];
}

- (void)setupAllTitleButton
{
    NSUInteger count = self.childViewControllers.count;
    CGFloat btnX = 0;
    CGFloat btnW = LGScreenW / count;
    CGFloat btnH = _topScrollView.xmg_height;
    for (int i = 0; i < count; i++) {
        btnX = i * btnW;
        UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
        btn.tag = i;
        UIViewController *vc = self.childViewControllers[i];
        [btn setTitle:vc.title forState:UIControlStateNormal];
        btn.frame = CGRectMake(btnX, 0, btnW, btnH);
        [_topScrollView addSubview:btn];
        btn.titleLabel.font = [UIFont systemFontOfSize:15];
        [btn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        [btn setTitleColor:[UIColor redColor] forState:UIControlStateSelected];
        
        [btn addTarget:self action:@selector(titleClick:) forControlEvents:UIControlEventTouchUpInside];
        
        [self.btns addObject:btn];
        
        if (i == 0) {
            //添加下划线
            UIView *underLine = [[UIView alloc] init];
            underLine.backgroundColor = [UIColor redColor];
            [_topScrollView addSubview:underLine];
            _underLine = underLine;
            [btn.titleLabel sizeToFit];
            
            underLine.xmg_width = btn.titleLabel.xmg_width;
            underLine.xmg_height = 2;
            underLine.xmg_centerX = btn.xmg_centerX;
            underLine.xmg_y = _topScrollView.xmg_height - underLine.xmg_height;
            
            [self titleClick:btn];
        }
    }
}

- (void)setupButtonContainerView
{
    UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc] init];
    layout.itemSize = [UIScreen mainScreen].bounds.size;
    layout.scrollDirection = UICollectionViewScrollDirectionHorizontal;
    layout.minimumLineSpacing = 0;
    layout.minimumInteritemSpacing = 0;
    //UICollectionView
    UICollectionView *collectionView = [[UICollectionView alloc] initWithFrame:[UIScreen mainScreen].bounds collectionViewLayout:layout];
    collectionView.backgroundColor = [UIColor lightGrayColor];
    collectionView.dataSource = self;
    collectionView.delegate = self;
    [collectionView registerClass:[UICollectionViewCell class] forCellWithReuseIdentifier:ID];
    [self.view addSubview:collectionView];
    _bottomCollectionView = collectionView;
    
    collectionView.showsVerticalScrollIndicator = NO;
    collectionView.showsHorizontalScrollIndicator = NO;
    collectionView.bounces = NO;
    collectionView.pagingEnabled = YES;
}

- (void)setupTopTitleView
{
    //UIScrollView
    CGFloat y = self.navigationController.navigationBarHidden == YES?30:88;
    UIScrollView *scrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, y, LGScreenW, 35)];
    scrollView.backgroundColor = [UIColor colorWithWhite:1 alpha:0.6];
    [self.view addSubview:scrollView];
    _topScrollView = scrollView;
}

#pragma mark UICollectionViewDataSource
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return self.childViewControllers.count;
}

//每次只要有新的cell出现就会调用
- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    UICollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:ID forIndexPath:indexPath];
    //移除之前子控制器的View
    [cell.contentView.subviews makeObjectsPerformSelector:@selector(removeFromSuperview)];
    //切换子控制器的View
    UITableViewController *vc = self.childViewControllers[indexPath.row];
    //不让tableView内容被挡住
    vc.tableView.contentInset = UIEdgeInsetsMake(self.topScrollView.xmg_height, 0, 0, 0);
    //控制器View尺寸，一开是就不对
    vc.view.frame = [UIScreen mainScreen].bounds;
    [cell.contentView addSubview:vc.view];
    return cell;
}

#pragma mark -UICollectionViewDeledate
//滚动完成的时候调用
- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView
{
    NSInteger page = scrollView.contentOffset.x / LGScreenW;
    UIButton *btn = self.btns[page];
    [self selButton:btn];
}

@end
