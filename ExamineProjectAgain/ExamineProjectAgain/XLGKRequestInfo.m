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
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        NSLog(@"%@",error.description);
    }];
}
@end
