//
//  TJListViewController.h
//  QFTeacherText
//
//  Created by zhulei on 15/12/24.
//  Copyright (c) 2015年 zhulei. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "TJListCell.h"
@interface TJListViewController : UIViewController<UITableViewDataSource,UITableViewDelegate,TJListCellDelegate>
@property (nonatomic,copy)NSString *appId;
@end
