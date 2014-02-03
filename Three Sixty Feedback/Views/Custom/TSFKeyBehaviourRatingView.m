//
//  TSFKeyBehaviourRatingView.m
//  Three Sixty Feedback
//
//  Created by Girgis Ghattas on 31-01-14.
//  Copyright (c) 2014 Defacto. All rights reserved.
//

#import "TSFKeyBehaviourRatingView.h"
#import "UIColor+TSFColor.h"

@interface TSFKeyBehaviourRatingView ()
@property (nonatomic, strong) UIButton *selectedButton;
@property (nonatomic, strong) UIColor *selectedColor;
@property (nonatomic, strong) UIColor *defaultColor;
@property (nonatomic, assign) NSInteger numberOfOptions;
@end

@implementation TSFKeyBehaviourRatingView

- (id)initWithCoder:(NSCoder *)aDecoder {
	self = [super initWithCoder:aDecoder];
	if (self) {
		[self sharedSetup];
	}
	return self;
}

- (id)initWithFrame:(CGRect)frame {
	self = [super initWithFrame:frame];
	if (self) {
		[self sharedSetup];
	}
	return self;
}

- (void)sharedSetup {
	_ratingButtons = [[NSMutableArray alloc] init];
	_numberOfOptions = 5;
}

- (void)layoutSubviews {
	self.defaultColor = [UIColor blackColor];
	self.selectedColor = [UIColor TSFOrangeColor];

	for (NSInteger i = 1; i <= _numberOfOptions; i++) {
		UIButton *ratingButton = [self ratingButtonWithNumber:i];

		[self addSubview:ratingButton];
		[self.ratingButtons addObject:ratingButton];
	}
}

- (UIButton *)ratingButtonWithNumber:(NSInteger)number {
	CGFloat buttonWidth = self.frame.size.width / (_numberOfOptions * 2);
	CGFloat buttonHeight = buttonWidth;
	CGFloat buttonX = ((number * 2) - 2) * buttonWidth + (buttonWidth / 2);
	CGFloat buttonY = 0;

	CGRect buttonRect = CGRectMake(buttonX, buttonY, buttonWidth, buttonHeight);
	UIButton *button = [[UIButton alloc] initWithFrame:buttonRect];
	[button setTitle:[NSString stringWithFormat:@"%d", number] forState:UIControlStateNormal];
    
    if (self.selectedRating == number) {
        button.backgroundColor = self.selectedColor;
        self.selectedButton = button;
    } else {
        button.backgroundColor = self.defaultColor;
    }

	button.layer.cornerRadius = buttonWidth / 2;

	button.titleLabel.font = [UIFont fontWithName:@"Diwan Mishafi" size:13.0f];
	button.titleLabel.textAlignment = NSTextAlignmentCenter;

	button.tag = number;

	[button addTarget:self action:@selector(changeSelectedButton:) forControlEvents:UIControlEventTouchDown];

	return button;
}

- (void)changeSelectedButton:(UIButton *)pressedButton {
	self.selectedButton.backgroundColor = self.defaultColor;
	pressedButton.backgroundColor = self.selectedColor;

	self.selectedButton = pressedButton;
	self.selectedRating = pressedButton.tag;
}

- (void)resetButtons {
    for (UIButton *button in self.ratingButtons) {
        [button setBackgroundColor:self.defaultColor];
    }
    self.selectedRating = 0;
}

- (void)setRating:(NSNumber *)rating {
    self.selectedRating = [rating integerValue];
    [self layoutSubviews];
}

@end
