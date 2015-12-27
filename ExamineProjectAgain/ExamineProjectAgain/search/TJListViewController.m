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
    
     NSMutableArray *_textArray;
}

@end

@implementation TJListViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    //初始化数组
    _dataArray = [[NSMutableArray alloc]init];
    _textArray = [NSMutableArray arrayWithObjects:@"在很久以前,中国四分五裂",@"最后出现了中国共产党统一了中国,带领人民打到了日寇,走向幸福生活.",@"国家陆续出台多项法律法规，规范市场行为，对室内空间环境质量有强制标准。室内空气治理行业迎来发展的春天，格瑞孚带你享受政策红利",@"国内从事空气污染治理的公司不足百家，有实力的就更少了。国内有技术研发、产品研制能力的不足十家，空间环境监测与污染治理市场的巨大潜力可想而知",@"三合一高浓缩，彻底清洁汽车空调冷凝器、蒸发箱、空调管路里面的污渍及有害物质（甲醛、甲苯、TVOC、多环芳烃等），以达到软化溶解、清洗、杀菌消毒的效果",@"针对汽车空间特有的污染源研制。三大化工特征：1、游离：捕捉空气中游离状态的有害物质；2、分解：将有害物质分解为无害；3、吸附：有效吸附甲醛、甲苯等",@"依托欧洲强大的研发实力，结合北欧空气净化新型先进技术和理念，从固有污染、人为污染、环境交叉污染三个基本污染源头重新进行化工设计，研制出彻底解决室内空气污染的净化产品，每款产品都通过国家权威检测机构检测验证",@"绿叶环保集团（香港）股份有限公司Green Leaf Pro-environment Group (HK) Share Co., Limited成立于2011年。是一家专业从事车居与家居空气污染净化产品研发与生产的高科技现代企业；在室内空气治理服务领域，具有超前端的科研技术与强大的研发能力",@"是美国科温士国际公司经过10多年的研发并推出的真正意义上的绿色环保装饰涂料。该产品不仅获得了美国绿色封装标准认证，符合美国食品监督局和药品监督局关于直接与食物表面接触的规定要求，还是美国漆师协会及洛杉矶、圣地亚哥、菲尼克斯等美国和北美注册的涂料承包商的优选推荐产品，也是欧美建筑师和设计师的优选涂料品牌",@"近十几年来，室内装饰提高到了一个全新的高度，由于墙纸、壁布等墙面装饰材料在理化性能等方面存在着不足，经不起岁月的考验，市场正逐渐萎缩。内墙装饰市场中，各种品牌的乳胶漆因其色彩单调、无图案选择已成为市场推广的主要障碍",@"在很久以前,中国四分五裂",@"最后出现了中国共产党统一了中国,带领人民打到了日寇,走向幸福生活.",@"国家陆续出台多项法律法规，规范市场行为，对室内空间环境质量有强制标准。室内空气治理行业迎来发展的春天，格瑞孚带你享受政策红利",@"国内从事空气污染治理的公司不足百家，有实力的就更少了。国内有技术研发、产品研制能力的不足十家，空间环境监测与污染治理市场的巨大潜力可想而知",@"三合一高浓缩，彻底清洁汽车空调冷凝器、蒸发箱、空调管路里面的污渍及有害物质（甲醛、甲苯、TVOC、多环芳烃等），以达到软化溶解、清洗、杀菌消毒的效果",@"针对汽车空间特有的污染源研制。三大化工特征：1、游离：捕捉空气中游离状态的有害物质；2、分解：将有害物质分解为无害；3、吸附：有效吸附甲醛、甲苯等",@"依托欧洲强大的研发实力，结合北欧空气净化新型先进技术和理念，从固有污染、人为污染、环境交叉污染三个基本污染源头重新进行化工设计，研制出彻底解决室内空气污染的净化产品，每款产品都通过国家权威检测机构检测验证",@"绿叶环保集团（香港）股份有限公司Green Leaf Pro-environment Group (HK) Share Co., Limited成立于2011年。是一家专业从事车居与家居空气污染净化产品研发与生产的高科技现代企业；在室内空气治理服务领域，具有超前端的科研技术与强大的研发能力",@"是美国科温士国际公司经过10多年的研发并推出的真正意义上的绿色环保装饰涂料。该产品不仅获得了美国绿色封装标准认证，符合美国食品监督局和药品监督局关于直接与食物表面接触的规定要求，还是美国漆师协会及洛杉矶、圣地亚哥、菲尼克斯等美国和北美注册的涂料承包商的优选推荐产品，也是欧美建筑师和设计师的优选涂料品牌",@"近十几年来，室内装饰提高到了一个全新的高度，由于墙纸、壁布等墙面装饰材料在理化性能等方面存在着不足，经不起岁月的考验，市场正逐渐萎缩。内墙装饰市场中，各种品牌的乳胶漆因其色彩单调、无图案选择已成为市场推广的主要障碍",@"在很久以前,中国四分五裂",@"最后出现了中国共产党统一了中国,带领人民打到了日寇,走向幸福生活.",@"国家陆续出台多项法律法规，规范市场行为，对室内空间环境质量有强制标准。室内空气治理行业迎来发展的春天，格瑞孚带你享受政策红利",@"国内从事空气污染治理的公司不足百家，有实力的就更少了。国内有技术研发、产品研制能力的不足十家，空间环境监测与污染治理市场的巨大潜力可想而知",@"三合一高浓缩，彻底清洁汽车空调冷凝器、蒸发箱、空调管路里面的污渍及有害物质（甲醛、甲苯、TVOC、多环芳烃等），以达到软化溶解、清洗、杀菌消毒的效果",@"针对汽车空间特有的污染源研制。三大化工特征：1、游离：捕捉空气中游离状态的有害物质；2、分解：将有害物质分解为无害；3、吸附：有效吸附甲醛、甲苯等",@"依托欧洲强大的研发实力，结合北欧空气净化新型先进技术和理念，从固有污染、人为污染、环境交叉污染三个基本污染源头重新进行化工设计，研制出彻底解决室内空气污染的净化产品，每款产品都通过国家权威检测机构检测验证",@"绿叶环保集团（香港）股份有限公司Green Leaf Pro-environment Group (HK) Share Co., Limited成立于2011年。是一家专业从事车居与家居空气污染净化产品研发与生产的高科技现代企业；在室内空气治理服务领域，具有超前端的科研技术与强大的研发能力",@"是美国科温士国际公司经过10多年的研发并推出的真正意义上的绿色环保装饰涂料。该产品不仅获得了美国绿色封装标准认证，符合美国食品监督局和药品监督局关于直接与食物表面接触的规定要求，还是美国漆师协会及洛杉矶、圣地亚哥、菲尼克斯等美国和北美注册的涂料承包商的优选推荐产品，也是欧美建筑师和设计师的优选涂料品牌",@"近十几年来，室内装饰提高到了一个全新的高度，由于墙纸、壁布等墙面装饰材料在理化性能等方面存在着不足，经不起岁月的考验，市场正逐渐萎缩。内墙装饰市场中，各种品牌的乳胶漆因其色彩单调、无图案选择已成为市场推广的主要障碍",nil];
    self.view.backgroundColor = [UIColor whiteColor];
    
    //获取网络数据
    [self getData];
    
    //创建tableview
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
#pragma mark --UITABLEVIEWDELEGATE--
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    return _dataArray.count;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
  
    TJListCell *cell = [tableView dequeueReusableCellWithIdentifier:@"ID"];
    
    if (!cell) {
        
        cell = [[TJListCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"ID"];
    }
    
    NSDictionary *dic = _dataArray[indexPath.row];
  
    //在数据库里查询，看是否收藏过，改变星星按钮的状态
 BOOL isCollected = [[FMDBManager shareInstance]isCollectedWithEntityId:[dic objectForKey:@"entity_id"]];
    
    cell.delegate = self;
    

    NSString *descText = _textArray[indexPath.row];
    
    //把参数通过方法传递到cell里面
    
    [cell configCellWithDic:dic IsCollected:isCollected DescText:descText];
    
    return cell;
    
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
   
    //动态计算cell高度，固定高度+动态label的高度
    NSString *desc = _textArray[indexPath.row];
    
    //计算动态desc的高度
    CGRect rect = [desc boundingRectWithSize:CGSizeMake([UIScreen mainScreen].bounds.size.width - 20, MAXFLOAT) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:17]} context:nil];
   
    //100是固定高度  rect.size.height是计算得到的动态高度
    return 100 +rect.size.height + 10;

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
