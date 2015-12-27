//
//  TJListCell.h
//  QFTeacherText
//
//  Created by zhulei on 15/12/24.
//  Copyright (c) 2015年 zhulei. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol TJListCellDelegate <NSObject>

-(void)isCollectedWithSelected:(BOOL)isSelected DataDic:(NSDictionary *)dic;

@end
@interface TJListCell : UITableViewCell

@property (nonatomic,strong)UIImageView *iconView;

@property (nonatomic,strong)UILabel *titleLabel;

@property (nonatomic,strong)UILabel *pricelabel;

@property (nonatomic,strong)UIButton *collecButton;

@property (nonatomic,strong)UIImageView*likeView;

@property (nonatomic,strong)UILabel *likelabel;

@property (nonatomic,strong)UIImageView *noteView;

@property (nonatomic,strong)UILabel *notelabel;

@property (nonatomic,strong)UILabel *descLabel;

-(void)configCellWithDic:(NSDictionary *)dic IsCollected:(BOOL)isCollected DescText:(NSString *)desc;

@property (nonatomic,assign)BOOL isCollected;

@property (nonatomic,weak)id<TJListCellDelegate>delegate;
@end
