//
//  FMDBManager.h
//  QFTeacherText
//
//  Created by zhulei on 15/12/24.
//  Copyright (c) 2015年 zhulei. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "FMDatabase.h"
@interface FMDBManager : NSObject{
    
    FMDatabase *_dataBase;
}
+(instancetype)shareInstance;

/*!
 收藏功能
 */

-(void)collectWithEntityId:(NSString *)entityId Title:(NSString *)title ImageUrl:(NSString *)imageUrl;
/*!
 取消收藏功能
 */
-(void)deCollecWithEntityId:(NSString *)entityId;

/*!
 判断是否收藏过
 */
-(BOOL)isCollectedWithEntityId:(NSString *)entityId;
@end
