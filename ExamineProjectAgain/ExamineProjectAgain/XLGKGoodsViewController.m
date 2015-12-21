//
//  XLGKGoodsViewController.m
//  ExamineProjectAgain
//
//  Created by xuli on 15/12/18.
//  Copyright © 2015年 xuli. All rights reserved.
//

#import "XLGKGoodsViewController.h"
#import "XLGKGoodsCell.h"

#define WIDTH self.view.frame.size.width
#define HEIGHT (self.view.frame.size.height - 60 - 44)

@interface XLGKGoodsViewController ()
{
    UITableView * myTableView;//创建表格视图
    NSMutableArray * dataSource;//添加数据源信息
}

@end

@implementation XLGKGoodsViewController

-(void)viewDidLoad
{
    [super viewDidLoad];
    [self createTableView];
    [self startRequestInfo];
}
-(void)createTableView
{
    //创建表格视图
    myTableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 60, WIDTH, HEIGHT) style:UITableViewStylePlain];
    myTableView.delegate = self;
    myTableView.dataSource = self;
    [self.view addSubview:myTableView];
    
    //初始化数据源信息
    dataSource = [[NSMutableArray alloc]init];
}
//开始请求数据
-(void)startRequestInfo
{
    
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return dataSource.count;
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString * string = @"string";
    XLGKGoodsCell * cell = [tableView dequeueReusableCellWithIdentifier:string];
    if(cell == nil)
    {
        cell = [[XLGKGoodsCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:string];
    }
    
    return cell;
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 368;
}
@end
