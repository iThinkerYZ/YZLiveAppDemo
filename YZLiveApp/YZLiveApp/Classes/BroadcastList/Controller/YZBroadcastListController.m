//
//  BroadcastListController.m
//  YZLiveApp
//
//  Created by yz on 16/9/2.
//  Copyright © 2016年 yz. All rights reserved.
//

#import "YZBroadcastListController.h"
#import "YZLiveViewController.h"
#import "YZLiveCell.h"
#import <AFNetworking.h>
#import <MJExtension.h>
#import "YZLiveItem.h"
static NSString * const ID = @"cell";
@interface YZBroadcastListController ()
/** 直播 */
@property(nonatomic, strong) NSMutableArray *lives;

@end

@implementation YZBroadcastListController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.title = @"直播列表";
    
    // 加载数据
    [self loadData];
    
    [self.tableView registerNib:[UINib nibWithNibName:@"YZLiveCell" bundle:nil] forCellReuseIdentifier:ID];
    
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
        
        [self.tableView reloadData];
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        
        NSLog(@"%@",error);
        
    }];
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