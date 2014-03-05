//
//  TSFButton.h
//  Three Sixty Feedback
//
//  Created by Girgis Ghattas on 27-02-14.
//  Copyright (c) 2014 Defacto. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface TSFButton : UIButton

@property (nonatomic, strong) UIImageView *iconImageView;
@property (nonatomic, copy) NSString *stringTag;
@property (nonatomic, assign) CGFloat iconSize;
@property (nonatomic, assign) CGFloat iconX;
@property (nonatomic, assign) CGFloat fontSize;

- (void)sharedSetup;
- (void)setIconImage:(UIImage *)iconImage;

@end
