//
//  TSFFinishQuestionnaireViewController.m
//  Three Sixty Feedback
//
//  Created by Girgis Ghattas on 02-02-14.
//  Copyright (c) 2014 Defacto. All rights reserved.
//

#import "TSFFinishQuestionnaireViewController.h"
#import "TSFGenerics.h"
#import "NZAlertView.h"
#import "TSFQuestionnaireViewController.h"

@implementation TSFFinishQuestionnaireViewController

- (id)initWithCoder:(NSCoder *)aDecoder {
    if ((self = [super initWithCoder:aDecoder])) {
        _assessorService = [TSFAssessorService sharedService];
    }
    return self;
}

- (void)viewDidLoad {
    self.title = TSFLocalizedString(@"TSFFinishQuestionnaireViewControllerTitle", @"Finish feedback round");
    self.thankLabel.text = TSFLocalizedString(@"TSFFinishQuestionnaireViewControllerThanks", @"Bedankt voor het invullen van de vragenlijst.");
    self.infoLabel.text = TSFLocalizedString(@"TSFFinishQuestionnaireViewControllerInfo", @"Druk op 'versturen' als je tevreden bent over de antwoorden die je hebt ingevuld.");
    
    NSString *sendTitle = TSFLocalizedString(@"TSFFinishQuestionnaireViewControllerSend", @"Versturen");
    
    [self.sendButton setTitle:sendTitle forState:UIControlStateNormal];
    
    [self addGestureRecognizer];
}

- (void)addGestureRecognizer {
    UISwipeGestureRecognizer *previousSwipeRecognizer = [[UISwipeGestureRecognizer alloc] initWithTarget:self action:@selector(handlePreviousSwipeFrom:)];
    [previousSwipeRecognizer setDirection:(UISwipeGestureRecognizerDirectionRight)];
    [self.view addGestureRecognizer:previousSwipeRecognizer];
}

- (void)handlePreviousSwipeFrom:(UIGestureRecognizer *)recognizer {
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)completionFailure {
    NSString *validationErrorMessage = TSFLocalizedString(@"TSFFinishQuestionnaireViewControllerError", @"Er is iets misgegaan bij het versturen.");
    NSString *validationErrorTitle = TSFLocalizedString(@"TSFFinishQuestionnaireViewControllerErrorMessage", @"Probeer het nogmaals.");

    NZAlertView *validationAlert = [[NZAlertView alloc] initWithStyle:NZAlertStyleError
                                                                title:validationErrorTitle
                                                              message:validationErrorMessage
                                                             delegate:nil];
    [validationAlert setStatusBarColor:[UIColor redColor]];
    [validationAlert setTextAlignment:NSTextAlignmentCenter];
    
    [validationAlert show];
}

- (void)completionSuccess {
    self.sendButton.hidden = YES;
    self.previousButton.enabled = NO;
    self.infoLabel.text = TSFLocalizedString(@"TSFFinishQuestionnaireViewControllerCompletionSuccess", @"De vragenlijst is succesvol verzonden.");
    [self.view layoutSubviews];
}

- (void)sendCompletion {
    __weak typeof (self) _self = self;
    [self.assessorService completeCurrentAssessmentWithSuccess:^(NSNumber *completed) {
        [_self completionSuccess];
    } failure:^(NSError *error) {
        [_self completionFailure];
    }];
}

- (IBAction)sendButtonPressed:(id)sender {
    [self sendCompletion];
}

- (IBAction)previousButtonPressed:(id)sender {
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    TSFQuestionnaireViewController *destinationViewController = (TSFQuestionnaireViewController *)segue.destinationViewController;

    [destinationViewController displayLastCompetence];
}

@end
