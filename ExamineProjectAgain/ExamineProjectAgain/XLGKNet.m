//
//  XLGKNet.m
//  ExamineProjectAgain
//
//  Created by xuli on 15/12/24.
//  Copyright © 2015年 xuli. All rights reserved.
//

#import "XLGKNet.h"
#import "AFHTTPRequestOperationManager.h"
@implementation XLGKNet
-(void)setupNetReachability
{
    //<1>创建请求操作管理者对象
    AFHTTPRequestOperationManager * manager = [AFHTTPRequestOperationManager manager];
    //获取当前的网络状态
    [manager.reachabilityManager setReachabilityStatusChangeBlock:^(AFNetworkReachabilityStatus status) {
        NSString * string = nil;
        
        if(status == AFNetworkReachabilityStatusReachableViaWiFi)
        {
            string = @"WIFI";
        }
        else if (status == AFNetworkReachabilityStatusReachableViaWWAN)
        {
            string = @"3G/4G/GPRS";
        }
        else if (status == AFNetworkReachabilityStatusUnknown)
        {
            string = @"未知";
        }
        else if(status == AFNetworkReachabilityStatusNotReachable)
        {
            string = @"无网络";
        }
        
        UIAlertView * alertView = [[UIAlertView alloc]initWithTitle:@"检测当前网络状态" message:string delegate:nil cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
        [alertView show];
        
    }];
    //开始测试
    [manager.reachabilityManager startMonitoring];
}

@end
