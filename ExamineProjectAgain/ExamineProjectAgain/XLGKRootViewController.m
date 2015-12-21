//
//  XLGKRootViewController.m
//  ExamineProjectAgain
//
//  Created by xuli on 15/12/18.
//  Copyright © 2015年 xuli. All rights reserved.
//

#import "XLGKRootViewController.h"
#import "XLGKGoodsViewController.h"
#import "XLGKPictureController.h"

#define WIDTH self.view.frame.size.width
#define HEIGHT self.view.frame.size.height

@interface XLGKRootViewController ()

@property (nonatomic,strong) UIScrollView * myScrollView;
@property (nonatomic,retain) UIView * lineView;

@end

@implementation XLGKRootViewController
-(void)viewDidLoad
{
    [super viewDidLoad];
    [self createUI];
}
-(void)createUI
{
    XLGKGoodsViewController * goods = [[XLGKGoodsViewController alloc]init];
    XLGKPictureController * picture = [[XLGKPictureController alloc]init];
    
    //为滚动视图添加内容视图
    self.myScrollView = [[UIScrollView alloc]initWithFrame:CGRectMake(0, 64, WIDTH, HEIGHT - 64)];
    self.myScrollView.delegate = self;
    self.myScrollView.pagingEnabled = YES;
    self.myScrollView.contentSize = CGSizeMake(WIDTH * 3, HEIGHT - 64);
    [self.view addSubview:self.myScrollView];
    
    [self.myScrollView addSubview:goods.view];
    [self.myScrollView addSubview:picture.view];
    
    //设置每个视图的显示位置
    goods.view.frame = CGRectMake(0, 0, WIDTH, HEIGHT - 64);
    picture.view.frame = CGRectMake(WIDTH, 0, WIDTH, HEIGHT - 64);
    
    //循环创建多个按钮
    NSArray * array = @[@"商品",@"图文"];
    for(int i = 0;i<array.count;i++)
    {
        UIButton * btn = [UIButton buttonWithType:UIButtonTypeCustom];
        btn.frame = CGRectMake(WIDTH / 2 * i, 20, WIDTH / 2, 44);
        [btn setTitle:array[i] forState:UIControlStateNormal];
        [btn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        [btn addTarget:self action:@selector(pressBtn:) forControlEvents:UIControlEventTouchUpInside];
        [self.view addSubview:btn];
        btn.tag = i + 1;
    }
    
    //添加条形视图
    self.lineView = [[UIView alloc]initWithFrame:CGRectMake(0, 54, WIDTH / 2, 5)];
    self.lineView.backgroundColor = [UIColor redColor];
    [self.view addSubview:self.lineView];
    
}
-(void)pressBtn:(id)sender
{
    UIButton * btn = (UIButton *)sender;
    
    //设置滚动视图上显示的内容视图的偏移位置
    [self.myScrollView scrollRectToVisible:CGRectMake(WIDTH * (btn.tag - 1), 0, WIDTH, HEIGHT - 59) animated:YES];
    
    //添加条形视图的动画效果
    [UIView animateWithDuration:0.5 animations:^{
        self.lineView.frame = CGRectMake(WIDTH / 2 * (btn.tag - 1), 54, WIDTH / 2, 5);
    } completion:nil];
}
-(void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView
{
    int page = scrollView.contentOffset.x / WIDTH;
    [UIView animateWithDuration:0.3
                     animations:^{
                         self.lineView.frame = CGRectMake(WIDTH / 2 * page, 54, WIDTH/ 2, 5);
                     } completion:nil];
}

@end
