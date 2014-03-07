//
//  TSFMenuSegue.m
//  Three Sixty Feedback
//
//  Created by Girgis Ghattas on 06-03-14.
//  Copyright (c) 2014 Defacto. All rights reserved.
//

#import "TSFMenuSegue.h"
#import "TSFMenuViewController.h"

@implementation TSFMenuSegue

- (void)perform {
    TSFMenuViewController *menuViewController = self.destinationViewController;
    menuViewController.contentViewControlller = self.sourceViewController;
    [super perform];
}

@end
