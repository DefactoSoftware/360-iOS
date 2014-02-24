//
//  TSFQuestionnairesViewController.m
//  Three Sixty Feedback
//
//  Created by Girgis Ghattas on 21-02-14.
//  Copyright (c) 2014 Defacto. All rights reserved.
//

#import "TSFQuestionnairesTabBarController.h"
#import "TSFGenerics.h"

@implementation TSFQuestionnairesTabBarController

- (void)viewDidLoad {
    [super viewDidLoad];
    ((UITabBarItem *)self.tabBar.items[0]).title = TSFLocalizedString(@"TSFActiveQuestionnairesViewControllerTabTitle", @"Active");
    ((UITabBarItem *)self.tabBar.items[1]).title = TSFLocalizedString(@"TSFFinishedQuestionnairesViewControllerTabTitle", @"Finished");
}

- (IBAction)menuButtonPressed:(id)sender {
    [self.sideMenuViewController presentMenuViewController];
}

@end