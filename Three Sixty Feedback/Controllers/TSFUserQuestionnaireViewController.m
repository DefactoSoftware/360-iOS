//
//  TSFUserQuestionnaireViewController.m
//  Three Sixty Feedback
//
//  Created by Girgis Ghattas on 25-02-14.
//  Copyright (c) 2014 Defacto. All rights reserved.
//

#import "TSFUserQuestionnaireViewController.h"
#import "TSFGenerics.h"

@implementation TSFUserQuestionnaireViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItem.title = TSFLocalizedString(@"TSFUserQuestionnaireInfoViewControllerTitle", @"My questionnaire");
    
    ((UITabBarItem *)self.tabBar.items[0]).title = TSFLocalizedString(@"TSFUserQuestionnaireInfoViewControllerQuestionnaireTab", @"Questionnaire");
    ((UITabBarItem *)self.tabBar.items[1]).title = TSFLocalizedString(@"TSFUserQuestionnaireInfoViewControllerAssessorsTab", @"Assessors");
}

@end
