//
//  XLGKSettingViewController.m
//  ExamineProjectAgain
//
//  Created by xuli on 15/12/18.
//  Copyright © 2015年 xuli. All rights reserved.
//

#import "XLGKSettingViewController.h"
#import "UIImageView+AFNetworking.h"
#import "XLGKQRCodeViewController.h"

@interface XLGKSettingViewController ()
{
    UITableView * table;
    NSMutableArray * dataSource;
}
@end



@implementation XLGKSettingViewController

-(void)viewDidLoad
{
    //初始化表格视图
    table = [[UITableView alloc]initWithFrame:CGRectMake(0, 60, self.view.frame.size.width, self.view.frame.size.height - 60) style:UITableViewStyleGrouped];
    table.delegate = self;
    table.dataSource = self;
    [self.view addSubview:table];
    
    //初始化数据源信息
    dataSource = [[NSMutableArray alloc]init];
    NSArray * arr1 = @[@"微信分享",@"分享应用到微博",@"App Store评分",@"扫一扫"];
    NSArray * arr2 = @[@"清除图片缓存",@"意见反馈",@"版本"];
    [dataSource addObject:arr1];
    [dataSource addObject:arr2];
    
    //关闭视图控制器自动设置滚动视图显示位置的权限
    self.automaticallyAdjustsScrollViewInsets = NO;
    
    
    //添加登录按钮
    UIButton * btn = [UIButton buttonWithType:UIButtonTypeCustom];
    btn.frame = CGRectMake(0, 0, self.view.frame.size.width, 40);
    btn.backgroundColor = [UIColor cyanColor];
    [btn setTitle:@"登录" forState:UIControlStateNormal];
    [btn addTarget:self action:@selector(pressBtn:) forControlEvents:UIControlEventTouchUpInside];
    table.tableFooterView = btn;
}
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return dataSource.count;
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    NSArray * array = dataSource[section];
    return [array count];
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
        if(indexPath.row == 0)
        {
            
        }
        else if (indexPath.row == 1)
        {
            
        }
        else if(indexPath.row == 2)
        {
            
        }
        else
        {
            XLGKQRCodeViewController * qrCoderCtr = [[XLGKQRCodeViewController alloc]init];
            [self.navigationController pushViewController:qrCoderCtr animated:YES];
        }
    }
    else
    {
        if(indexPath.row == 0)
        {
            //添加警告框
            UIAlertController * alert = [UIAlertController alertControllerWithTitle:@"清除图片缓存" message:nil preferredStyle:UIAlertControllerStyleAlert];
            UIAlertAction * action1 = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
                
            }];
            
            UIAlertAction * action2 = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
                //清除图片缓存
                [UIImageView clearCache];
                
                //提示信息
                UIAlertController * alertCtr = [UIAlertController alertControllerWithTitle:@"清空成功" message: nil preferredStyle:UIAlertControllerStyleAlert];
                [self presentViewController:alertCtr animated:YES completion:^{
                    [alertCtr dismissViewControllerAnimated:YES completion:nil];
                }];
                
                
            }];
            
            [alert addAction:action1];
            [alert addAction:action2];
            
            [self presentViewController:alert animated:YES completion:nil];
            
        }
    }
}

@end
