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

static NSString *const TSFQuestionnaireAssessorsSegueIdentifier = @"TSFAssessorsPopoverSegue";

@implementation TSFUserQuestionnaireInfoViewController

- (void)viewDidLoad {
    self.tabBarController.tabBarItem.title = TSFLocalizedString(@"TSFUserQuestionnaireInfoViewControllerTab", @"My questionnaire");
    [self.assessorsButton setTitle:TSFLocalizedString(@"TSFUserQuestionnaireInfoAssessorsBUtton", @"Assessors") forState:UIControlStateNormal];
    
    NSString *subjectFormat = TSFLocalizedString(@"TSFUserQuestionnaireInfoViewControllerSubjectFormat", @"This questionnaire is about %@.");
    NSString *templateFormat = TSFLocalizedString(@"TSFUserQuestionnaireInfoViewControllerTemplateFormat", @"(A %@ questionnaire)");
    self.subjectLabel.text = [NSString stringWithFormat:subjectFormat, self.questionnaire.subject];
    self.titleLabel.text = [NSString stringWithFormat:templateFormat, self.questionnaire.title];
    self.descriptionLabel.text = self.questionnaire.questionnaireDescription;
}

#pragma mark - Prepare for segue

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    if ([segue.identifier isEqualToString:TSFQuestionnaireAssessorsSegueIdentifier]) {
        TSFUserQuestionnaireAssessorsViewController *destinationViewController = (TSFUserQuestionnaireAssessorsViewController *)segue.destinationViewController;
        destinationViewController.questionnaire = self.questionnaire;
    }
}

@end
