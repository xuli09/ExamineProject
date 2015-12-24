//
//  XLGKALLViewController.h
//  ExamineProjectAgain
//
//  Created by xuli on 15/12/23.
//  Copyright © 2015年 xuli. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Header.h"

@interface XLGKALLViewController : UIViewController<UITableViewDataSource,UITableViewDelegate>
{
    BOOL isRefreshing;
    BOOL isLoading;
}
//接收子类传递过来的请求数据的借口
@property (nonatomic,copy) NSString * rootPath;
@property (nonatomic,assign) int currentPage;

//开始请求数据
-(void)startRequestInfo:(NSString *)path;

//开始加载
-(void)startLoading;

//开始刷新
-(void)startRefreshing;

@end
