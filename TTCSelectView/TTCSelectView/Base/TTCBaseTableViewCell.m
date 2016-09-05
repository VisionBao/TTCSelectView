//
//  TTCBaseTableViewCell.m
//  TTCMoveView
//
//  Created by Vision on 15/9/15.
//  Copyright (c) 2015年 Vision. All rights reserved.
//

#import "TTCBaseTableViewCell.h"

@implementation TTCBaseTableViewCell


- (void)awakeFromNib {
    // Initialization code
    
}


- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        self.textLabel.font = [UIFont systemFontOfSize:14];
    }
    return self;
}

@end
