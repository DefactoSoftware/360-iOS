//
//  TSFFinishedQuestionnairesViewController.m
//  Three Sixty Feedback
//
//  Created by Girgis Ghattas on 21-02-14.
//  Copyright (c) 2014 Defacto. All rights reserved.
//

#import "TSFFinishedQuestionnairesViewController.h"
#import "TSFGenerics.h"

@implementation TSFFinishedQuestionnairesViewController

- (void)viewDidLoad {
    [super viewDidLoad];
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    self.tabBarController.navigationItem.title = TSFLocalizedString(@"TSFFinishedQuestionnairesViewControllerTitle", @"Finished questionnaires");
}

@end