//
//  ViewController.m
//  TTCSelectView
//
//  Created by Vision on 15/9/16.
//  Copyright (c) 2015年 Vision. All rights reserved.
//

#import "ViewController.h"
#import "TTCSelectView.h"
#import "UIView+ITTAdditions.h"
@interface ViewController ()<TTCSelectViewDataSource,TTCSelectViewDelegate>
@property (nonatomic, strong)NSArray *letters;
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    _letters = @[@"热门", @"A", @"B", @"C",
                         @"D", @"E", @"F", @"G",
                         @"H", @"I", @"J", @"K",
                         @"L", @"M", @"N", @"O",
                         @"P", @"Q", @"R", @"S",
                         @"T", @"U", @"V", @"W",
                         @"X", @"Y", @"Z"];
    TTCSelectView *newView = [TTCSelectView tTCSelectViewWithFrame:CGRectMake(0, 30, self.view.width, self.view.height - 30) indexArray:_letters style:TTCSelectViewStyleCar];
    newView.delegate = self;
    newView.dataSource = self;
    [self.view addSubview:newView];
}
- (NSInteger)selectView:(TTCSelectView *)selectView numberOfSectionsInTableView:(TTCBaseTableView *)tableView{
    return [_letters count];
}
- (NSString *)selectView:(TTCSelectView *)selectView tableView:(TTCBaseTableView *)tableView titleForHeaderInSection:(NSInteger)section{
    return _letters[section];
}
- (NSInteger)selectView:(TTCSelectView *)selectView tableView:(TTCBaseTableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return [_letters count];
}
- (TTCBaseTableViewCell *)selectView:(TTCSelectView *)selectView tableView:(TTCBaseTableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    NSString *cellId = [NSString stringWithFormat:@"cell%ld",(long)tableView.level];
    TTCBaseTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellId];
    if (!cell) {
        cell = [[TTCBaseTableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellId];
    }
    cell.textLabel.text = _letters[indexPath.row];
    return cell;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
