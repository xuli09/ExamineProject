//
//  LabelHeader.h
//  QFTeacherText
//
//  Created by zhulei on 15/12/23.
//  Copyright (c) 2015年 zhulei. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface LabelHeader : UICollectionReusableView
//公开一个方法 方便调用
-(void)creatUIWithTitle:(NSString *)title;
@end
