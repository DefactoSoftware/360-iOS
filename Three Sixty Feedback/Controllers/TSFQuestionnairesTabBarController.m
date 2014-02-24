//
//  TSFQuestionnairesViewController.m
//  Three Sixty Feedback
//
//  Created by Girgis Ghattas on 21-02-14.
//  Copyright (c) 2014 Defacto. All rights reserved.
//

#import "TSFQuestionnairesTabBarController.h"
#import "TSFGenerics.h"
#import <CRToast/CRToast.h>

@implementation TSFQuestionnairesTabBarController

- (id)initWithCoder:(NSCoder *)aDecoder {
    if ((self = [super initWithCoder:aDecoder])) {
        [self sharedSetup];
    }
    return self;
}

- (id)initWithNibName:(NSString *)nibNameOrNil
               bundle:(NSBundle *)nibBundleOrNil {
    if ((self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil])) {
        [self sharedSetup];
    }
    return self;
}

- (void)sharedSetup {
    _questionnaireService = [TSFQuestionnaireService sharedService];
    _assessorService = [TSFAssessorService sharedService];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    ((UITabBarItem *)self.tabBar.items[0]).title = TSFLocalizedString(@"TSFActiveQuestionnairesViewControllerTabTitle", @"Active");
    ((UITabBarItem *)self.tabBar.items[1]).title = TSFLocalizedString(@"TSFFinishedQuestionnairesViewControllerTabTitle", @"Finished");
    
    self.activeQuestionnairesViewController = [self.viewControllers firstObject];
    self.finishedQuestionnairesViewController = [self.viewControllers lastObject];
    
    [self loadQuestionnaires];
}

- (void)loadQuestionnaires {
    __weak typeof (self) _self = self;
    
    [self.questionnaireService userQuestionnairesWithSuccess:^(NSArray *questionnaires) {
        _self.questionnaires = questionnaires;
        [_self.activeQuestionnairesViewController displayQuestionnaires:questionnaires];
    } failure:^(NSError *error) {
        NSDictionary *options = @{kCRToastTextKey : TSFLocalizedString(@"TSFQuestionnairesTabBarControllerError", @"Failed getting questionnaires."),
                                  kCRToastTextAlignmentKey : @(NSTextAlignmentCenter),
                                  kCRToastBackgroundColorKey : [UIColor redColor]};
        [CRToastManager showNotificationWithOptions:options completionBlock:^{ }];
        NSLog(@"Error getting user questionnaires: %@.", error);
    }];
}

- (void)loadAssessors {
    for (TSFQuestionnaire *questionnaire in self.questionnaires) {
        __block TSFQuestionnaire *_questionnaire = questionnaire;
        
        [self.assessorService assessorsForQuestionnaireId:questionnaire.questionnaireId withSuccess:^(NSArray *assessors) {
            _questionnaire.assessors = assessors;
        } failure:^(NSError *error) {
            
        }];
    }
}

- (IBAction)menuButtonPressed:(id)sender {
    [self.sideMenuViewController presentMenuViewController];
}

@end