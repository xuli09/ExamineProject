//
//  XLViewController.m
//  iOS4.5AFNetWorking进行POST请求
//
//  Created by MS on 15-10-15.
//  Copyright (c) 2015年 xuli. All rights reserved.
//

#import "XLViewController.h"
#import "Path.h"
#import "AFHTTPRequestOperationManager.h"
#import "XLAlbumViewController.h"
@interface XLViewController ()<UIAlertViewDelegate>
{
    XLAlbumViewController * album;
}

@end

@implementation XLViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
	album = [[XLAlbumViewController alloc]init];
    
    
    NSArray * textFieldArr = @[@"请输入用户名",@"请输入密码"];
    NSArray * btnArr = @[@"取消",@"登录"];
    NSArray * labelArr = @[@"用户名",@"密码"];
    
    for(int i = 0;i<2;i++)
    {
        UILabel * label = [[UILabel alloc]initWithFrame:CGRectMake(40, 100 + 50 * i, 60, 30)];
        label.text = labelArr[i];
        [self.view addSubview:label];
        
        UITextField * field = [[UITextField alloc]initWithFrame:CGRectMake(100, 100 + 50 * i, 160, 30)];
        field.placeholder = textFieldArr[i];
        field.textAlignment = NSTextAlignmentCenter;
        field.tag = 100 + i;
        [self.view addSubview:field];
        
        UIButton * btn = [UIButton buttonWithType:UIButtonTypeCustom];
        btn.frame = CGRectMake(50 + 150 * i, 300, 50, 30);
        [btn setTitle:btnArr[i] forState:UIControlStateNormal];
        [btn setTitleColor:[UIColor cyanColor] forState:UIControlStateNormal];
        [btn addTarget:self action:@selector(pressBtn:) forControlEvents:UIControlEventTouchUpInside];
        btn.tag = i + 1;
        [self.view addSubview:btn];
    }
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (void)pressBtn:(id)sender
{
    UIButton * btn = (UIButton *)sender;
    UITextField * field1 = (UITextField *)[self.view viewWithTag:100];
    UITextField * field2 = (UITextField *)[self.view viewWithTag:101];
    if(btn.tag == 1)
    {
        field1.text = @"";
        field2.text = @"";
    }
    else
    {
        //<1>创建请求操作管理者对象
        AFHTTPRequestOperationManager * manager = [AFHTTPRequestOperationManager manager];
        //<2>设置接收的数据类型（json、xml）
        manager.responseSerializer.acceptableContentTypes = [NSSet setWithObject:@"text/html"];
        //<3>拼接请求体
        //AFNetWorking中请求体是使用字典存放的
        //字典的键是参数名称 字典的值就是参数值（从键盘输入的内容）
        NSDictionary * dic = @{@"username":field1.text,@"password":field2.text};
        //<4>请求数据并解析
        [manager POST:LOGINPATH parameters:dic success:^(AFHTTPRequestOperation *operation, id responseObject)
        {
            NSString * code = responseObject[@"code"];
            NSString * message = responseObject[@"message"];
            
            //---------关键-------------
            NSString * token = responseObject[@"m_auth"];
            album.albumToken = token;
            //token用户的唯一标识
            
            
            if([code isEqualToString:@"login_success"])
            {
                UIAlertView * alertView = [[UIAlertView alloc]initWithTitle:@"提示" message:message delegate:self cancelButtonTitle:@"确定" otherButtonTitles:@"取消", nil];
                [alertView show];
                alertView.tag = 100;
            }
            else
            {
                UIAlertView * alert = [[UIAlertView alloc]initWithTitle:@"提示" message:message delegate:self cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
                [alert show];
            }
            
        } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
            NSLog(@"%@",error.description);
        }];
    }
}
#pragma mark UIAlertViewDelegate
-(void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    if(alertView.tag == 100)
    {
        if(buttonIndex == 0)
        {
            //跳转到相册界面
            [self presentViewController:album animated:YES completion:nil];
        }
    }
    else
    {
        UITextField * field1 = (UITextField *)[self.view viewWithTag:100];
        UITextField * field2 = (UITextField *)[self.view viewWithTag:101];

        field1.text = @"";
        field2.text = @"";
    }
}
-(void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    [self.view endEditing:YES];
}
@end
