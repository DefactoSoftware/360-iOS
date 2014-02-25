//
//  TSFUserQuestionnaireInfoViewController.m
//  Three Sixty Feedback
//
//  Created by Girgis Ghattas on 25-02-14.
//  Copyright (c) 2014 Defacto. All rights reserved.
//

#import "TSFUserQuestionnaireInfoViewController.h"
#import "TSFUserQuestionnaireViewController.h"
#import "TSFGenerics.h"

@interface TSFUserQuestionnaireInfoViewController()
@property (nonatomic, strong) TSFUserQuestionnaireViewController *userQuestionnaireViewController;
@end

@implementation TSFUserQuestionnaireInfoViewController

- (id)initWithCoder:(NSCoder *)aDecoder {
    self = [super initWithCoder:aDecoder];
    if (self) {
        [self sharedSetup];
    }
    return self;
}

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil {
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        [self sharedSetup];
    }
    return self;
}

- (void)sharedSetup {
    _userQuestionnaireViewController = (TSFUserQuestionnaireViewController *)self.tabBarController;
}

- (void)viewDidLoad {
    TSFQuestionnaire *questionnaire = self.userQuestionnaireViewController.questionnaire;
    
    self.tabBarController.tabBarItem.title = TSFLocalizedString(@"TSFUserQuestionnaireInfoViewControllerTab", @"My questionnaire");
    
    NSString *subjectFormat = TSFLocalizedString(@"TSFUserQuestionnaireInfoViewControllerSubjectFormat", @"This questionnaire is about %@.");
    NSString *templateFormat = TSFLocalizedString(@"TSFUserQuestionnaireInfoViewControllerTemplateFormat", @"(A %@ questionnaire)");
    self.subjectLabel.text = [NSString stringWithFormat:subjectFormat, questionnaire.subject];
    self.titleLabel.text = [NSString stringWithFormat:templateFormat, questionnaire.title];
    self.descriptionLabel.text = questionnaire.questionnaireDescription;
}

@end
