//
//  TTCMoveView.h
//  TTCMoveView
//
//  Created by Vision on 15/9/15.
//  Copyright (c) 2015年 Vision. All rights reserved.
//
#define TTC_MOVEVIEW_TAG 10000
#import <UIKit/UIKit.h>
#import "TTCBaseView.h"
@interface TTCMoveView : TTCBaseView

+ (TTCMoveView *)TTCMoveViewWithFrame:(CGRect)frame andLelve:(NSInteger)lelve;

//hide..
- (void)hideAll;
- (void)hidelevel:(NSInteger)level;
//show..
- (void)showAll;
- (void)showlevel:(NSInteger)level;
@end
