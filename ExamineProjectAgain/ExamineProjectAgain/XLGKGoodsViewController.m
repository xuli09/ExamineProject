//
//  XLGKGoodsViewController.m
//  ExamineProjectAgain
//
//  Created by xuli on 15/12/18.
//  Copyright © 2015年 xuli. All rights reserved.
//

#import "XLGKGoodsViewController.h"
#import "XLGKGoodsCell.h"
#import "XLGKRequestInfo.h"
#import "Header.h"
#import "XLGKGoodsInfo.h"

#define WIDTH self.view.frame.size.width
#define HEIGHT (self.view.frame.size.height - 60 - 44)

@interface XLGKGoodsViewController ()<sendRequestInfo>
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
    myTableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 20, WIDTH, HEIGHT) style:UITableViewStylePlain];
    myTableView.delegate = self;
    myTableView.dataSource = self;
    [self.view addSubview:myTableView];
    
    //初始化数据源信息
    dataSource = [[NSMutableArray alloc]init];
    
    self.automaticallyAdjustsScrollViewInsets = NO;
}
//开始请求数据
-(void)startRequestInfo
{
    XLGKRequestInfo * requestInfo = [[XLGKRequestInfo alloc]init];
    requestInfo.delegate = self;
    [requestInfo requestInfoFromPath:GOODSPATH];
}
//实现协议中的方法
-(void)requestInfoWithData:(NSData *)data
{
    NSArray * array = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableContainers error:nil];
    NSLog(@"%@",array);
    //添加数据源刷新表格视图
    [dataSource addObjectsFromArray:array];
    [myTableView reloadData];
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
        cell = [[[NSBundle mainBundle] loadNibNamed:@"XLGKGoodsCell" owner:self options:nil]lastObject];
    }
    
    //获取每一行显示的商品的信息
    NSDictionary * goodsDic = dataSource[indexPath.row];
    NSString * postTimeStr = goodsDic[@"content"][@"note"][@"post_time"];
    NSString * picImageStr = goodsDic[@"content"][@"entity"][@"chief_image"];
    NSString * contentStr = goodsDic[@"content"][@"note"][@"content"];
    NSString * likeCount = [NSString stringWithFormat:@"%@",goodsDic[@"content"][@"note"][@"creator"][@"like_count"]];
    NSLog(@"%@",likeCount);
    XLGKGoodsInfo * goods = [[XLGKGoodsInfo alloc]init];
    goods.chief_image = picImageStr;
    goods.content = contentStr;
    goods.like_count = likeCount;
    goods.post_time = postTimeStr;
    
    //将商品信息添加到单元格上
    [cell showInfoEveryGoods:goods];
    
    return cell;
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 420;
}
@end
