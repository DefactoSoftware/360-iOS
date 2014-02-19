//
//  TSFLoginViewController.m
//  Three Sixty Feedback
//
//  Created by Girgis Ghattas on 19-02-14.
//  Copyright (c) 2014 Defacto. All rights reserved.
//

#import "TSFLoginViewController.h"
#import "TSFGenerics.h"

@implementation TSFLoginViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.emailLabel.text = TSFLocalizedString(@"TSFLoginViewControllerEmail", @"E-mail address");
    self.passwordLabel.text = TSFLocalizedString(@"TSFLoginViewControllerPassword", @"Password");
}

@end
