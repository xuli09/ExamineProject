//
//  XLActivity.m
//  ExamineProjectAgain
//
//  Created by xuli on 15/12/23.
//  Copyright © 2015年 xuli. All rights reserved.
//

#import "XLActivity.h"
/**
 *  defaultSize为空时，使用默认normalSize
 */
static CGSize normalSize = {320,50};

@implementation XLActivity
- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self setDefaultAttribute];
    }
    return self;
}


-(instancetype)init
{
    self = [super init];
    
    if (self) {
        [self setDefaultAttribute];
    }
    
    return self;
}


/**
 *   设置默认属性
 */
-(void)setDefaultAttribute
{
    _numberOfRect = 6;
    self.rectBackgroundColor= [UIColor orangeColor];
    _defaultSize = normalSize;
    _spacing = 2;
    
    
    [self setBackgroundColor:[UIColor clearColor]];
    if (CGRectEqualToRect(self.frame, CGRectZero)) {
        [self setFrame:CGRectMake(CGRectGetMinX(self.frame), CGRectGetMinY(self.frame), _defaultSize.width, _defaultSize.height)];
        
    }
    else
    {
        _defaultSize = self.frame.size;
    }
}


-(CAAnimation*)addAnimateWithDelay:(CGFloat)delay
{
    CABasicAnimation* animation = [CABasicAnimation animationWithKeyPath:@"transform.rotation.x"];
    animation.repeatCount = MAXFLOAT;
    animation.removedOnCompletion = YES;
    animation.autoreverses = NO;
    animation.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionLinear];
    animation.fromValue = [NSNumber numberWithFloat:0];
    animation.toValue = [NSNumber numberWithFloat:M_PI];
    animation.duration = _numberOfRect * 0.2; //第一个翻转一周，最后一个开始翻转
    animation.beginTime = CACurrentMediaTime() + delay;
    
    return animation;
}


/**
 *  添加矩形
 */
-(void)addRect
{
    
    [self removeRect];
    [self setHidden:NO];
    
    for (int i = 0; i < _numberOfRect; i++) {
        
        UIView* rectView = [[UIView alloc] initWithFrame:CGRectMake((320 - _numberOfRect*(_defaultSize.height / 2. + _spacing))/2. + i *(_defaultSize.height / 2. + _spacing) , 0, _defaultSize.height/2., _defaultSize.height)];
        [rectView setBackgroundColor:_rectBackgroundColor];
        [rectView.layer addAnimation:[self addAnimateWithDelay:i*0.2] forKey:@"TBRotate"];
        [self addSubview:rectView];
        
        
    }
    
    
}

/**
 *  移除矩形
 */
-(void)removeRect
{
    if (self.subviews.count) {
        [self.subviews makeObjectsPerformSelector:@selector(removeFromSuperview)];
    }
    
    [self setHidden:YES];
}



- (void)startAnimate
{
    [self addRect];
}


- (void)stopAnimate
{
    [self removeRect];
}

@end
