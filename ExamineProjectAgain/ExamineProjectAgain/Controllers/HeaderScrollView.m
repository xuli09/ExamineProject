//
//  HeaderScrollView.m
//  QFTeacherText
//
//  Created by zhulei on 15/12/23.
//  Copyright (c) 2015年 zhulei. All rights reserved.
//

#import "HeaderScrollView.h"
@implementation HeaderScrollView{
    
    NSArray *_imageIdArray;
}

-(id)initWithFrame:(CGRect)frame{
    
    if (self = [super initWithFrame:frame]) {
        
    }
    
    return self;
}

-(void)creatItemsWithArray:(NSArray *)itemArray{
    
    ZLScrollView *zlScrollView = [[ZLScrollView alloc]initWithFrame:self.bounds];
    
    zlScrollView.delegate = self;
    
    [zlScrollView addImageArrayWithArray:itemArray IsFromWeb:YES PlaceHolderImage:nil];
    
    [self addSubview:zlScrollView];
    
    
}

-(void)clickImageTag:(NSInteger)tag{
    
    [self.delegate passImageIndex:tag];
}
@end
