//
//  FMDBManager.m
//  QFTeacherText
//
//  Created by zhulei on 15/12/24.
//  Copyright (c) 2015年 zhulei. All rights reserved.
//

#import "FMDBManager.h"

@implementation FMDBManager

+(instancetype)shareInstance{
    
    static FMDBManager *manager;
    
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        
        manager = [[FMDBManager alloc]init];
    });
    
    return manager;
}

-(instancetype)init{
    
    if (self = [super init]) {
        
        _dataBase = [[FMDatabase alloc]initWithPath:[NSHomeDirectory() stringByAppendingPathComponent:@"Documents/GK.db"]];
        
        NSLog(@"%@",[NSHomeDirectory() stringByAppendingPathComponent:@"Documents/GK.db"]);
        [_dataBase open];
        
        NSString *creatTableSql = @"create table if not exists gk(id integer primary key autoincrement,entityid varchar (256),title varchar (256),imageurl varchar (256))";
        
        if([_dataBase executeUpdate:creatTableSql]){
            
            NSLog(@"表创建成功");
        }
    }
    
    return self;
}
-(void)collectWithEntityId:(NSString *)entityId Title:(NSString *)title ImageUrl:(NSString *)imageUrl
{
    
    NSString *insertSql = @"insert into gk (entityid,title,imageurl)values(?,?,?)";
    
    if([_dataBase executeUpdate:insertSql,entityId,title,imageUrl]){
        
        NSLog(@"收藏成功");
    }
}

-(void)deCollecWithEntityId:(NSString *)entityId{
    
    NSString *deleteSql = @"delete from gk where entityid = ?";
    
    if ([_dataBase executeUpdate:deleteSql,entityId]) {
        
        NSLog(@"取消收藏成功");
    }
}
-(BOOL)isCollectedWithEntityId:(NSString *)entityId{
    
    NSString *selectSql = @"select *from gk where entityid = ?";
    
    FMResultSet *set = [_dataBase executeQuery:selectSql,entityId];
    
    while ([set  next]) {
        
        return YES;
    }
    
    return NO;
}
@end
