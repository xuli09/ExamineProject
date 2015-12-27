//
//  XLGKGoodsViewController.m
//  ExamineProjectAgain
//
//  Created by xuli on 15/12/18.
//  Copyright © 2015年 xuli. All rights reserved.
//

#import "XLGKGoodsViewController.h"
#import "XLGKNet.h"
@interface XLGKGoodsViewController ()
@end

@implementation XLGKGoodsViewController

-(void)viewDidLoad
{
    [super viewDidLoad];
    
    //添加网络状态实时监测
    XLGKNet * net = [[XLGKNet alloc]init];
    [net setupNetReachability];
    
    //设置每个子视图显示数据的接口
    self.rootPath = GOODSPATH;
    [self startRequestInfo:GOODSPATH];
}
@end
