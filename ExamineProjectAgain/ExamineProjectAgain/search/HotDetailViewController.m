//
//  HotDetailViewController.m
//  QFTeacherText
//
//  Created by zhulei on 15/12/24.
//  Copyright (c) 2015年 zhulei. All rights reserved.
//

#import "HotDetailViewController.h"

@interface HotDetailViewController (){
    
    UIWebView *_webView;
}

@end

@implementation HotDetailViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    //创建一个webview 然后让webviewload一个网络请求
    _webView = [[UIWebView alloc]initWithFrame:self.view.bounds];
    
    [_webView loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"http://m.guoku.com/articles/%@/",self.urlId]]]];
    
    [self.view addSubview:_webView];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
