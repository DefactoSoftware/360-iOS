//
//  TSFPasswordRequestViewController.m
//  Three Sixty Feedback
//
//  Created by Girgis Ghattas on 21-02-14.
//  Copyright (c) 2014 Defacto. All rights reserved.
//

#import "TSFPasswordRequestViewController.h"
#import "TSFGenerics.h"

@implementation TSFPasswordRequestViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItem.title = TSFLocalizedString(@"TSFPasswordRequestViewControllerTitle", @"Forgot password");
    self.emailLabel.text = TSFLocalizedString(@"TSFPasswordRequestEmailLabel", @"E-mail address");
    [self.requestButton setTitle:TSFLocalizedString(@"TSFPasswordRequestButton", @"Request new password") forState:UIControlStateNormal];
}

@end
