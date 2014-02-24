//
//  TSFActiveQuestionnairesViewController.m
//  Three Sixty Feedback
//
//  Created by Girgis Ghattas on 21-02-14.
//  Copyright (c) 2014 Defacto. All rights reserved.
//

#import "TSFActiveQuestionnairesViewController.h"
#import "TSFGenerics.h"

@implementation TSFActiveQuestionnairesViewController

- (void)viewDidLoad {
    [super viewDidLoad];
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillDisappear:animated];
    self.tabBarController.navigationItem.title = TSFLocalizedString(@"TSFActiveQuestionnairesViewControllerTitle", @"Active questionnaires");
}

@end