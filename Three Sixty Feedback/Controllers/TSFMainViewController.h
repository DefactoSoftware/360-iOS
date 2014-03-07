//
//  TSFMainViewController.h
//  Three Sixty Feedback
//
//  Created by Girgis Ghattas on 20-02-14.
//  Copyright (c) 2014 Defacto. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "UIViewController+Menu.h"

@interface TSFMainViewController : UIViewController

@property (nonatomic, strong) UIViewController *contentViewController;

- (void)setNewContentViewController:(UIViewController *)contentViewController;

@end
