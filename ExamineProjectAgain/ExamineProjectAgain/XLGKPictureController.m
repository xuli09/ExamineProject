//
//  XLGKPictureController.m
//  ExamineProjectAgain
//
//  Created by xuli on 15/12/18.
//  Copyright © 2015年 xuli. All rights reserved.
//

#import "XLGKPictureController.h"

@implementation XLGKPictureController

-(void)viewDidLoad
{
    [super viewDidLoad];
    
    //设置当前界面的数据显示接口
    self.rootPath = PICTUREPATH;
    [self startRequestInfo:PICTUREPATH];
}
@end
