//
//  YZMainViewController.m
//  YZLiveApp
//
//  Created by yz on 16/8/29.
//  Copyright © 2016年 yz. All rights reserved.
//

#import "YZMainViewController.h"
#import "YZLiveViewController.h"
#import "YZLiveCell.h"
#import <AFNetworking.h>
#import <MJExtension.h>
#import "YZLiveItem.h"

static NSString * const ID = @"cell";
@interface YZMainViewController ()<UITableViewDataSource,UITableViewDelegate>
/** 直播 */
@property(nonatomic, strong) NSMutableArray *lives;
@property (nonatomic, weak) IBOutlet UITableView *tableView;
@end

@implementation YZMainViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    // 添加tableView
    [self setupTableView];
    
    // 加载数据
    [self loadData];
    
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
}

- (void)loadData
{
    // 映客数据url
    NSString *urlStr = @"http://116.211.167.106/api/live/aggregation?uid=133825214&interest=1";

    // 请求数据
    AFHTTPSessionManager *mgr = [AFHTTPSessionManager manager];
    mgr.responseSerializer = [AFJSONResponseSerializer serializer];
    mgr.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"text/plain", nil];
    [mgr GET:urlStr parameters:nil progress:nil success:^(NSURLSessionDataTask * _Nonnull task, NSDictionary * _Nullable responseObject) {
        
        _lives = [YZLiveItem mj_objectArrayWithKeyValuesArray:responseObject[@"lives"]];

        [_tableView reloadData];
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        
        NSLog(@"%@",error);
        
    }];
}

// 添加collectionView
- (void)setupTableView
{
   
    
    [_tableView registerNib:[UINib nibWithNibName:@"YZLiveCell" bundle:nil] forCellReuseIdentifier:ID];
    
    // 数据源
    _tableView.dataSource = self;
    _tableView.delegate = self;
    
    [self.view addSubview:_tableView];
}

#pragma mark - UITableViewDataSource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return _lives.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    YZLiveCell *cell = [tableView dequeueReusableCellWithIdentifier:ID];
    
    cell.live = _lives[indexPath.row];
    
    return cell;
}

#pragma mark - UITableViewDelegate
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    YZLiveViewController *liveVc = [[YZLiveViewController alloc] init];
    liveVc.live = _lives[indexPath.row];
    
    [self presentViewController:liveVc animated:YES completion:nil];
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
   
    return 430;
}

@end
