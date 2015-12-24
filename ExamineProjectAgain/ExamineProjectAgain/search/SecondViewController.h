//
//  SecondViewController.h
//  QFTeacherText
//
//  Created by zhulei on 15/12/15.
//  Copyright (c) 2015年 zhulei. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "HeaderScrollView.h"
#import "MyCollectionViewCellScrolling.h"

@interface SecondViewController : UIViewController<UICollectionViewDataSource,UICollectionViewDelegate,UICollectionViewDelegateFlowLayout,HeaderScrollViewDelegate,MyCollectionViewCellScrollingDelegate>

@end
