//
//  TTCSelectView.m
//  TTCMoveView
//
//  Created by Vision on 15/9/15.
//  Copyright (c) 2015年 Vision. All rights reserved.
//

#import "TTCSelectView.h"

#import "UIView+ITTAdditions.h"
#import "TTCTableViewIndexBar.h"

#define TTCTABLEVIEWINDEXBAR_WIDTH (30)
#define TTCSELETVIEW_LEFT_BLANK (120)

@interface TTCSelectView()<TTCTableViewIndexBarDelegate,UITableViewDataSource,UITableViewDelegate>

@property (nonatomic, assign) BOOL move;
@property (nonatomic, assign) BOOL animated;
@property (nonatomic, assign)TTCSelectViewStyle TTCSelectMode;
@property (nonatomic, strong)TTCTableViewIndexBar *indexBar;

@property (nonatomic, strong)TTCBaseTableView *tableViewLevel1;
@property (nonatomic, strong)TTCBaseTableView *tableViewLevel2;
@property (nonatomic, strong)TTCBaseTableView *tableViewLevel3;


@end

@implementation TTCSelectView

+ (TTCSelectView *)tTCSelectViewWithFrame:(CGRect)frame indexArray:(NSArray *)indexArray style:(TTCSelectViewStyle)style{
    TTCSelectView *newView = [[TTCSelectView alloc]initWithFrame:frame];
    newView.animated = NO;
    if (style == TTCSelectViewStyleCity) {
        newView.move = NO;
        [newView initTableViewWithLevel:2];
    }
    
    if (style == TTCSelectViewStyleCar) {
        newView.move = YES;
        [newView initTableViewWithLevel:3];
        
    }
    
    //indexbar
    [newView initTableViewIndexBarWithIndexArray:indexArray];
    
    
    return newView;
}

#pragma mark - UI
- (void)initTableViewWithLevel:(NSInteger)level{
    
    UISwipeGestureRecognizer *swipeGessture = [[UISwipeGestureRecognizer alloc]initWithTarget:self action:@selector(tableViewPan:)];
    
    
    
    _tableViewLevel1 = [[TTCBaseTableView alloc]initWithFrame:CGRectMake(0, 0, self.width - TTCSELETVIEW_LEFT_BLANK - TTCTABLEVIEWINDEXBAR_WIDTH, self.height) style:UITableViewStylePlain];
    _tableViewLevel1.delegate = self;
    _tableViewLevel1.dataSource = self;
    _tableViewLevel1.level = 1;
    [_tableViewLevel1 addGestureRecognizer:swipeGessture];
    [self addSubview:_tableViewLevel1];
    
    _tableViewLevel2 = [[TTCBaseTableView alloc]initWithFrame:CGRectMake(_tableViewLevel1.right + TTCTABLEVIEWINDEXBAR_WIDTH, 0, TTCSELETVIEW_LEFT_BLANK, self.height) style:UITableViewStylePlain];
    _tableViewLevel2.delegate = self;
    _tableViewLevel2.dataSource = self;
    _tableViewLevel2.level = 2;
    [self addSubview:_tableViewLevel2];
    
    if (level == 3) {
        _tableViewLevel3 = [[TTCBaseTableView alloc]initWithFrame:CGRectMake(_tableViewLevel2.right, 0, self.width - TTCSELETVIEW_LEFT_BLANK / 2 - _tableViewLevel2.width - TTCTABLEVIEWINDEXBAR_WIDTH, self.height) style:UITableViewStylePlain];
        _tableViewLevel3.delegate = self;
        _tableViewLevel3.dataSource = self;
        _tableViewLevel3.level = 3;
        [self addSubview:_tableViewLevel3];
    }

}
- (void)initTableViewIndexBarWithIndexArray:(NSArray *)arr{
    _indexBar = [TTCTableViewIndexBar tTCTableViewIndexBarWithLetterArray:arr frame:CGRectMake(_tableViewLevel1.right, 0, TTCTABLEVIEWINDEXBAR_WIDTH, self.height)];
    _indexBar.delegate = self;
    [self addSubview:_indexBar];
    
    if (_move) {
        //indexbar pan
        UIPanGestureRecognizer *pan = [[UIPanGestureRecognizer alloc] initWithTarget:self action:@selector(pan:)];
        [_indexBar addGestureRecognizer:pan];
    }
}



#pragma mark - action
-(void)pan:(UIPanGestureRecognizer *)recognizer{
    CGPoint location = [recognizer locationInView:self.superview];
    CGFloat x = location.x;
    _indexBar.centerX = x;

    if (_indexBar.right >= self.right) {
        _indexBar.left = self.right - TTCTABLEVIEWINDEXBAR_WIDTH;
    }
    if (_indexBar.left <= self.left) {
        _indexBar.left = self.left;
    }
    
    UIGestureRecognizerState state = recognizer.state;
    //    BOOL animated = NO;
    if (state == UIGestureRecognizerStateEnded || state == UIGestureRecognizerStateCancelled) {
        if (_indexBar.left > self.width / 2) {
            [self show];
        } else {
            [self hide];
        }
    } else if (state == UIGestureRecognizerStateChanged) {
        [self refreshLocation];
    }

}
-(void)tableViewPan:(UISwipeGestureRecognizer *)recognizer{
//    CGPoint location = [recognizer locationInView:self.superview];
//    CGFloat x = location.x;
//    CGPoint translatedPoint = [recognizer translationInView:self.superview];
//    if (translatedPoint.x<0) {
//        NSLog(@"<0");
//    } else {
//        NSLog(@">0");
//    }
}
- (void)refreshLocation{
    _tableViewLevel2.left = _indexBar.right;
    _tableViewLevel3.left = _tableViewLevel2.right;
}
- (void)show{
    [UIView animateWithDuration:.3 animations:^{
        _indexBar.right = self.width - TTCSELETVIEW_LEFT_BLANK;
        [self refreshLocation];
    } completion:^(BOOL finished) {
        _animated = YES;
    }];
}
- (void)hide{
    [UIView animateWithDuration:.3 animations:^{
        _indexBar.left = TTCSELETVIEW_LEFT_BLANK/ 2;
        [self refreshLocation];
    } completion:^(BOOL finished) {
        _animated = NO;
    }];
}
#pragma mark - indexBar delegate
- (void)tableViewIndexBar:(TTCTableViewIndexBar *)indexBar didSelectSectionAtIndex:(NSInteger)index{
    if ([_tableViewLevel1 numberOfSections] > index && index > -1){
        [_tableViewLevel1 scrollToRowAtIndexPath:[NSIndexPath indexPathForRow:0 inSection:index]
                              atScrollPosition:UITableViewScrollPositionTop
                                      animated:YES];
    }
}
#pragma mark - tableView delegate
- (NSInteger)numberOfSectionsInTableView:(TTCBaseTableView *)tableView{
    
    if (_dataSource && [_dataSource respondsToSelector:@selector(selectView:numberOfSectionsInTableView:)]) {
        return [_dataSource selectView:self numberOfSectionsInTableView:tableView];
    }
    return 1;
}
- (NSInteger)tableView:(TTCBaseTableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return [_dataSource selectView:self tableView:tableView numberOfRowsInSection:section];
}
- (NSString *)tableView:(TTCBaseTableView *)tableView titleForHeaderInSection:(NSInteger)section{
    if (_dataSource && [_dataSource respondsToSelector:@selector(selectView:tableView:titleForHeaderInSection:)]) {
        return [_dataSource selectView:self tableView:tableView titleForHeaderInSection:section];
    }
    return nil;
}
- (TTCBaseTableViewCell *)tableView:(TTCBaseTableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{

    return [_dataSource selectView:self tableView:tableView cellForRowAtIndexPath:indexPath];
}
- (CGFloat)tableView:(TTCBaseTableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (_delegate && [_delegate respondsToSelector:@selector(selectView:tableView:heightForRowAtIndexPath:)]) {
        
        return [_delegate selectView:self tableView:tableView heightForRowAtIndexPath:indexPath];
    }
    return 44;
    
}
- (void)tableView:(TTCBaseTableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    if (tableView.level == 1) {
        [self show];
    }
    if (tableView.level == 2) {
        [self hide];
    }
    if (_delegate && [_delegate respondsToSelector:@selector(selectView:tableView:didSelectRowAtIndexPath:)]) {
        [_delegate selectView:self tableView:tableView didSelectRowAtIndexPath:indexPath];
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
