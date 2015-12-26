//
//  MyCollectionViewCellScrolling.m
//  QFTeacherText
//
//  Created by zhulei on 15/12/23.
//  Copyright (c) 2015年 zhulei. All rights reserved.
//

#import "MyCollectionViewCellScrolling.h"
#import "UIImageView+AFNetworking.h"
@implementation MyCollectionViewCellScrolling{
    
    UIScrollView *scrollView;
}
-(id)initWithFrame:(CGRect)frame{
    
    if (self = [super initWithFrame:frame]) {
        
        scrollView = [[UIScrollView alloc]initWithFrame:self.bounds];
    }
    
    return self;
}

-(void)creatItemsWithArray:(NSArray *)itemArray{
    
    self.backgroundColor= [UIColor whiteColor];
    
    
    scrollView.contentOffset = CGPointZero;
    
    //间隔是5  距离屏幕距离是10
    scrollView.contentSize = CGSizeMake(150*itemArray.count+(itemArray.count - 1)*5+20+50, 170);
    
    [self addSubview:scrollView];
    
    for (int i = 0; i<itemArray.count; i++) {
        
        NSDictionary * dic = itemArray[i];
        NSDictionary * category = dic[@"category"];
        
        UIImageView *imageView = [[UIImageView alloc]initWithFrame:CGRectMake(10+i*(150+10), 10, 150, 150)];
        
        [imageView setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@",category[@"cover_url"]]]];
        
        imageView.userInteractionEnabled = YES;
        
        [scrollView addSubview:imageView];
        
        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(clickImage:)];
       
        imageView.tag = 100+i;
        
        [imageView addGestureRecognizer:tap];
        
        //imageView上面的Label
        NSArray * labelArray = [category[@"title"] componentsSeparatedByString:@" "];
        
        UILabel * titleLabel = [[UILabel alloc]initWithFrame:CGRectMake((imageView.frame.size.width-40)/2, 50, 40, 20)];
        titleLabel.alpha = 0.5;
        titleLabel.textAlignment = NSTextAlignmentCenter;
        titleLabel.textColor = [UIColor whiteColor];
        titleLabel.text = labelArray[0];
        [imageView addSubview:titleLabel];
        
        UILabel * detailLabel = [[UILabel alloc]initWithFrame:CGRectMake((imageView.frame.size.width-70)/2, 70, 70, 20)];
        detailLabel.alpha = 0.5;
        detailLabel.textAlignment = NSTextAlignmentCenter;
        detailLabel.textColor = [UIColor whiteColor];
        detailLabel.text = labelArray[1];
        [imageView addSubview:detailLabel];
    }
}
-(void)clickImage:(UITapGestureRecognizer *)tap{
    
    
    [self.delegate passImageTag:tap.view.tag];
}
@end
