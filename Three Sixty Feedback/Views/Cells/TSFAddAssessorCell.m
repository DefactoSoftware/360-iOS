//
//  TSFAddAssessorCell.m
//  Three Sixty Feedback
//
//  Created by Girgis Ghattas on 04-03-14.
//  Copyright (c) 2014 Defacto. All rights reserved.
//

#import "TSFAddAssessorCell.h"
#import "TSFGenerics.h"
#import "UIColor+TSFColor.h"

@implementation TSFAddAssessorCell

- (void)layoutSubviews {
    [super layoutSubviews];
    [self.removeButton setTitle:TSFLocalizedString(@"TSFAddAssessorCellRemoveButton", @"Remove")
                       forState:UIControlStateNormal];
    self.emailLabel.textColor = [UIColor TSFLightGreyTextColor];
}

@end
