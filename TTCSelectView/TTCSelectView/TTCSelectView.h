//
//  TTCSelectView.h
//  TTCMoveView
//
//  Created by Vision on 15/9/15.
//  Copyright (c) 2015年 Vision. All rights reserved.
//

#import "TTCBaseView.h"
#import "TTCBaseTableView.h"
#import "TTCBaseTableViewCell.h"

typedef NS_ENUM(NSInteger, TTCSelectViewStyle) {
    TTCSelectViewStyleCity,
    TTCSelectViewStyleCar,
};

@protocol TTCSelectViewDelegate;
@protocol TTCSelectViewDataSource;


@interface TTCSelectView : TTCBaseView

@property (nonatomic, weak) id<TTCSelectViewDelegate> delegate;
@property (nonatomic, weak) id<TTCSelectViewDataSource> dataSource;

+ (TTCSelectView *)tTCSelectViewWithFrame:(CGRect)frame indexArray:(NSArray *)indexArray style:(TTCSelectViewStyle)style;

- (void)reloadTableViewWithLevel:(NSInteger)level;

- (void)reloadAllTableView;

@end
@protocol TTCSelectViewDelegate <NSObject>

@optional
- (void)selectView:(TTCSelectView *)selectView tableView:(TTCBaseTableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath;
- (CGFloat)selectView:(TTCSelectView *)selectView tableView:(TTCBaseTableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath;
- (UIView *)selectView:(TTCSelectView *)selectView tableView:(TTCBaseTableView *)tableView viewForHeaderInSection:(NSInteger)section;
- (CGFloat)selectView:(TTCSelectView *)selectView tableView:(TTCBaseTableView *)tableView heightForHeaderInSection:(NSInteger)section;
@end
@protocol TTCSelectViewDataSource <NSObject>
@required
- (NSInteger)selectView:(TTCSelectView *)selectView tableView:(TTCBaseTableView *)tableView numberOfRowsInSection:(NSInteger)section;
- (TTCBaseTableViewCell *)selectView:(TTCSelectView *)selectView tableView:(TTCBaseTableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath;
@optional
- (NSInteger)selectView:(TTCSelectView *)selectView numberOfSectionsInTableView:(TTCBaseTableView *)tableView;
- (NSString *)selectView:(TTCSelectView *)selectView tableView:(TTCBaseTableView *)tableView titleForHeaderInSection:(NSInteger)section;



@end