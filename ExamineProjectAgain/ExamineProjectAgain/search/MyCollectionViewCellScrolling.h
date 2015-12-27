//
//  MyCollectionViewCellScrolling.h
//  QFTeacherText
//
//  Created by zhulei on 15/12/23.
//  Copyright (c) 2015年 zhulei. All rights reserved.
//

#import <UIKit/UIKit.h>


@protocol  MyCollectionViewCellScrollingDelegate<NSObject>

-(void)passImageTag:(NSInteger)imageIndex;

@end
@interface MyCollectionViewCellScrolling : UICollectionViewCell
@property (nonatomic,weak)id<MyCollectionViewCellScrollingDelegate>delegate;
/*!
 根据传递过来的数组数来设计scrollview的contentsize
 */
-(void)creatItemsWithArray:(NSArray *)itemArray;

@end
