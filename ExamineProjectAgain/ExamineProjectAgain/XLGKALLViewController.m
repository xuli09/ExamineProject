//
//  XLGKALLViewController.m
//  ExamineProjectAgain
//
//  Created by xuli on 15/12/23.
//  Copyright © 2015年 xuli. All rights reserved.
//

#import "XLGKALLViewController.h"
#import "XLGKGoodsCell.h"
#import "XLGKPictureCell.h"
#import "XLGKRequestInfo.h"
#import "XLGKGoodsInfo.h"
#import "XLGKGoodsViewController.h"
#import "XLGKPictureController.h"
#import "MJRefresh.h"
#import "XLActivity.h"
#import "XLGKPicDetailViewController.h"

#define WIDTH self.view.frame.size.width
#define HEIGHT (self.view.frame.size.height - 60 - 44)

@interface XLGKALLViewController ()<sendRequestInfo>
{
    UITableView * myTableView;//创建表格视图
    NSMutableArray * dataSource;//添加数据源信息
    XLActivity * activity;
}

@end

@implementation XLGKALLViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self createTableView];
    
    self.currentPage = 1;
    [self startLoading];
    [self startRefreshing];
    
}
#pragma mark 初始化UI
-(void)createTableView
{
    //创建表格视图
    myTableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, WIDTH, HEIGHT) style:UITableViewStylePlain];
    myTableView.delegate = self;
    myTableView.dataSource = self;
    [self.view addSubview:myTableView];
    
    //初始化数据源信息
    dataSource = [[NSMutableArray alloc]init];
    
    self.automaticallyAdjustsScrollViewInsets = NO;
    
    activity = [[XLActivity alloc]init];
}
#pragma mark 开始数据请求
//开始请求数据
-(void)startRequestInfo:(NSString *)path
{
    XLGKRequestInfo * requestInfo = [[XLGKRequestInfo alloc]init];
    requestInfo.delegate = self;
    //path = [NSString stringWithFormat:path,self.currentPage];
    [requestInfo requestInfoFromPath:path];
    
}
//实现协议中的方法
-(void)requestInfoWithData:(NSData *)data
{
    NSArray * array = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableContainers error:nil];
    //添加数据源刷新表格视图
    [dataSource addObjectsFromArray:array];
    [myTableView reloadData];
}
#pragma mark 表格协议方法
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return dataSource.count;
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString * string = nil;
    if([self isKindOfClass:[XLGKGoodsViewController class]])
    {
        string = @"string";
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
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        
        return cell;
    }
    else
    {
        string = @"cell";
        XLGKPictureCell * cell = [tableView dequeueReusableCellWithIdentifier:string];
        if(cell == nil)
        {
            cell = [[[NSBundle mainBundle] loadNibNamed:@"XLGKPictureCell" owner:self options:nil] lastObject];
        }
        
        NSDictionary * everyDic = dataSource[indexPath.row];
        [cell showInfoFromDic:everyDic];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        return cell;
    }
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if([self isKindOfClass:[XLGKGoodsViewController class]])
        return 420;
    else
        return 280;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if([self isKindOfClass:[XLGKPictureController class]])
    {
        XLGKPicDetailViewController * detail = [[XLGKPicDetailViewController alloc]init];
        UINavigationController * nav = [[UINavigationController alloc]initWithRootViewController:detail];
        detail.article_id = [dataSource[indexPath.row][@"article_id"] intValue];
        [self.navigationController pushViewController:nav animated:YES];
    }
    
}
#pragma mark 加载刷新
-(void)startLoading
{
    MJRefreshAutoGifFooter * footer = [MJRefreshAutoGifFooter footerWithRefreshingTarget:self refreshingAction:@selector(loadData)];
    NSArray * imageArr = @[[UIImage imageNamed:@"ni_png_0968.png"],[UIImage imageNamed:@"ni_png_0969.png"]];
    [footer setImages:imageArr duration:1 forState:MJRefreshStateRefreshing];
    [footer setImages:@[[UIImage imageNamed:@"ni_png_0968.png"]] duration:1 forState:MJRefreshStateIdle];
    [footer setTitle:@"准备加载" forState:MJRefreshStateIdle];
    
    [footer setImages:@[[UIImage imageNamed:@"ni_png_0969.png"]] duration:1 forState:MJRefreshStatePulling];
    [footer setTitle:@"正在加载" forState:MJRefreshStatePulling];
    
    myTableView.footer = footer;
//    myTableView.tableFooterView = activity;
//    [activity startAnimate];
}
-(void)loadData
{
    self.currentPage ++;
    [self startRequestInfo:self.rootPath];
    //[activity stopAnimate];
    [myTableView.footer endRefreshing];
}
-(void)startRefreshing
{
    MJRefreshGifHeader * header = [MJRefreshGifHeader headerWithRefreshingTarget:self refreshingAction:@selector(refreshFirstPageData)];
    //设置刷新不同状态下的图片信息
    NSArray * imageArr = @[[UIImage imageNamed:@"ni_png_0071.png"],[UIImage imageNamed:@"ni_png_0072.png"]];
    
    [header setImages:imageArr duration:0.5 forState:MJRefreshStateRefreshing];
    //闲置状态
    [header setImages:@[[UIImage imageNamed:@"ni_png_0071.png"]] duration:1 forState:MJRefreshStateIdle];
    [header setTitle:@"丽姐正在待命..." forState:MJRefreshStateIdle];
    
    
    //松开就可以刷新
    [header setImages:@[[UIImage imageNamed:@"ni_png_0072.png"]] duration:1 forState:MJRefreshStatePulling];
    [header setTitle:@"丽姐正在努力加载..." forState:MJRefreshStatePulling];
    
    myTableView.header = header;
//    myTableView.tableHeaderView = activity;
//    [activity startAnimate];
}
-(void)refreshFirstPageData
{
    //[dataSource removeAllObjects];
    self.currentPage = 1;
    [self startRequestInfo:self.rootPath];
    [myTableView.header endRefreshing];
    //[activity stopAnimate];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
@end
