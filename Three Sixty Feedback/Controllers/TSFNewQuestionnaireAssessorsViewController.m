//
//  TSFNewQuestionnaireAssessorsViewController.m
//  Three Sixty Feedback
//
//  Created by Girgis Ghattas on 04-03-14.
//  Copyright (c) 2014 Defacto. All rights reserved.
//

#import "TSFNewQuestionnaireAssessorsViewController.h"
#import "TSFGenerics.h"

@implementation TSFNewQuestionnaireAssessorsViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.addAssessorTitleLabel.text = TSFLocalizedString(@"TSFNewQuestionnaireAssessorsViewControllerTitle", @"Insert the assessors email");
}

@end
