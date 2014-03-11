//
//  TSFThanksViewController.m
//  Three Sixty Feedback
//
//  Created by Girgis Ghattas on 11-03-14.
//  Copyright (c) 2014 Defacto. All rights reserved.
//

#import "TSFThanksViewController.h"
#import "TSFGenerics.h"
#import "UIColor+TSFColor.h"

@implementation TSFThanksViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.headerLabel.text = TSFLocalizedString(@"TSFThanksViewControllerHeader", @"The questionnaire has been sent.");
    self.thanksLabel.text = TSFLocalizedString(@"TSFThanksViewControllerLabel", @"You can now close the app.");
    
    self.navigationItem.title = TSFLocalizedString(@"TSFThanksViewControllerTitle", @"Questionnaire was sent");
    
    self.navigationItem.hidesBackButton = YES;
}

@end
