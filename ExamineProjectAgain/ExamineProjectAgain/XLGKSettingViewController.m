//
//  XLGKSettingViewController.m
//  ExamineProjectAgain
//
//  Created by xuli on 15/12/18.
//  Copyright © 2015年 xuli. All rights reserved.
//

#import "XLGKSettingViewController.h"

@interface XLGKSettingViewController ()
{
    UITableView * table;
    NSMutableArray * dataSource;
}
@end


@implementation XLGKSettingViewController

-(void)viewDidLoad
{
    table = [[UITableView alloc]initWithFrame:CGRectMake(0, 60, self.view.frame.size.width, self.view.frame.size.height - 60) style:UITableViewStyleGrouped];
    table.delegate = self;
    table.dataSource = self;
    [self.view addSubview:table];
    
    dataSource = [[NSMutableArray alloc]init];
    NSArray * arr1 = @[@"微信分享",@"分享应用到微博",@"App Store评分",@"扫一扫"];
    NSArray * arr2 = @[@"清除图片缓存",@"意见反馈",@"版本"];
    [dataSource addObject:arr1];
    [dataSource addObject:arr2];
    
    self.automaticallyAdjustsScrollViewInsets = NO;
}
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return dataSource.count;
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [dataSource[section] count];
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
     static NSString * string = @"string";
    UITableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:string];
    if(cell == nil)
    {
        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:string];
    }
    cell.textLabel.text = dataSource[indexPath.section][indexPath.row];
    
    return cell;
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if(indexPath.section == 0)
    {
        
    }
    else
    {
        
    }
}
@end
