//
//  MyCollectionViewCellNormal.m
//  QFTeacherText
//
//  Created by zhulei on 15/12/23.
//  Copyright (c) 2015年 zhulei. All rights reserved.
//

#import "MyCollectionViewCellNormal.h"

@implementation MyCollectionViewCellNormal

-(id)initWithFrame:(CGRect)frame{
    
    if (self = [super initWithFrame:frame]) {
        self.backgroundColor = [UIColor whiteColor];
        self.iconView = [[UIImageView alloc]initWithFrame:CGRectMake(self.frame.size.width - 10 - 100, 10, 100, 80)];
        
        [self addSubview:self.iconView];
        
        self.titleLabel = [[UILabel alloc]initWithFrame:CGRectMake(10,10,self.frame.size.width - 130, 80)];
        
        self.titleLabel.numberOfLines = 0;
        
        self.titleLabel.font = [UIFont systemFontOfSize:15];
        
        [self addSubview:self.titleLabel];
    }
    
    return self;
}
@end
