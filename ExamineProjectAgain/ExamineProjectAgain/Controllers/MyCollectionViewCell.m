//
//  MyCollectionViewCell.m
//  QFTeacherText
//
//  Created by zhulei on 15/12/23.
//  Copyright (c) 2015年 zhulei. All rights reserved.
//

#import "MyCollectionViewCell.h"
#import "UIImageView+AFNetworking.h"
@implementation MyCollectionViewCell

-(id)initWithFrame:(CGRect)frame{
    
    if (self = [super initWithFrame:frame]) {
        
       self.iconView = [[UIImageView alloc]initWithFrame:self.bounds];
        
        self.iconView.backgroundColor = [UIColor redColor];
        
        [self addSubview:self.iconView];
    }
    
    return self;
}

@end
