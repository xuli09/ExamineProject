//
//  HeaderScrollView.h
//  QFTeacherText
//
//  Created by zhulei on 15/12/23.
//  Copyright (c) 2015年 zhulei. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ZLScrollView.h"

@protocol HeaderScrollViewDelegate <NSObject>

-(void)passImageIndex:(NSInteger)imageIndex;

@end
@interface HeaderScrollView : UICollectionReusableView<ZLScrollViewDelegate>

-(void)creatItemsWithArray:(NSArray *)itemArray;

@property (nonatomic,weak)id<HeaderScrollViewDelegate>delegate;
@property (nonatomic,assign)NSInteger imageIndex;

@end
