//
//  YZMainViewController.m
//  YZLiveApp
//
//  Created by yz on 16/8/29.
//  Copyright © 2016年 yz. All rights reserved.
//

#import "YZMainViewController.h"
#import "YZBroadcastListController.h"
#import "YZCaptureViewController.h"

@interface YZMainViewController ()

@end

@implementation YZMainViewController

/**
 *  采集视频
 *
 */
- (IBAction)caputureVideo:(id)sender {
    YZCaptureViewController *caputureVC = [[YZCaptureViewController alloc] init];
    [self.navigationController pushViewController:caputureVC animated:YES];
}

/**
 *  主播列表
 *
 */
- (IBAction)playVideo:(id)sender {
    YZBroadcastListController *broadcastVC = [[YZBroadcastListController alloc] init];
    [self.navigationController pushViewController:broadcastVC animated:YES];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.title = @"直播功能";
    
}


@end
