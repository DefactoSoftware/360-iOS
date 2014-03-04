//
//  TSFNewQuestionnaireConfirmViewController.m
//  Three Sixty Feedback
//
//  Created by Girgis Ghattas on 04-03-14.
//  Copyright (c) 2014 Defacto. All rights reserved.
//

#import "TSFNewQuestionnaireConfirmViewController.h"
#import "TSFGenerics.h"

@implementation TSFNewQuestionnaireConfirmViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    NSString *subjectLabelFormat = TSFLocalizedString(@"TSFNewQuestionnaireConfirmViewControllerSubjectFormat", @"The subject of the matter will be %@.");
    NSString *templateLabelFormat = TSFLocalizedString(@"TSFNewQuestionnaireViewControllerTemplateFormat", @"You have chosen the questionnaire %@ for this evaluation");
    NSString *assessorsLabelFormat = TSFLocalizedString(@"TSFNewQuestionnaireViewControllerAssessorsLabelFormat", @"The invitations will be sent to: %@.");
    NSString *assessorsList = [self.assessors componentsJoinedByString:@", "];
    
    self.subjectLabel.text = [NSString stringWithFormat:subjectLabelFormat, self.subject];
    self.templateLabel.text = [NSString stringWithFormat:templateLabelFormat, self.questionnaireTemplate.title];
    self.assessorsLabel.text = [NSString stringWithFormat:assessorsLabelFormat, assessorsList];
    
    [self.createButton setTitle:TSFLocalizedString(@"TSFNewQuestionnaireConfirmViewControllerCreate", @"Create feedback evaluation")
                       forState:UIControlStateNormal];
}

@end
