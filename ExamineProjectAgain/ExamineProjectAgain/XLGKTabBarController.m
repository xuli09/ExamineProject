//
//  XLGKTabBarController.m
//  ExamineProjectAgain
//
//  Created by xuli on 15/12/18.
//  Copyright © 2015年 xuli. All rights reserved.
//

#import "XLGKTabBarController.h"


@interface XLGKTabBarController ()


@end

@implementation XLGKTabBarController
-(void)viewDidLoad
{
    [super viewDidLoad];
    
    //为TabBarController添加子视图控制器
    NSString * path = [[NSBundle mainBundle]pathForResource:@"TabContent" ofType:@"plist"];
    //获取Plist文件中的内容
    NSArray * contentArr = [NSArray arrayWithContentsOfFile:path];
    //获取所有子视图控制器的名称 并美化tabBar
    NSMutableArray * allCtrs = [[NSMutableArray alloc]init];
    for(int i = 0;i<contentArr.count;i++)
    {
        NSDictionary * dic = contentArr[i];
        //获取视图控制器的名称
        NSString * ctrName = dic[@"controllerName"];
        Class ctrClass = NSClassFromString(ctrName);
        //创建视图控制器类对象 多态
        UIViewController * viewContr = [[ctrClass alloc]init];
        //修改状态栏的文字颜色
        [viewContr preferredStatusBarStyle];
        
        //将对象放在tabBar的数组里
        [allCtrs addObject:viewContr];
        
        //获取每个子视图控制器对应的图片
        NSString * imageNameStr = dic[@"tabImage"];
        UIImage * imageName = [UIImage imageNamed:imageNameStr];
        
        //获取tabBar上选中的图片
        NSString * selectImageStr = dic[@"selectImage"];
        UIImage * selectImageName = [UIImage imageNamed:selectImageStr];
        
        viewContr.tabBarItem.image = [imageName imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
        viewContr.tabBarItem.selectedImage = [selectImageName imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
        
        //修改状态栏的字体样式
        [viewContr preferredStatusBarStyle];
        
    }
    self.viewControllers = allCtrs;
    self.tabBar.backgroundImage = [UIImage imageNamed:@"tabbar_bg.png"];
}
//设置状态条的样式
-(UIStatusBarStyle)preferredStatusBarStyle
{
    return UIStatusBarStyleLightContent;
}
@end
