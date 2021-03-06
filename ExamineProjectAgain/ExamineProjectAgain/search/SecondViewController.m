//
//  SecondViewController.m
//  QFTeacherText
//
//  Created by zhulei on 15/12/15.
//  Copyright (c) 2015年 zhulei. All rights reserved.
//

#import "SecondViewController.h"
#import "MyCollectionViewCell.h"
#import "MyCollectionViewCellNormal.h"
#import "AFNetworking.h"
#import "LabelHeader.h"
#import "UIImageView+AFNetworking.h"
#import "HeaderDetailViewController.h"
#import "TJListViewController.h"
#import "HotDetailViewController.h"
#import "MMProgressHUD.h"
@interface SecondViewController (){
    
    UICollectionView *_collectionView;
    
    NSMutableArray *_dataArray;
    NSMutableDictionary * _dataDic;
    
    NSMutableArray *_IdArray;
    
}

@end

@implementation SecondViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = [UIColor whiteColor];
    
    _IdArray = [[NSMutableArray alloc]init];

    [self getData];
    
    [self creatCollectionView];

   
}
-(void)getData{
    
    //开始数据请求 加载指示器
    [MMProgressHUD setPresentationStyle:MMProgressHUDPresentationStyleExpand];
    
    [MMProgressHUD showDeterminateProgressWithTitle:nil status:@"正在加载..."];
    
    //创建网络请求
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    //关闭自动解析功能
    manager.responseSerializer = [AFHTTPResponseSerializer serializer];
    
    //GET方式请求网络数据
    [manager GET:@"http://api.guoku.com/mobile/v4/discover/?api_key=0b19c2b93687347e95c6b6f5cc91bb87&sign=b6fbc461c473452b1fa344ae6d1af2c2" parameters:nil success:^(AFHTTPRequestOperation *operation, id responseObject) {
      
        //第一层数据是一个字典，所以创建一个字典来接收第一波数据
        NSDictionary *dic = [NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingAllowFragments error:nil];
        _dataDic = [[NSMutableDictionary alloc]initWithDictionary:dic];
        
        //热门商品的数据
        NSArray *entitiesArray = [dic objectForKey:@"entities"];
        
        _dataArray = [NSMutableArray arrayWithArray:entitiesArray];

        //collection重新刷新数据
        [_collectionView reloadData];
        
        //网络请求结束后，指示器关掉
        [MMProgressHUD dismissWithSuccess:@"加载成功"];
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        
        //网络请求失败，通过指示器告知失败原因
        [MMProgressHUD dismissWithError:[NSString stringWithFormat:@"%@",error.description]];
    }];
}

-(void)creatCollectionView{
    
    UICollectionViewFlowLayout *layOut = [[UICollectionViewFlowLayout alloc]init];
    
    //规定CollectionView的约束
    _collectionView = [[UICollectionView alloc]initWithFrame:self.view.bounds collectionViewLayout:layOut];
    
    _collectionView.backgroundColor = [UIColor whiteColor];
    
    //注册第一组的头
    [_collectionView registerClass:[HeaderScrollView class] forSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:@"FIRSTID"];
    
    //2.3.4组的label头
    
    [_collectionView registerClass:[LabelHeader class] forSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:@"SECID"];
 
    //推荐品类的item
    [_collectionView registerClass:[MyCollectionViewCellScrolling class] forCellWithReuseIdentifier:@"SCOID"];
    
    
    //热门图文的item
    [_collectionView registerClass:[MyCollectionViewCellNormal class] forCellWithReuseIdentifier:@"NOMID"];
    
    //注册热门商品的item
    [_collectionView registerClass:[MyCollectionViewCell class] forCellWithReuseIdentifier:@"HOTID"];
    
    
   
    _collectionView.delegate = self;
    
    _collectionView.dataSource = self;
    
    [self.view addSubview:_collectionView];
    
}
#pragma mark--UICollectionView代理方法--
//组数
-(NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView{
    
    return 4;
}
//根据每组来规定每组不同的item数量
-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    
    if (section == 0) {
        
        return 0;
   
    }else if (section == 1){
        
        return 1;
   
    }else if (section == 2){
        
        return 3;
   
    }else if (section == 3){
        
        return _dataArray.count;
 
    }
    return 0;
}
//根据组数定制每个不同的item风格
-(UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    
    if (indexPath.section == 0) {
        
        return nil;
    
    }else if (indexPath.section == 1){
        
        MyCollectionViewCellScrolling *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"SCOID" forIndexPath:indexPath];
        
        cell.delegate = self;
        
        NSArray * array = _dataDic[@"categories"];
        
        //把ID保存到IDarray里面
        for (NSDictionary *dic in array) {
            
            NSDictionary *d = [dic objectForKey:@"category"];
            
            [_IdArray addObject:[d objectForKey:@"id"]];
        }
        if (array) {
        
            [cell creatItemsWithArray:array];
        }
        return cell;
        
    }else if (indexPath.section == 2){

        
        MyCollectionViewCellNormal *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"NOMID" forIndexPath:indexPath];
        
        NSArray * array = [_dataDic objectForKey:@"articles"];
        
        NSDictionary * dic = array[indexPath.row];
        
        NSDictionary * artDic = [dic objectForKey:@"article"];
        
        NSString * urlStr = [NSString stringWithFormat:@"http://imgcdn.guoku.com/%@",artDic[@"cover"]];
        
        [cell.iconView setImageWithURL:[NSURL URLWithString:urlStr]];
        
        cell.titleLabel.text = [artDic objectForKey:@"content"];
        return cell;
        
    }else if(indexPath.section == 3){
        
       MyCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"HOTID" forIndexPath:indexPath];
        
        cell.layer.borderWidth = 0.5;
        
        cell.layer.borderColor = [[UIColor grayColor]CGColor];
        
        //获取图片字符串数据
        NSArray * array = [_dataDic objectForKey:@"entities"];
        NSDictionary * dic = array[indexPath.row];
        NSDictionary * goodsDic = [dic objectForKey:@"entity"];
        
        [cell.iconView setImageWithURL:[NSURL URLWithString:goodsDic[@"chief_image"]]];
        
        return cell;
    }
    
    return nil;
}
#pragma mark --第一组Item的点击代理--
-(void)passImageTag:(NSInteger)imageIndex{
    
    TJListViewController *tjList = [[TJListViewController alloc]init];
    
    tjList.appId = _IdArray[imageIndex - 100];

    
    [self.navigationController pushViewController:tjList animated:YES];

}
//根据组头的不同风格样式，来生成不同的头视图
-(UICollectionReusableView *)collectionView:(UICollectionView *)collectionView viewForSupplementaryElementOfKind:(NSString *)kind atIndexPath:(NSIndexPath *)indexPath{
   
    if (indexPath.section == 0) {
       
        HeaderScrollView * header = [collectionView dequeueReusableSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:@"FIRSTID" forIndexPath:indexPath];
        NSArray * array = _dataDic[@"banner"];
      
        NSMutableArray * nameArray = [[NSMutableArray alloc]init];
      
        for (NSDictionary * dic in array) {
            NSString * name = dic[@"img"];
            [nameArray addObject:name];
        }
       
        [header creatItemsWithArray:nameArray];
       
        header.delegate = self;
        
        return header;
   
    }else{
     
        LabelHeader * labelHeader = [collectionView dequeueReusableSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:@"SECID" forIndexPath:indexPath];
      
        if (indexPath.section==1) {
        
            [labelHeader creatUIWithTitle:@"推荐品类"];
        
        }else if (indexPath.section ==2){
        
            [labelHeader creatUIWithTitle:@"热门图文"];
        
        }else{
        
            [labelHeader creatUIWithTitle:@"热门商品"];
        }
      
        return labelHeader;
    }
}
#pragma mark --头部滚动视图的代理方法--
-(void)passImageIndex:(NSInteger)imageIndex{
    
    HeaderDetailViewController *detail = [[HeaderDetailViewController alloc]init];
    
    detail.appId =@"";
   
    NSLog(@"%ld",imageIndex);
}
//头视图的大小
-(CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout referenceSizeForHeaderInSection:(NSInteger)section{
    
    if (section == 0) {
        
        return CGSizeMake(self.view.frame.size.width, 200);
    }else{
        
        return CGSizeMake(self.view.frame.size.width, 30);
    }
    
}
//item大小
-(CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath{
   
    switch (indexPath.section) {
        case 0:{
           
            return CGSizeMake(0, 0);
        }
            
            break;
        case 1:{
            
            return CGSizeMake(self.view.frame.size.width, 170);

        }
            
            break;
            
        case 2:{
            
            return CGSizeMake(self.view.frame.size.width, 100);
        }
            
            break;
            
        case 3:{
            
            if (self.view.frame.size.width>320) {
                
                return CGSizeMake(100, 100);
                
            }else{
                
                return CGSizeMake(80, 80);
            }
        }
            break;
        default:
            break;
    }
    
    return CGSizeMake(0, 0);
}
//确定每个item的距离
-(UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout insetForSectionAtIndex:(NSInteger)section{
    
    CGFloat xSpace;
    
    if (self.view.frame.size.width>320) {
        
        xSpace = (self.view.frame.size.width - 300)/4;
        
    }else{
        
        xSpace = (self.view.frame.size.width - 240)/4;
        
        
    }
    if (section == 3) {
        
        return UIEdgeInsetsMake(5, xSpace, 5, xSpace);
    }
    
    return UIEdgeInsetsMake(0, 0, 0, 0);
}

#pragma mark --ITEM的点击事件--
-(void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    
    
    if (indexPath.section == 2) {
       
        NSArray *array = [_dataDic objectForKey:@"articles"];
        
        NSDictionary *dic = array[indexPath.row];
        
        NSDictionary *d = [dic objectForKey:@"article"];
        HotDetailViewController *detali = [[HotDetailViewController alloc]init];
        
        detali.urlId = [d objectForKey:@"article_id"];
        
        [self.navigationController pushViewController:detali animated:YES];
        
        
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
