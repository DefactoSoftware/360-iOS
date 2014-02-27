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
}

- (void)select {
    self.pointerImageView.hidden = NO;
    self.backgroundColor = [UIColor TSFLightBlueColor];
}

- (void)unselect {
    self.pointerImageView.hidden = YES;
    self.backgroundColor = [UIColor clearColor];
}

@end