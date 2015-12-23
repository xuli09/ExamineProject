//
//  RequestInfo.m
//  ExamineProjectAgain
//
//  Created by xuli on 15/12/21.
//  Copyright © 2015年 xuli. All rights reserved.
//

#import "XLGKRequestInfo.h"
#import "AFHTTPRequestOperationManager.h"
@implementation XLGKRequestInfo

-(void)requestInfoFromPath:(NSString *)path
{
    
    [self setupNetReachability];
    //<1>创建请求操作管理者对象
    AFHTTPRequestOperationManager * manager = [AFHTTPRequestOperationManager manager];
    manager.responseSerializer = [AFHTTPResponseSerializer serializer];
    [manager GET:@"http://api.guoku.com/mobile/v4/selection/?api_key=0b19c2b93687347e95c6b6f5cc91bb87&count=30&rcat=0&sign=b65e2e01c27a4c5d8eaf872d87fe3995&timestamp=1450167649.621674" parameters:nil success:^(AFHTTPRequestOperation *operation, id responseObject) {
        if([self.delegate respondsToSelector:@selector(requestInfoWithData:)])
        {
            [self.delegate requestInfoWithData:responseObject];
        }
        else
        {
            NSLog(@"被动方没有实现协议的方法");
        }
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        NSLog(@"%@",error.description);
    }];
}
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
