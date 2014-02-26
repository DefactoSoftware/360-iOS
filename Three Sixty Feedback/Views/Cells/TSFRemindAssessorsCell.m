//
//  TSFRemindAssessorsCell.m
//  Three Sixty Feedback
//
//  Created by Girgis Ghattas on 26-02-14.
//  Copyright (c) 2014 Defacto. All rights reserved.
//

#import "TSFRemindAssessorsCell.h"
#import "TSFGenerics.h"

@implementation TSFRemindAssessorsCell

- (void)layoutSubviews {
    [super layoutSubviews];
    [self.remindButton setTitle:TSFLocalizedString(@"TSFRemindAssessorsCellButton", @"Remind assessors")
                       forState:UIControlStateNormal];

    self.selectionStyle = UITableViewCellStyleDefault;
}

@end
