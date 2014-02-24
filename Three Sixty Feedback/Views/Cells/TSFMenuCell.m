//
//  TSFMenuCell.m
//  Three Sixty Feedback
//
//  Created by Girgis Ghattas on 21-02-14.
//  Copyright (c) 2014 Defacto. All rights reserved.
//

#import "TSFMenuCell.h"

@implementation TSFMenuCell

- (void)layoutSubviews {
    [super layoutSubviews];
    self.backgroundColor = [UIColor colorWithWhite:0 alpha:0];
    self.selectionStyle = UITableViewCellSelectionStyleNone;
}

@end