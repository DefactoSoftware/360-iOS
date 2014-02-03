//
//  TSFHomeViewController.m
//  Three Sixty Feedback
//
//  Created by Girgis Ghattas on 03-02-14.
//  Copyright (c) 2014 Defacto. All rights reserved.
//

#import "TSFHomeViewController.h"
#import "TSFGenerics.h"

@implementation TSFHomeViewController

- (void)viewDidLoad {
    self.title = TSFLocalizedString(@"TSFHomeViewControllerTitle", @"360° Feedback");
    self.introLabel.text = TSFLocalizedString(@"TSFHomeViewControllerIntroText", @"Welkom. Om een feedbackronde in te vullen kan je op de link in de uitnodigingsmail tikken.");
}

@end
