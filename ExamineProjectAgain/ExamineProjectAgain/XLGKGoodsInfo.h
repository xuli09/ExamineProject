//
//  AppInfo.h
//  ExamineProjectAgain
//
//  Created by xuli on 15/12/21.
//  Copyright © 2015年 xuli. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "JSONModel.h"
//继承JSONModel helloworld
@interface XLGKGoodsInfo : JSONModel

@property (nonatomic,copy) NSString * chief_image;
@property (nonatomic,copy) NSString * content;
@property (nonatomic,copy) NSString * like_count;
@property (nonatomic,copy) NSString * post_time;




@end
