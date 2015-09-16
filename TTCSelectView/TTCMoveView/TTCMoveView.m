//
//  TTCMoveView.m
//  TTCMoveView
//
//  Created by Vision on 15/9/15.
//  Copyright (c) 2015年 Vision. All rights reserved.
//

#import "TTCMoveView.h"
#import "TTCBaseTableView.h"
#import "TTCBaseTableViewCell.h"
#import "UIView+ITTAdditions.h"

#define TTC_MOVEVIEW_FRAME self.frame
#define TTC_MOVEVIEW_HEIGHT TTC_MOVEVIEW_FRAME.size.height
#define TTC_MOVEVIEW_WIDTH TTC_MOVEVIEW_FRAME.size.width

#define TTC_MOVEVIEW_BLANK (30)

@interface TTCMoveView()<UITableViewDataSource, UITableViewDelegate>
@property (nonatomic, assign)NSInteger level;

@end


@implementation TTCMoveView
//init
+ (TTCMoveView *)TTCMoveViewWithFrame:(CGRect)frame andLelve:(NSInteger)lelve{
    TTCMoveView * newView = [[TTCMoveView alloc]initWithFrame:frame];
    newView.level = lelve;
    [newView initTableView];
    return newView;
}
//UI
- (void)initTableView{
    if (_level) {
        for (NSInteger i = 0; i < _level; i++) {
            TTCBaseTableView *subTableView = [[TTCBaseTableView alloc]initWithFrame:CGRectMake(
                                                                                               TTC_MOVEVIEW_WIDTH,
                                                                                               0,
                                                                                               TTC_MOVEVIEW_WIDTH - i * (TTC_MOVEVIEW_BLANK),
                                                                                               TTC_MOVEVIEW_HEIGHT) style:UITableViewStylePlain];
            subTableView.hidden = YES;
            if (i == 0) {
                subTableView.hidden = NO;
                subTableView.left -= TTC_MOVEVIEW_WIDTH;
            }
            subTableView.tag = TTC_MOVEVIEW_TAG + i;
            subTableView.delegate = self;
            subTableView.dataSource = self;
            subTableView.isAnimated = NO;
            [self addSubview:subTableView];
        }
    }
    
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    NSString *cellId = [NSString stringWithFormat:@"cellId%ld",(long)tableView.tag];
    
    TTCBaseTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellId];
    if (!cell) {
        cell = [[TTCBaseTableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellId];
    }
    cell.textLabel.text =[NSString stringWithFormat:@"%ld",(long)tableView.tag];
    return cell;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 20;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    TTCBaseTableView *tempTableView = (TTCBaseTableView *)tableView;
    TTCBaseTableView *nextTableView = (TTCBaseTableView *)[self viewWithTag:tempTableView.tag + 1];
    if (!nextTableView.isAnimated) {
        [self showlevel:tempTableView.tag  - TTC_MOVEVIEW_TAG + 2 ];
    } else {
        for (NSInteger i = _level; i >= tempTableView.tag  - TTC_MOVEVIEW_TAG + 2; i--) {
            
            [self hidelevel:i];
        }
    }

}

//hide..
- (void)hideAll{

}
- (void)hidelevel:(NSInteger)level{
    NSInteger tag = level + TTC_MOVEVIEW_TAG - 1;
    TTCBaseTableView *tempTableView = (TTCBaseTableView *)[self viewWithTag:tag];
    [UIView animateWithDuration:0.3 animations:^{
        tempTableView.left = TTC_MOVEVIEW_WIDTH;
        tempTableView.isAnimated = NO;
    } completion:^(BOOL finished){
        tempTableView.hidden = YES;
        
    }];
}
//show..
- (void)showAll{

}
- (void)showlevel:(NSInteger)level{
    NSInteger tag = level + TTC_MOVEVIEW_TAG - 1;
    TTCBaseTableView *tempTableView = (TTCBaseTableView *)[self viewWithTag:tag];
    [UIView animateWithDuration:0.3 animations:^{
        tempTableView.left = TTC_MOVEVIEW_BLANK * (tag - TTC_MOVEVIEW_TAG);
        tempTableView.hidden = NO;
        tempTableView.isAnimated = YES;
    } completion:^(BOOL finished){
        
    }];
}


/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
