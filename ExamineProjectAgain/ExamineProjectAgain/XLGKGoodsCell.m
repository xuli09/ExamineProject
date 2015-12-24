//
//  XLGKGoodsCell.m
//  ExamineProjectAgain
//
//  Created by xuli on 15/12/18.
//  Copyright © 2015年 xuli. All rights reserved.
//

#import "XLGKGoodsCell.h"
#import "UIImageView+AFNetworking.h"
#import "XLGKGoodsInfo.h"

@implementation XLGKGoodsCell
-(void)showInfoEveryGoods:(XLGKGoodsInfo *)goods
{
    
    [self.goodsImageView setImageWithURL:[NSURL URLWithString:goods.chief_image]];
    self.detailLabel.text = goods.content;
    self.collectionLabel.text = goods.like_count;
    
    //将字符串时间转化成NSDate
    NSDateFormatter * formatter = [[NSDateFormatter alloc]init];
    formatter.dateFormat = @"yyyy-MM-dd HH:mm:ss";
    NSDate * lastDate = [formatter dateFromString:goods.post_time];
    
    NSTimeInterval interval = [lastDate timeIntervalSinceNow];
    interval = fabs(interval);
    int HH = (int)interval / 3600;
    int MM = (int)interval / 60 % 60;
    int SS = (int)interval % 60;
    
    self.timeLabel.text = [NSString stringWithFormat:@"%.2d:%.2d:%.2d前",HH,MM,SS];
    
    self.timeTmpLbl.text = NSLocalizedStringFromTable(@"Time", @"InfoPList", @"ok");
    self.collectionTmpLbl.text = NSLocalizedStringFromTable(@"Collection", @"InfoPList", @"ok");
    
}
@end
