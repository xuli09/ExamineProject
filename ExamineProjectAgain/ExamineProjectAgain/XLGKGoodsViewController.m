//
//  XLGKGoodsViewController.m
//  ExamineProjectAgain
//
//  Created by xuli on 15/12/18.
//  Copyright © 2015年 xuli. All rights reserved.
//

#import "XLGKGoodsViewController.h"
#import "XLGKNet.h"
#import "XLActivity.h"
@interface XLGKGoodsViewController ()
@end

@implementation XLGKGoodsViewController

-(void)viewDidLoad
{
    [super viewDidLoad];
    
    XLGKNet * net = [[XLGKNet alloc]init];
    [net setupNetReachability];
    
    self.rootPath = GOODSPATH;
    [self startRequestInfo:GOODSPATH];
}
@end
