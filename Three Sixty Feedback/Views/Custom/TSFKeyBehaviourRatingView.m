//
//  TSFKeyBehaviourRatingView.m
//  Three Sixty Feedback
//
//  Created by Girgis Ghattas on 31-01-14.
//  Copyright (c) 2014 Defacto. All rights reserved.
//

#import "TSFKeyBehaviourRatingView.h"

@implementation TSFKeyBehaviourRatingView

- (id)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        _ratingButtons = [[NSMutableArray alloc] init];
    }
    return self;
}

- (void)layoutSubviews {
    for (NSInteger i = 1; i <= 5; i++) {
        UIButton *ratingButton = [self ratingButtonWithNumber:i];
        
        [self addSubview:ratingButton];
        [self.ratingButtons addObject:ratingButton];
    }
}

- (UIButton *)ratingButtonWithNumber:(NSInteger)number {
    CGFloat buttonWidth = self.frame.size.width / 10;
    CGFloat buttonHeight = buttonWidth;
    CGFloat buttonX = ((number * 2) - 2) * buttonWidth + (buttonWidth / 2);
    CGFloat buttonY = 0;
    
    CGRect buttonRect = CGRectMake(buttonX, buttonY, buttonWidth, buttonHeight);
    UIButton *button = [[UIButton alloc] initWithFrame:buttonRect];
    [button setTitle:[NSString stringWithFormat:@"%d", number] forState:UIControlStateNormal];
    button.backgroundColor = [UIColor blackColor];
    button.layer.cornerRadius = buttonWidth / 2;

    button.titleLabel.font = [UIFont fontWithName:@"Diwan Mishafi" size:13.0f];
    button.titleLabel.textAlignment = NSTextAlignmentCenter;
    
    return button;
}

@end
