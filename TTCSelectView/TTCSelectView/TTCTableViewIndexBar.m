//
//  TTCTableViewIndexBar.m
//  TTCMoveView
//
//  Created by Vision on 15/9/15.
//  Copyright (c) 2015年 Vision. All rights reserved.
//

#import "TTCTableViewIndexBar.h"

@interface TTCTableViewIndexBar ()
//字母集合
@property (nonatomic, copy) NSArray *letterArr;
@property (nonatomic, assign) CGFloat letterHeight;
@end

@implementation TTCTableViewIndexBar

+ (TTCTableViewIndexBar *)tTCTableViewIndexBarWithLetterArray:(NSArray *)letterArr frame:(CGRect)frame{
    TTCTableViewIndexBar *bar = [[TTCTableViewIndexBar alloc]initWithFrame:frame];
    bar.letterArr = letterArr;
    [bar initItem];
    return bar;
}
- (void)initItem{
    
    _letterHeight = self.frame.size.height / [_letterArr count];
    CGFloat fontSize = 12;
    if (_letterHeight < 14){
        fontSize = 11;
    }
    [_letterArr enumerateObjectsUsingBlock:^(NSString * obj, NSUInteger idx, BOOL *stop) {
        CGFloat originY = idx * _letterHeight;
        CATextLayer *ctl = [self textLayerWithSize:fontSize
                                            string:obj
                                          andFrame:CGRectMake(0, originY, self.frame.size.width, _letterHeight)];
        [self.layer addSublayer:ctl];

    }];
    
}
- (CATextLayer*)textLayerWithSize:(CGFloat)size string:(NSString*)string andFrame:(CGRect)frame{
    CATextLayer *textLayer = [CATextLayer layer];
    [textLayer setFont:@"ArialMT"];
    [textLayer setFontSize:size];
    [textLayer setFrame:frame];
    [textLayer setAlignmentMode:kCAAlignmentCenter];
    [textLayer setContentsScale:[[UIScreen mainScreen] scale]];
    [textLayer setForegroundColor:[UIColor blackColor].CGColor];
    [textLayer setString:string];
    return textLayer;
}
- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event{
    [super touchesBegan:touches withEvent:event];
    [self getEvent:event];
}

- (void)touchesMoved:(NSSet *)touches withEvent:(UIEvent *)event{
    [super touchesMoved:touches withEvent:event];
    [self getEvent:event];
    
}

- (void)getEvent:(UIEvent *)event{
    UITouch *touch = [[event allTouches] anyObject];
    CGPoint point = [touch locationInView:self];
    NSInteger indx = (NSInteger) floorf(fabs(point.y) / _letterHeight);
    indx = indx < [_letterArr count] ? indx : [_letterArr count] - 1;
    [self animateLayerAtIndex:indx];
    if (_delegate && [_delegate respondsToSelector:@selector(tableViewIndexBar:didSelectSectionAtIndex:)]) {
        [_delegate tableViewIndexBar:self didSelectSectionAtIndex:indx];
    }
}
- (void)animateLayerAtIndex:(NSInteger)index{
    NSLog(@"%@",_letterArr[index]);
    if ([self.layer.sublayers count] - 1 >= index){
        CABasicAnimation *animation = [CABasicAnimation animationWithKeyPath:@"transform.scale"];
        animation.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseOut];
        animation.duration = 0.2 ;
        animation.repeatCount = 1;
        animation.autoreverses = YES;
        animation.fromValue = [NSNumber numberWithFloat:1];
        animation.toValue = [NSNumber numberWithFloat:1.5];
        [self.layer.sublayers[index] addAnimation:animation forKey:@"myAnimation"];
    }

}
/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
