//
//  UIViewController+Menu.h
//  Three Sixty Feedback
//
//  Created by Girgis Ghattas on 07-03-14.
//  Copyright (c) 2014 Defacto. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "TSFMainViewController.h"

@class TSFMainViewController;

@interface UIViewController (Menu)

- (void)hideViewController:(UIViewController *)viewController;
- (void)displayViewController:(UIViewController *)viewController withFrame:(CGRect)frame;
- (TSFMainViewController *)rootViewController;

@end
