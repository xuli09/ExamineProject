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
#import "UMSocial.h"
#import "XLViewController.h"
@interface XLGKSettingViewController ()<UMSocialUIDelegate>
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
    NSArray * arr1 = @[@"分享到微博",@"App Store评分",@"扫一扫"];
    NSArray * arr2 = @[@"清除图片缓存",@"意见反馈",@"POST上传下载",@"本地推送"];
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
-(void)pressBtn:(id)sender
{
    NSLog(@"登录");
}
#pragma mark UITableViewDelegate
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
       if (indexPath.row == 0)
        {
            //分享操作...友盟分享、ShareSDK分享
            /*
             shareText分享的文字
             shareImage分享的图片
             shareToSnsNames:分享的渠道
             delegate:代理方法
             */
            [UMSocialSnsService presentSnsIconSheetView:self appKey:@"5640990267e58e77f8001408" shareText:@"测试ing~~~" shareImage:[UIImage imageNamed:@"ni_png_0968.png"] shareToSnsNames:@[UMShareToSina,UMShareToRenren,UMShareToEmail] delegate:self];
        }
        else if(indexPath.row == 1)
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
        else if (indexPath.row == 2)
        {
            
            //POST 上传下载
            XLViewController * viewController = [[XLViewController alloc]init];
            [self.navigationController pushViewController:viewController  animated:YES];
            
        }
        else if (indexPath.row == 3)
        {
            dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
                
                UILocalNotification *noti = [[UILocalNotification alloc]init];
                
                NSDate *pushDate = [NSDate dateWithTimeIntervalSinceNow:3];
                
                if (noti != nil) {
                    
                    noti.fireDate = pushDate;
                    
                    noti.timeZone = [NSTimeZone defaultTimeZone];
                    
                    noti.repeatInterval= kCFCalendarUnitDay;
                    
                    noti.soundName = UILocalNotificationDefaultSoundName;
                    
                    noti.alertBody = @"到点了,该吃饭了";
                    
                    noti.applicationIconBadgeNumber = 0;
                    
                    NSDictionary *info  = [NSDictionary dictionaryWithObjectsAndKeys:@"text",@"name",nil];
                    
                    noti.userInfo = info;
                    [[UIApplication sharedApplication] scheduleLocalNotification:noti];
                }
            });
        }
    }
}

@end
