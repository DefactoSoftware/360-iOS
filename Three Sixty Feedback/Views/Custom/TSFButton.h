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

- (void)setIconImage:(UIImage *)iconImage;

@end
