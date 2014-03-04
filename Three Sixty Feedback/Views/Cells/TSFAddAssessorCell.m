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
    [self.removeButton setIconImage:[UIImage imageNamed:@"cross-1"]];
    self.emailLabel.textColor = [UIColor TSFLightGreyTextColor];
}

@end
