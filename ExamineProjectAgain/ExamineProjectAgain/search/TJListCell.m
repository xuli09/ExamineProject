//
//  TJListCell.m
//  QFTeacherText
//
//  Created by zhulei on 15/12/24.
//  Copyright (c) 2015年 zhulei. All rights reserved.
//

#import "TJListCell.h"
#import "UIImageView+AFNetworking.h"
#import "FMDBManager.h"
#define WIDTH [UIScreen mainScreen].bounds.size.width
@implementation TJListCell{
    
    
    NSDictionary *_dic;
}

-(id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
   
        [self creatUI];
        
    }
    
    return self;
}
-(void)creatUI{
    
    self.iconView = [[UIImageView alloc]initWithFrame:CGRectMake(10, 10, 80, 80)];
    
    [self.contentView addSubview:self.iconView];
    
    self.titleLabel = [[UILabel alloc]initWithFrame:CGRectMake(100, 10, WIDTH - 200, 20)];
    
    self.titleLabel.font = [UIFont boldSystemFontOfSize:18];
    
    [self.contentView addSubview:self.titleLabel];

    self.pricelabel = [[UILabel alloc]initWithFrame:CGRectMake(100, 70, 150, 20)];
    
    self.pricelabel.font =[UIFont systemFontOfSize:15];
    
    self.pricelabel.textColor = [UIColor blueColor];
    
    [self.contentView addSubview:self.pricelabel];
    
    self.collecButton = [UIButton buttonWithType:UIButtonTypeCustom];
    
    self.collecButton.frame = CGRectMake(WIDTH - 10 - 31, 10, 31, 30);
    
    [self.collecButton setImage:[UIImage imageNamed:@"star2_Gray@2x.png"] forState:UIControlStateNormal];
    
    [self.collecButton setImage:[UIImage imageNamed:@"star_icon@2x.png"] forState:UIControlStateSelected];
    
    [self.collecButton addTarget:self action:@selector(click:) forControlEvents:UIControlEventTouchUpInside];
    
    [self.contentView addSubview:self.collecButton];
    
    self.likeView = [[UIImageView alloc]initWithFrame:CGRectMake(WIDTH - 10 - 5 - 5-10-10-15, 70, 10, 11)];
    [self.likeView setImage:[UIImage imageNamed:@"topic_Download.png"]];
    
    [self.contentView addSubview:self.likeView];
    
    self.likelabel =[[UILabel alloc]initWithFrame:CGRectMake(WIDTH - 10 - 5 - 5-10-10, 70, 5, 10)];
    
    self.likelabel.textAlignment = NSTextAlignmentCenter;
    
    self.likelabel.font = [UIFont systemFontOfSize:8];
    
    [self.contentView addSubview:self.likelabel];
    
    
    self.noteView = [[UIImageView alloc]initWithFrame:CGRectMake(WIDTH - 10 - 5 - 5-10, 70, 10, 11)];
    [self.noteView setImage:[UIImage imageNamed:@"topic_Comment.png"]];
    
    [self.contentView addSubview:self.noteView];
    
    self.notelabel =[[UILabel alloc]initWithFrame:CGRectMake(WIDTH - 10 - 5, 70, 5, 10)];
    
    self.notelabel.textAlignment = NSTextAlignmentCenter;
    
    self.notelabel.font = [UIFont systemFontOfSize:8];
    
    [self.contentView addSubview:self.notelabel];
    
}
-(void)click:(UIButton *)button{
    
    if (button.selected == YES) {
        //取消收藏
        button.selected = NO;
   
    }else{
        //收藏
        button.selected = YES;
   
    }
    
    [self.delegate isCollectedWithSelected:button.selected DataDic:_dic];
}
-(void)configCellWithDic:(NSDictionary *)dic IsCollected:(BOOL)isCollected{
  
    _dic = dic;
    
    if (isCollected) {
        
        self.collecButton.selected = YES;
        
    }else{
        
        self.collecButton.selected = NO;
    }
    [self.iconView setImageWithURL:[NSURL URLWithString:[dic objectForKey:@"chief_image"]]];
    
    self.titleLabel.text = [dic objectForKey:@"title"];
    
    self.pricelabel.text =[NSString stringWithFormat:@"￥%@",[dic objectForKey:@"price"]];
    
    self.notelabel.text = [NSString stringWithFormat:@"%@",[dic objectForKey:@"note_count"]];
    
    self.likelabel.text = [NSString stringWithFormat:@"%@",[dic objectForKey:@"like_count"]];
   
}
- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
