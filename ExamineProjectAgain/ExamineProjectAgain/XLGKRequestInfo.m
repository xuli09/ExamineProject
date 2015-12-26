//
//  RequestInfo.m
//  ExamineProjectAgain
//
//  Created by xuli on 15/12/21.
//  Copyright © 2015年 xuli. All rights reserved.
//

#import "XLGKRequestInfo.h"
#import "AFHTTPRequestOperationManager.h"
#import "MMProgressHUD.h"
@implementation XLGKRequestInfo

-(void)requestInfoFromPath:(NSString *)path
{
    //开始数据请求
    [MMProgressHUD setPresentationStyle:MMProgressHUDPresentationStyleExpand];
    
    [MMProgressHUD showDeterminateProgressWithTitle:nil status:@"正在加载..."];
    
    //<1>创建请求操作管理者对象
    AFHTTPRequestOperationManager * manager = [AFHTTPRequestOperationManager manager];
    manager.responseSerializer = [AFHTTPResponseSerializer serializer];
    [manager GET:path parameters:nil success:^(AFHTTPRequestOperation *operation, id responseObject) {
        if([self.delegate respondsToSelector:@selector(requestInfoWithData:)])
        {
            [self.delegate requestInfoWithData:responseObject];
        }
        else
        {
            NSLog(@"被动方没有实现协议的方法");
        }
        [MMProgressHUD dismissWithSuccess:@"加载成功"];
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        [MMProgressHUD dismissWithError:[NSString stringWithFormat:@"%@",error.description]];
        
    }];
}
@end
