//
//  TSFQuestionnaireCell.m
//  Three Sixty Feedback
//
//  Created by Girgis Ghattas on 24-02-14.
//  Copyright (c) 2014 Defacto. All rights reserved.
//

#import "TSFQuestionnaireCell.h"
#import "UIColor+TSFColor.h"

@implementation TSFQuestionnaireCell

- (void)layoutSubviews {
    [super layoutSubviews];
    self.subjectLabel.textColor = [UIColor TSFBlackColor];
    self.titleLabel.textColor = [UIColor TSFGreyColor];
    self.assessorsCountLabel.textColor = [UIColor TSFGreyColor];
}

- (void)select {
    self.pointerImageView.hidden = NO;
    self.backgroundColor = [UIColor TSFLightBlueColor];
    self.colorView.backgroundColor = [UIColor TSFBlueColor];
    self.colorView.alpha = 1;
}

- (void)unselect {
    self.pointerImageView.hidden = YES;
    self.backgroundColor = [UIColor clearColor];
    self.colorView.alpha = 0.5;
}

@end