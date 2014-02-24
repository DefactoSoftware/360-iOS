//
//  TSFActiveQuestionnairesViewController.m
//  Three Sixty Feedback
//
//  Created by Girgis Ghattas on 21-02-14.
//  Copyright (c) 2014 Defacto. All rights reserved.
//

#import "TSFActiveQuestionnairesViewController.h"
#import "TSFGenerics.h"
#import "TSFQuestionnaireCell.h"

static NSString *const TSFQuestionnaireCellIdentifier = @"TSFQuestionnaireCell";

@implementation TSFActiveQuestionnairesViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.questionnairesTableView.dataSource = self;
    self.questionnairesTableView.delegate = self;
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillDisappear:animated];
    self.tabBarController.navigationItem.title = TSFLocalizedString(@"TSFActiveQuestionnairesViewControllerTitle", @"Active questionnaires");
}

- (void)displayQuestionnaires:(NSArray *)questionnaires {
    self.questionnaires = questionnaires;
    [self.questionnairesTableView reloadData];
}

#pragma mark - UITableView

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return [self.questionnaires count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    TSFQuestionnaireCell *questionnaireCell = [self.questionnairesTableView dequeueReusableCellWithIdentifier:TSFQuestionnaireCellIdentifier];
    if (!questionnaireCell) {
        questionnaireCell = [[TSFQuestionnaireCell alloc] initWithStyle:UITableViewCellStyleDefault
                                                        reuseIdentifier:TSFQuestionnaireCellIdentifier];
    }
    TSFQuestionnaire *questionnaire = self.questionnaires[indexPath.row];
    
    if ([questionnaire.subject class] != [NSNull class]) {
        questionnaireCell.titleLabel.text = questionnaire.subject;
    } else {
        questionnaireCell.titleLabel.text = TSFLocalizedString(@"TSFActiveQuestionnairesViewControllerNoSubject", @"No subject");
    }
    return questionnaireCell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section {
    return 0.01f;
}

@end