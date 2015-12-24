//
//  LabelHeader.m
//  QFTeacherText
//
//  Created by zhulei on 15/12/23.
//  Copyright (c) 2015年 zhulei. All rights reserved.
//

#import "LabelHeader.h"

@implementation LabelHeader

-(id)initWithFrame:(CGRect)frame{
    
    if (self = [super initWithFrame:frame]) {
        
    }
    
    return self;
}
-(void)creatUIWithTitle:(NSString *)title{
    
    UILabel *titleLabel = [[UILabel alloc]initWithFrame:CGRectMake(10, 10, 300, 20)];
    titleLabel.backgroundColor = [UIColor whiteColor];
    
    titleLabel.text = title;
    
    [self addSubview:titleLabel];
}
@end
