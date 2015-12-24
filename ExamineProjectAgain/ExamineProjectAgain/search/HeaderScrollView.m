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
    
    ZLScrollView *_zlScrollView;
}

-(id)initWithFrame:(CGRect)frame{
    
    if (self = [super initWithFrame:frame]) {
        
        [self creatScrollView];
    }
    
    return self;
}
-(void)creatScrollView{
    
    _zlScrollView = [[ZLScrollView alloc]initWithFrame:self.bounds];
    
    _zlScrollView.delegate = self;
    
    [self addSubview:_zlScrollView];

}
-(void)creatItemsWithArray:(NSArray *)itemArray{
    
       [_zlScrollView addImageArrayWithArray:itemArray IsFromWeb:YES PlaceHolderImage:nil];
}

-(void)clickImageTag:(NSInteger)tag{
    
    [self.delegate passImageIndex:tag];
}
@end
