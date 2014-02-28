//
//  TSFButton.m
//  Three Sixty Feedback
//
//  Created by Girgis Ghattas on 27-02-14.
//  Copyright (c) 2014 Defacto. All rights reserved.
//

#import "TSFButton.h"
#import "UIColor+TSFColor.h"
#import <Foundation/Foundation.h>

@implementation TSFButton

- (void)layoutSubviews {
    [super layoutSubviews];
    self.layer.cornerRadius = 5.0f;
    self.backgroundColor = [UIColor TSFGreenColor];
    self.titleLabel.textColor = [UIColor whiteColor];
    self.titleLabel.font = [UIFont systemFontOfSize:11.0f];
    self.titleEdgeInsets = UIEdgeInsetsMake(0.0f, 15.0f, 0.0f, 15.0f);
}

@end
