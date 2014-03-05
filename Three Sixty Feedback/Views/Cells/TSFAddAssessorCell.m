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
    self.removeButton.iconSize = (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad) ? 15.0f : 10.0f;
    self.removeButton.iconX = (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad) ? 6.0f : 5.0f;
    self.emailLabel.textColor = [UIColor TSFLightGreyTextColor];
}

@end
