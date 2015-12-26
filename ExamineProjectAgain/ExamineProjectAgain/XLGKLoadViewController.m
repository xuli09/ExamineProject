//
//  XLGKLoadViewController.m
//  ExamineProjectAgain
//
//  Created by xuli on 15/12/25.
//  Copyright © 2015年 xuli. All rights reserved.
//

#import "XLGKLoadViewController.h"
#import "AFHTTPRequestOperationManager.h"

//NSURLSession里面用三个任务 NSURLSessionDataTask 、NSURLSessionDownloadTask、NSURLSessionUploadTask
@interface XLGKLoadViewController ()<NSURLSessionDownloadDelegate>
{
    //定义NSURLSession对象
    NSURLSession * session;
    //创建下载任务对象
    NSURLSessionDownloadTask * task;
    //创建请求对象
    NSURLRequest * request;
    //定义一个NSData类型的变量 接收下载下来的数据
    NSData * data;
}


@end

@implementation XLGKLoadViewController

- (void)viewDidLoad {
    [super viewDidLoad];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)start:(id)sender
{
    //<1>创建NSURLSession的配置信息对象
    NSURLSessionConfiguration * configuration = [NSURLSessionConfiguration defaultSessionConfiguration];
    //<2>创建session对象 将配置信息与session对象进行关联
    session = [NSURLSession sessionWithConfiguration:configuration delegate:self delegateQueue:nil];
    
    //<3>将路径转化成NSURL
    NSURL * url = [NSURL URLWithString:self.imagePath];
    //<4>创建请求对象
    request = [NSURLRequest requestWithURL:url];
    //<5>进行数据请求
    task = [session downloadTaskWithRequest:request];
    //<6>开始请求
    NSLog(@"开始下载");
    [task resume];
}

- (IBAction)pause:(id)sender
{
    //暂停
    NSLog(@"暂停");
    [task cancelByProducingResumeData:^(NSData *resumeData) {
        //resumeData中存放的就是下载下来的数据
        data = resumeData;
    }];

}

- (IBAction)resume:(id)sender
{
    NSLog(@"恢复");
    if(!data)
    {
        NSURL * url = [NSURL URLWithString:self.imagePath];
        request = [NSURLRequest requestWithURL:url];
        task = [session downloadTaskWithRequest:request];
    }
    else
    {
        //继续下载
        task = [session downloadTaskWithResumeData:data];
    }
    [task resume];
}
#pragma mark NSURLSessionDownLoadDelegate
//下载结束
-(void)URLSession:(NSURLSession *)session downloadTask:(NSURLSessionDownloadTask *)downloadTask didFinishDownloadingToURL:(NSURL *)location
{
    //<1>获取存放信息的路径
    //获取图片的名称
    NSArray * pathArr = [self.imagePath componentsSeparatedByString:@"/"];
    NSString * lastPath = [pathArr lastObject];
    NSString * lastImageName = [[lastPath componentsSeparatedByString:@"."] firstObject];
    
    NSString * document = [NSHomeDirectory() stringByAppendingFormat:@"/Documents/%@.png",lastImageName];
    NSURL * url = [NSURL fileURLWithPath:document];
    
    //<2>通过文件管理对象将下载下来的文件路径移到url路径下
    NSFileManager * manager = [NSFileManager defaultManager];
    
    [manager moveItemAtURL:location toURL:url error:nil];
    
    //<3>修改主线程
    dispatch_async(dispatch_get_main_queue(), ^{
        //将文件下的内容读取出来添加到图片视图上
        NSData * imageData = [manager contentsAtPath:document];
        UIImage * image = [UIImage imageWithData:imageData];
        self.imageView.image = image;
    });
}
//获取下载进度
-(void)URLSession:(NSURLSession *)session downloadTask:(NSURLSessionDownloadTask *)downloadTask didWriteData:(int64_t)bytesWritten totalBytesWritten:(int64_t)totalBytesWritten totalBytesExpectedToWrite:(int64_t)totalBytesExpectedToWrite
{
    //totalBytesWritten此时下载的二进制数据大小
    //totalBytesExpectedToWrite 预期下载量
    CGFloat progress = (totalBytesWritten * 1.0)/totalBytesExpectedToWrite;
    
    //修改主线程进度条
    dispatch_async(dispatch_get_main_queue(), ^{
        self.progressView.progress = progress;
        NSLog(@"%f",self.progressView.progress);
    });
}

@end
