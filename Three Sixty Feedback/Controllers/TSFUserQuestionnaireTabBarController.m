//
//  TSFUserQuestionnaireViewController.m
//  Three Sixty Feedback
//
//  Created by Girgis Ghattas on 25-02-14.
//  Copyright (c) 2014 Defacto. All rights reserved.
//

#import "TSFUserQuestionnaireTabBarController.h"
#import "TSFGenerics.h"
#import "UIColor+TSFColor.h"

@implementation TSFUserQuestionnaireTabBarController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor TSFBeigeColor];
    self.tabBar.backgroundColor = [UIColor TSFBlueColor];
    self.tabBar.tintColor = [UIColor TSFBlackColor];
    self.infoViewController = [self.viewControllers firstObject];
    self.assessorsViewController = [self.viewControllers lastObject];
    self.infoViewController.questionnaire = self.questionnaire;
    self.assessorsViewController.questionnaire = self.questionnaire;
    
    self.navigationItem.title = TSFLocalizedString(@"TSFUserQuestionnaireInfoViewControllerTitle", @"My questionnaire");
    
    if (!self.tabBar.hidden) {
        UITabBarItem *questionnaireItem = self.tabBar.items[0];
        UITabBarItem *assessorsItem = self.tabBar.items[1];
        questionnaireItem.title = TSFLocalizedString(@"TSFUserQuestionnaireInfoViewControllerQuestionnaireTab", @"Questionnaire");
        questionnaireItem.image = [UIImage imageNamed:@"questionnaire"];
        assessorsItem.title = TSFLocalizedString(@"TSFUserQuestionnaireInfoViewControllerAssessorsTab", @"Assessors");
        assessorsItem.image = [UIImage imageNamed:@"assessor"];
    }

    self.infoViewController = (TSFUserQuestionnaireInfoViewController *)[self.viewControllers firstObject];
    self.assessorsViewController = (TSFUserQuestionnaireAssessorsViewController *)[self.viewControllers lastObject];
}

@end
