//
//  TSFUserQuestionnaireViewController.m
//  Three Sixty Feedback
//
//  Created by Girgis Ghattas on 25-02-14.
//  Copyright (c) 2014 Defacto. All rights reserved.
//

#import "TSFUserQuestionnaireTabBarController.h"
#import "TSFGenerics.h"

@implementation TSFUserQuestionnaireTabBarController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.infoViewController = [self.viewControllers firstObject];
    self.assessorsViewController = [self.viewControllers lastObject];
    self.infoViewController.questionnaire = self.questionnaire;
    self.assessorsViewController.questionnaire = self.questionnaire;
    
    self.navigationItem.title = TSFLocalizedString(@"TSFUserQuestionnaireInfoViewControllerTitle", @"My questionnaire");
    
    ((UITabBarItem *)self.tabBar.items[0]).title = TSFLocalizedString(@"TSFUserQuestionnaireInfoViewControllerQuestionnaireTab", @"Questionnaire");
    ((UITabBarItem *)self.tabBar.items[1]).title = TSFLocalizedString(@"TSFUserQuestionnaireInfoViewControllerAssessorsTab", @"Assessors");
    
    self.infoViewController = (TSFUserQuestionnaireInfoViewController *)[self.viewControllers firstObject];
    self.assessorsViewController = (TSFUserQuestionnaireAssessorsViewController *)[self.viewControllers lastObject];
}

@end
