//
//  LSScanViewController.m
//  LSSureApp
//
//  Created by zhulei on 15-12-19.
//  Copyright (c) 2015年 qianfeng. All rights reserved.
//

#import "LSScanViewController.h"
#import <AVFoundation/AVFoundation.h>//需要添加AVFoundation系统库
#define WIDTH [UIScreen mainScreen].bounds.size.width

#define HEIGHT [UIScreen mainScreen].bounds.size.height
@interface LSScanViewController ()<AVCaptureMetadataOutputObjectsDelegate,UIAlertViewDelegate>//遵守相应代理
@property (strong,nonatomic) AVCaptureDevice * device;//采集的设备
@property (strong,nonatomic) AVCaptureDeviceInput * input;//设备的输入
@property (strong,nonatomic) AVCaptureMetadataOutput * output;//输出
@property (strong,nonatomic) AVCaptureSession * session;//采集流
@property (strong,nonatomic) AVCaptureVideoPreviewLayer * preview;//窗口
@property (strong,nonatomic) UIImageView * QrCodeline;
@property (strong,nonatomic) UIImageView * scanScreen;

@end

@implementation LSScanViewController
- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    self.navigationController.navigationBarHidden = NO;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = [UIColor whiteColor];
    
    self.title = @"二维码扫描";
    
    [self scanQRView];
    // Do any additional setup after loading the view, typically from a nib.
}
- (void)scanQRView{
    // Device 实例化设备
    _device = [AVCaptureDevice defaultDeviceWithMediaType:AVMediaTypeVideo];
    
    // Input 设备输入
    _input = [AVCaptureDeviceInput deviceInputWithDevice:self.device error:nil];
    
    // Output 设备的输出
    _output = [[AVCaptureMetadataOutput alloc]init];
    [_output setMetadataObjectsDelegate:self queue:dispatch_get_main_queue()];
    
    // Session
    _session = [[AVCaptureSession alloc]init];
    [_session setSessionPreset:AVCaptureSessionPresetHigh];
    if ([_session canAddInput:self.input])
    {
        [_session addInput:self.input];
    }
    
    if ([_session canAddOutput:self.output])
    {
        [_session addOutput:self.output];
    }
    
    // 条码类型 AVMetadataObjectTypeQRCode
    _output.metadataObjectTypes = @[AVMetadataObjectTypeCode128Code,AVMetadataObjectTypeUPCECode,AVMetadataObjectTypeCode39Code,AVMetadataObjectTypeCode39Mod43Code,AVMetadataObjectTypeEAN13Code,AVMetadataObjectTypeEAN8Code,AVMetadataObjectTypeCode93Code,AVMetadataObjectTypePDF417Code,AVMetadataObjectTypeQRCode,AVMetadataObjectTypeAztecCode,AVMetadataObjectTypeInterleaved2of5Code,AVMetadataObjectTypeITF14Code,AVMetadataObjectTypeDataMatrixCode];
    
    // Preview 扫描窗口设置
    _preview = [AVCaptureVideoPreviewLayer layerWithSession:self.session];
    _preview.videoGravity = AVLayerVideoGravityResizeAspectFill;
    _preview.frame = CGRectMake(0,0,WIDTH,HEIGHT- 64);
    [self.view.layer insertSublayer:_preview atIndex:0];
    
    //扫描窗口界面
    _scanScreen = [[UIImageView alloc]initWithFrame:CGRectMake(20, 100, WIDTH - 40, 280)];
    
    _scanScreen.image = [UIImage imageNamed:@"qrcode_scan_full_net"];
    
    [self.view addSubview:_scanScreen];
    
    //滚动滑线
    _QrCodeline = [[UIImageView alloc]initWithFrame:CGRectMake(0, 100, WIDTH, 2)];
    
    _QrCodeline.image = [UIImage imageNamed:@"qrcode_scan_light_green@2x"];
    
    [self.view addSubview:_QrCodeline];
    
    [NSTimer scheduledTimerWithTimeInterval:1.0 target:self selector:@selector(moveUpAndDownLine) userInfo:nil repeats:YES];
    
    // Start 开始扫描
    [_session startRunning];
}
//二维码的横线移动
- (void)moveUpAndDownLine
{
    CGFloat Y=_QrCodeline.frame.origin.y;
    if (self.view.bounds.size.width - 2 * 20 + 100 == Y){
        
        [UIView beginAnimations:@"asa" context:nil];
        [UIView setAnimationDuration:1];
        _QrCodeline.frame=CGRectMake(20, 100, WIDTH - 2 * 20,1);
        [UIView commitAnimations];
    }else if(100 == Y){
        [UIView beginAnimations:@"asa" context:nil];
        [UIView setAnimationDuration:1];
        _QrCodeline.frame = CGRectMake(20, WIDTH - 2 * 20 + 100, WIDTH - 2 * 20,1);
        [UIView commitAnimations];
    }
    
}
//解析结果的代理方法
#pragma mark AVCaptureMetadataOutputObjectsDelegate
- (void)captureOutput:(AVCaptureOutput *)captureOutput didOutputMetadataObjects:(NSArray *)metadataObjects fromConnection:(AVCaptureConnection *)connection
{
    //得到解析到的结果
    NSString *stringValue;
    
    if ([metadataObjects count] > 0)
    {
        AVMetadataMachineReadableCodeObject * metadataObject = [metadataObjects objectAtIndex:0];
        stringValue = metadataObject.stringValue;
    }
    
    [_session stopRunning];//停止扫描
    
    UIAlertView * alert = [[UIAlertView alloc]initWithTitle:@"提示" message:[NSString stringWithFormat:@"%@",stringValue] delegate:self cancelButtonTitle:nil otherButtonTitles:@"跳转",@"重新扫描",  nil];
    
    [alert show];
}
- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    if(buttonIndex == 0)
    {
        NSURL *url = [NSURL URLWithString:alertView.title];
        
        UIApplication *application = [UIApplication sharedApplication];
        if(![application canOpenURL:url]){
            NSLog(@"无法打开\"%@\"，请确保此应用已经正确安装.",url);
            return;
        }
        [[UIApplication sharedApplication] openURL:url];
    }
    else
    {
        //重新扫描
        [_session startRunning];
    }
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
