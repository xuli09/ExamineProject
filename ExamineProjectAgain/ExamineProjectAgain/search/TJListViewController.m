//
//  TJListViewController.m
//  QFTeacherText
//
//  Created by zhulei on 15/12/24.
//  Copyright (c) 2015年 zhulei. All rights reserved.
//

#import "TJListViewController.h"
#import "AFNetworking.h"
#import "FMDBManager.h"
#define LISTURL @"http://api.guoku.com/mobile/v4/category/%@/selection/?api_key=0b19c2b93687347e95c6b6f5cc91bb87&page=1&sign=2a42c35005f57af37a930629b5e00aa5&sort=time"
@interface TJListViewController (){
    
    UITableView *_tableView;
    
    NSMutableArray *_dataArray;
}

@end

@implementation TJListViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    _dataArray = [[NSMutableArray alloc]init];
    
    self.view.backgroundColor = [UIColor whiteColor];
    
    [self getData];
    
    [self creatTableView];
}
-(void)getData{
    
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    
    manager.responseSerializer = [AFHTTPResponseSerializer serializer];
    

    [manager GET:[NSString stringWithFormat:LISTURL,self.appId] parameters:nil success:^(AFHTTPRequestOperation *operation, id responseObject) {
        
        NSArray *rootArray = [NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingAllowFragments error:nil];
        
        for (NSDictionary *dic in rootArray) {
            
            [_dataArray addObject:dic];
        }
        
        [_tableView reloadData];
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        
    }];
}
-(void)creatTableView{
    
    _tableView =[[UITableView alloc]initWithFrame:self.view.bounds style:UITableViewStylePlain];
    
    _tableView.delegate = self;
    
    _tableView.dataSource = self;
    
    [self.view addSubview:_tableView];
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    return _dataArray.count;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
  
    TJListCell *cell = [tableView dequeueReusableCellWithIdentifier:@"ID"];
    
    if (!cell) {
        
        cell = [[TJListCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"ID"];
    }
    
    NSDictionary *dic = _dataArray[indexPath.row];
  
 BOOL isCollected = [[FMDBManager shareInstance]isCollectedWithEntityId:[dic objectForKey:@"entity_id"]];
    
    cell.delegate = self;
    
//    [cell creatUIWithIsCollected:isCollected];
    
    [cell configCellWithDic:dic IsCollected:isCollected];
    
    return cell;
    
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    return 100;
}
-(void)isCollectedWithSelected:(BOOL)isSelected DataDic:(NSDictionary *)dic{
    
    if (isSelected) {
        
        //收藏功能
        
        [[FMDBManager shareInstance]collectWithEntityId:[dic objectForKey:@"entity_id"] Title:[dic objectForKey:@"title"] ImageUrl:[dic objectForKey:@"chief_image"]];
 
    }else{
        
        //取消收藏
        
        [[FMDBManager shareInstance]deCollecWithEntityId:[dic objectForKey:@"entity_id"]];
    }
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
