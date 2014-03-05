//
//  TSFSecondaryButton.m
//  Three Sixty Feedback
//
//  Created by Girgis Ghattas on 05-03-14.
//  Copyright (c) 2014 Defacto. All rights reserved.
//

#import "TSFSecondaryButton.h"
#import "UIColor+TSFColor.h"

@implementation TSFSecondaryButton

- (void)sharedSetup {
    [super sharedSetup];
    self.fontSize = 11.0f;
}

- (void)layoutSubviews {
    [super layoutSubviews];
    self.backgroundColor = [UIColor clearColor];
    self.layer.borderColor = [[UIColor TSFSecondaryButtonColor] CGColor];
    self.layer.borderWidth = 1.0f;
    self.layer.cornerRadius = self.frame.size.height / 2;
    self.titleLabel.textColor = [UIColor TSFBlackColor];
    self.titleLabel.font = [UIFont systemFontOfSize:11.0f];
}

@end
