//
//  TSFCommentaryCell.m
//  Three Sixty Feedback
//
//  Created by Girgis Ghattas on 12-02-14.
//  Copyright (c) 2014 Defacto. All rights reserved.
//

#import "TSFCommentaryCell.h"
#import "TSFGenerics.h"
#import "UIColor+TSFColor.h"

@implementation TSFCommentaryCell

- (void)layoutSubviews {
    [super layoutSubviews];
    self.titleLabel.text = TSFLocalizedString(@"TSFCommentaryCellTitle", @"Commentaar (optioneel)");
    self.textView.layer.borderWidth = 1.0f;
    self.textView.layer.cornerRadius = 5.0f;
    self.textView.layer.borderColor = [[UIColor TSFLightGreyColor] CGColor];
}

@end
