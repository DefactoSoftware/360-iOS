//
//  UIViewController+Menu.m
//  Three Sixty Feedback
//
//  Created by Girgis Ghattas on 07-03-14.
//  Copyright (c) 2014 Defacto. All rights reserved.
//

#import "UIViewController+Menu.h"

@implementation UIViewController (Menu)

- (void)hideViewController:(UIViewController *)viewController {
    [viewController willMoveToParentViewController:nil];
    [viewController.view removeFromSuperview];
    [viewController removeFromParentViewController];
}

- (void)displayViewController:(UIViewController *)viewController withFrame:(CGRect)frame {
    [self addChildViewController:viewController];
    viewController.view.frame = frame;
    [self.view addSubview:viewController.view];
    [viewController didMoveToParentViewController:self];
}

- (TSFMainViewController *)rootViewController
{
    UIViewController *iter = self.parentViewController;
    while (iter) {
        if ([iter isKindOfClass:[TSFMainViewController class]]) {
            return (TSFMainViewController *)iter;
        } else if (iter.parentViewController && iter.parentViewController != iter) {
            iter = iter.parentViewController;
        } else {
            iter = nil;
        }
    }
    return nil;
}

@end
