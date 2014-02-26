//
//  TSFMainViewController.m
//  Three Sixty Feedback
//
//  Created by Girgis Ghattas on 20-02-14.
//  Copyright (c) 2014 Defacto. All rights reserved.
//

#import "TSFMainViewController.h"

static NSString *const TSFMainContentViewControllerIdentifier = @"TSFQuestionnairesViewControllerNavigation";
static NSString *const TSFMenuViewControllerIdentifier = @"TSFMenuViewController";

@implementation TSFMainViewController

- (void)awakeFromNib {
    [super awakeFromNib];
    self.contentViewController = [self.storyboard instantiateViewControllerWithIdentifier:TSFMainContentViewControllerIdentifier];
    self.menuViewController = [self.storyboard instantiateViewControllerWithIdentifier:TSFMenuViewControllerIdentifier];
}

@end