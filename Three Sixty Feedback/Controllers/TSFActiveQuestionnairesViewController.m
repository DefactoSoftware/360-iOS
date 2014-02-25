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

- (id)initWithCoder:(NSCoder *)aDecoder {
    self = [super initWithCoder:aDecoder];
    if (self) {
        [self sharedSetup];
    }
    return self;
}

- (id)initWithNibName:(NSString *)nibNameOrNil
               bundle:(NSBundle *)nibBundleOrNil {
    self = [super initWithNibName:nibNameOrNil
                           bundle:nibBundleOrNil];
    if (self) {
        [self sharedSetup];
    }
    return self;
}

- (void)sharedSetup {
    _questionnairesTabBarController = (TSFQuestionnairesTabBarController *)self.tabBarController;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.questionnairesTableView.dataSource = self;
    self.questionnairesTableView.delegate = self;
    self.tabBarController.tabBar.translucent = NO;
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillDisappear:animated];
    self.tabBarController.navigationItem.title = TSFLocalizedString(@"TSFActiveQuestionnairesViewControllerTitle", @"Active questionnaires");
}

- (void)reloadData {
    [self.questionnairesTableView reloadData];
}

- (TSFQuestionnaire *)questionnaireForRow:(NSInteger)row {
    TSFQuestionnaire *questionnaire = self.questionnairesTabBarController.questionnaires[row];

    if ([questionnaire.subject class] == [NSNull class]) {
        questionnaire.subject = TSFLocalizedString(@"TSFActiveQuestionnairesViewControllerNoSubject", @"No subject");
    }
    
    return questionnaire;
}

#pragma mark - UITableView

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return [self.questionnairesTabBarController.questionnaires count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    TSFQuestionnaireCell *questionnaireCell = [self.questionnairesTableView dequeueReusableCellWithIdentifier:TSFQuestionnaireCellIdentifier];
    if (!questionnaireCell) {
        questionnaireCell = [[TSFQuestionnaireCell alloc] initWithStyle:UITableViewCellStyleDefault
                                                        reuseIdentifier:TSFQuestionnaireCellIdentifier];
    }
    
    TSFQuestionnaire *questionnaire = [self questionnaireForRow:indexPath.row];
    
    NSInteger assessorsCount = [questionnaire.assessors count];
    NSInteger completedAssessorsCount = [questionnaire completedAssessors];
    questionnaireCell.assessorsCountLabel.text = [NSString stringWithFormat:@"%lu/%lu", completedAssessorsCount, assessorsCount];
    
    questionnaireCell.subjectLabel.text = questionnaire.subject;
    questionnaireCell.titleLabel.text = questionnaire.title;
    
    return questionnaireCell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    TSFQuestionnaire *questionnaire = [self questionnaireForRow:indexPath.row];
    
    CGFloat textFontSize;
    CGFloat textWidth;
    if (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad) {
        textWidth = 728.0f;
        textFontSize  = 17.0f;
    } else {
        textWidth = 280.0f;
        textFontSize = 13.0f;
    }
    
    CGFloat margin = 35.0f;
    
    CGSize constraint = CGSizeMake(textWidth, 20000.0f);
    CGSize subjectSize = CGSizeMake(0, 0);
    CGSize titleSize = CGSizeMake(0, 0);
    
    subjectSize = [questionnaire.subject boundingRectWithSize:constraint
                                                             options:(NSStringDrawingUsesLineFragmentOrigin | NSStringDrawingUsesFontLeading)
                                                          attributes:@{NSFontAttributeName: [UIFont systemFontOfSize:textFontSize]}
                                                             context:nil].size;

    titleSize = [questionnaire.title boundingRectWithSize:constraint
                                                        options:(NSStringDrawingUsesLineFragmentOrigin | NSStringDrawingUsesFontLeading)
                                               attributes:@{NSFontAttributeName: [UIFont systemFontOfSize:textFontSize]}
                                                  context:nil].size;
    return subjectSize.height + titleSize.height + margin;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section {
    return 0.01f;
}

@end