//
//  RequestInfo.h
//  ExamineProjectAgain
//
//  Created by xuli on 15/12/21.
//  Copyright © 2015年 xuli. All rights reserved.
//

#import <Foundation/Foundation.h>

//创建协议
@protocol sendRequestInfo <NSObject>

-(void)requestInfoWithData:(NSData *)data;

@end

@interface XLGKRequestInfo : NSObject

//设置代理
@property (nonatomic,strong) id<sendRequestInfo>delegate;

//开始数据请求 并实时判断当前的网络
-(void)requestInfoFromPath:(NSString *)path;

@end
