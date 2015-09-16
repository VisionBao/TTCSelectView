//
//  TTCTableViewIndexBar.h
//  TTCMoveView
//
//  Created by Vision on 15/9/15.
//  Copyright (c) 2015年 Vision. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol TTCTableViewIndexBarDelegate;

@interface TTCTableViewIndexBar : UIView

@property (nonatomic, weak) id<TTCTableViewIndexBarDelegate> delegate;

+ (TTCTableViewIndexBar *)tTCTableViewIndexBarWithLetterArray:(NSArray *)letterArr frame:(CGRect)frame;

@end

@protocol TTCTableViewIndexBarDelegate <NSObject>

@optional
- (void)tableViewIndexBar:(TTCTableViewIndexBar*)indexBar didSelectSectionAtIndex:(NSInteger)index;

@end
