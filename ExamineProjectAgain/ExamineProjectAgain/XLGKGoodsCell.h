//
//  XLGKGoodsCell.h
//  ExamineProjectAgain
//
//  Created by xuli on 15/12/18.
//  Copyright © 2015年 xuli. All rights reserved.
//

#import <UIKit/UIKit.h>

@class XLGKGoodsInfo;

@interface XLGKGoodsCell : UITableViewCell
//显示商品的图片信息
@property (strong, nonatomic) IBOutlet UIImageView *goodsImageView;
//显示商品的详细信息
@property (strong, nonatomic) IBOutlet UILabel *detailLabel;
//显示商品被收藏次数
@property (strong, nonatomic) IBOutlet UILabel *collectionLabel;
//显示商品的上架时间
@property (strong, nonatomic) IBOutlet UILabel *timeLabel;


//接收显示的数据
-(void)showInfoEveryGoods:(XLGKGoodsInfo *)goods;

@end
