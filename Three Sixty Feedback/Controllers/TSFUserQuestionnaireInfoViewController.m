//
//  TSFUserQuestionnaireInfoViewController.m
//  Three Sixty Feedback
//
//  Created by Girgis Ghattas on 25-02-14.
//  Copyright (c) 2014 Defacto. All rights reserved.
//

#import "TSFUserQuestionnaireInfoViewController.h"
#import "TSFUserQuestionnaireAssessorsViewController.h"
#import "TSFGenerics.h"
#import "TSFAssessorCell.h"
#import "CRToastManager+TSFToast.h"

static NSString *const TSFQuestionnaireAssessorsSegueIdentifier = @"TSFAssessorsPopoverSegue";
static NSString *const TSFAssessorCellIdentifier = @"TSFAssessorCell";

@implementation TSFUserQuestionnaireInfoViewController

- (id)initWithCoder:(NSCoder *)aDecoder {
    self = [super initWithCoder:aDecoder];
    if (self) {
        [self sharedSetup];
    }
    return self;
}

- (id)initWithNibName:(NSString *)nibNameOrNil
               bundle:(NSBundle *)nibBundleOrNil {
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        [self sharedSetup];
    }
    return self;
}

- (void)sharedSetup {
    _assessorService = [TSFAssessorService sharedService];
}

- (void)viewDidLoad {
    self.tabBarController.tabBarItem.title = TSFLocalizedString(@"TSFUserQuestionnaireInfoViewControllerTab", @"My questionnaire");

    NSString *subjectFormat = TSFLocalizedString(@"TSFUserQuestionnaireInfoViewControllerSubjectFormat", @"This questionnaire is about %@.");
    NSString *templateFormat = TSFLocalizedString(@"TSFUserQuestionnaireInfoViewControllerTemplateFormat", @"(A %@ questionnaire)");
    self.subjectLabel.text = [NSString stringWithFormat:subjectFormat, self.questionnaire.subject];
    self.titleLabel.text = [NSString stringWithFormat:templateFormat, self.questionnaire.title];
    self.descriptionLabel.text = self.questionnaire.questionnaireDescription;

    [self setupAssessorsTableView];
}

- (void)setupAssessorsTableView {
    self.assessorsLabel.text = TSFLocalizedString(@"TSFUserQuestionnaireInfoViewControllerAssessors", @"Assessors");
    [self.remindAssessorsButton setTitle:TSFLocalizedString(@"TSFUserQuestionnaireInfoViewControllerRemindButton", @"Send reminders")
                                forState:UIControlStateNormal];

    if(UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad) {
        self.assessorsTableView.dataSource = self;
        self.assessorsTableView.delegate = self;
        [self.assessorsTableView reloadData];
    }
}

- (IBAction)remindButtonPressed:(id)sender {
    [self remindAssessors];
}

- (void)remindAssessors {
    for (TSFAssessor *assessor in self.questionnaire.assessors) {
        if (!assessor.completed) {
            __weak typeof (self) _self = self;
            [self.assessorService remindAssessorWithId:assessor.assessorId success:^(id response) {
                [_self reloadAssessors];
            } failure:^(NSError *error) {
                [CRToastManager showErrorNotificationWithMessage:TSFLocalizedString(@"TSFUserQuestionnaireInfoViewControllerReminderError", @"Assessor has already been reminded in the last 24 hours.")
                                                           error:error
                                                 completionBlock:^{}];
            }];
        }
    }
}

- (void)reloadAssessors {
    __weak typeof (self) _self = self;
    [self.assessorService assessorsForQuestionnaireId:self.questionnaire.questionnaireId withSuccess:^(id responseObject) {
        _self.questionnaire.assessors = (NSArray *)responseObject;
        [_self setupAssessorsTableView];
    } failure:^(NSError *error) {
        [CRToastManager showErrorNotificationWithMessage:TSFLocalizedString(@"TSFUserQuestionnaireInfoViewControllerReloadError", @"Could not reload assessors.")
                                         completionBlock:^{}];
    }];
}

#pragma mark - Prepare for segue

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    if ([segue.identifier isEqualToString:TSFQuestionnaireAssessorsSegueIdentifier]) {
        TSFUserQuestionnaireAssessorsViewController *destinationViewController = (TSFUserQuestionnaireAssessorsViewController *)segue.destinationViewController;
        destinationViewController.questionnaire = self.questionnaire;
    }
}

#pragma mark - UITableView

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return [self.questionnaire.assessors count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView
         cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    TSFAssessorCell *assessorCell = [self.assessorsTableView dequeueReusableCellWithIdentifier:TSFAssessorCellIdentifier];
    if (!assessorCell) {
        assessorCell = [[TSFAssessorCell alloc] initWithStyle:UITableViewCellStyleDefault
                                              reuseIdentifier:TSFAssessorCellIdentifier];
    }

    TSFAssessor *assessor = self.questionnaire.assessors[indexPath.row];
    [assessorCell displayAssessor:assessor];

    return assessorCell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    TSFAssessorCell *assessorCell = (TSFAssessorCell *)[self tableView:self.assessorsTableView
                              cellForRowAtIndexPath:indexPath];
    return [assessorCell calculatedHeight];
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section {
    return 0.01f;
}

@end
