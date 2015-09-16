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
@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    NSArray *letters = @[@"热门", @"A", @"B", @"C",
                         @"D", @"E", @"F", @"G",
                         @"H", @"I", @"J", @"K",
                         @"L", @"M", @"N", @"O",
                         @"P", @"Q", @"R", @"S",
                         @"T", @"U", @"V", @"W",
                         @"X", @"Y", @"Z"];
    TTCSelectView *newView = [TTCSelectView tTCSelectViewWithFrame:CGRectMake(0, 0, self.view.width, self.view.height) indexArray:letters style:TTCSelectViewStyleCar];
    [self.view addSubview:newView];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
