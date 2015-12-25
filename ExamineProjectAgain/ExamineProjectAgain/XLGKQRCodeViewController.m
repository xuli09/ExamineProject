//
//  XLGKQRCodeViewController.m
//  ExamineProjectAgain
//
//  Created by xuli on 15/12/24.
//  Copyright © 2015年 xuli. All rights reserved.
//

#import "XLGKQRCodeViewController.h"
#import "Masonry.h"
#import "XLGKStartQRViewController.h"
#import "QRCodeGenerator.h"

#define RandomColor [UIColor colorWithRed:arc4random_uniform(256)/255.0 green:arc4random_uniform(256)/255.0 blue:arc4random_uniform(256)/255.0 alpha:1]

@interface XLGKQRCodeViewController ()<UITextFieldDelegate>

@property(nonatomic,strong)UIButton * startQR;
@property(nonatomic,strong)UITextField * textField;
@property(nonatomic,strong)UIButton * creatBtn;
@property(nonatomic,strong)UIImageView * outImageView;

@end

@implementation XLGKQRCodeViewController

-(void)viewWillAppear:(BOOL)animated
{
    self.navigationController.navigationBarHidden = NO;
}
- (void)viewDidLoad
{
    [super viewDidLoad];
    self.view.backgroundColor=[UIColor whiteColor];
    self.title = @"扫一扫";
    /**
     *  ios7之前我们实现二维码扫描一般是借助第三方来实现，但是在ios7之后系统自己提供二维码扫面的方法，而且用原生的方法性能要比第三方的要好很多，今天就写个小的demo来介绍一下系统的原生二维码扫描实现的过程
     *  部分代码借鉴高少东的支付宝开源项目做了一下整理和优化
     *  二维码参考样式无非就是支付宝和微信两大巨头的样式，今天仿写一下支付宝的二维码扫描
     *  顺便熟悉一下 masonry
     *
     */
    //创建扫一扫二维码的按钮
    _startQR=[UIButton buttonWithType:UIButtonTypeCustom];
    [_startQR setTitle:@"扫一扫" forState:UIControlStateNormal];
    [_startQR setBackgroundColor:[UIColor cyanColor]];
    [_startQR addTarget:self action:@selector(pressStartQRBtn:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:_startQR];
    
    //创建生成二维码的按钮
    _creatBtn=[UIButton buttonWithType:UIButtonTypeCustom];
    [_creatBtn setTitle:@"生成二维码" forState:UIControlStateNormal];
    [_creatBtn setBackgroundColor:[UIColor cyanColor]];
    [_creatBtn addTarget:self action:@selector(pressCreateQRBtn) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:_creatBtn];
    
    //设置生成二维码的图片视图
    _outImageView = [[UIImageView alloc]init];
    _outImageView.layer.borderWidth = 2.0f;
    _outImageView.layer.borderColor=[UIColor redColor].CGColor;
    UIImage *image=[UIImage imageNamed:@"6824500_006_thumb.jpg"];
    UIImage * tempImage = [QRCodeGenerator qrImageForString:@"ssssss" imageSize:360 Topimg:image withColor:RandomColor];
    _outImageView.image = tempImage;
    [self.view addSubview:_outImageView];
    
    //定义文本输入框 通过输入的内容 动态生成二维码
    _textField = [[UITextField alloc] init];
    _textField.placeholder =@"请输入二维码内容";
    _textField.delegate = self;
    _textField.layer.masksToBounds = YES;
    _textField.returnKeyType=UIReturnKeyDefault;
    _textField.clearButtonMode = UITextFieldViewModeWhileEditing;
    _textField.font = [UIFont boldSystemFontOfSize:15.0];
    _textField.borderStyle = UITextBorderStyleRoundedRect;
    [self.view addSubview:_textField];
}
#pragma mark UI的适配
-(void)viewDidLayoutSubviews
{
    //代码适配
    __weak __typeof(self)weakSelf  = self;
    [_textField mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.top.mas_equalTo(100);
        make.right.mas_equalTo(-10);
        make.left.mas_equalTo(10);
        make.height.mas_equalTo(80);
        
    }];
    
    [_startQR mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.top.mas_equalTo(weakSelf.textField.mas_bottom).offset(10);
        make.bottom.mas_equalTo(weakSelf.outImageView.mas_top).offset(-10);
        make.left.mas_equalTo(10);
        make.right.mas_equalTo(weakSelf.creatBtn.mas_left).offset(-10);
        make.height.mas_equalTo(80);
    }];
    
    [_creatBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.height.width.top.bottom.mas_equalTo(weakSelf.startQR);
        make.right.mas_equalTo(-10);
        make.left.mas_equalTo(weakSelf.startQR.mas_right).offset(10);
    }];
    
    [_outImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.mas_equalTo(10);
        make.right.mas_equalTo(-10);
        make.top.mas_equalTo(weakSelf.creatBtn.mas_bottom).offset(10);
        make.bottom.mas_equalTo(-10);
    }];
}
#pragma mark 二维码扫描
-(void)pressStartQRBtn:(id)sender
{
    
    XLGKStartQRViewController * vc=[[XLGKStartQRViewController alloc]init];
    [self.navigationController pushViewController:vc animated:YES];
}
#pragma mark 动态生成二维码
-(void)pressCreateQRBtn
{
    
    UIImage *image=[UIImage imageNamed:@"6824500_006_thumb.jpg"];
    NSString * tempStr;
    if(self.textField.text.length==0)
    {
        //默认内容
        tempStr=@"xuli";
        
    }
    else
    {
        tempStr=self.textField.text;
    }
    
    UIImage * tempImage = [QRCodeGenerator qrImageForString:tempStr imageSize:360 Topimg:image withColor:RandomColor];
    
    _outImageView.image = tempImage;
    
}
#pragma mark UITextFieldDelegate
-(BOOL)textFieldShouldReturn:(UITextField *)textField
{
    
    [textField resignFirstResponder];
    
    return YES;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
@end
