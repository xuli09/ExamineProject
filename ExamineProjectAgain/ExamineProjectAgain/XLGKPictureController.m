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
    
    self.rootPath = PICTUREPATH;
    [self startRequestInfo:PICTUREPATH];
}
@end
