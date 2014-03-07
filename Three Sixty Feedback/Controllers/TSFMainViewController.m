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
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self displayViewController:self.contentViewController
                      withFrame:self.view.bounds];
}

- (void)setNewContentViewController:(UIViewController *)contentViewController {
    if (!self.contentViewController) {
        self.contentViewController = contentViewController;
        return;
    }
    CGRect frame = self.contentViewController.view.frame;
    CGAffineTransform transform = self.contentViewController.view.transform;
    [self hideViewController:self.contentViewController];
    self.contentViewController = contentViewController;
    [self displayViewController:contentViewController
                      withFrame:self.view.bounds];
    contentViewController.view.transform = transform;
    contentViewController.view.frame = frame;
    
}

@end