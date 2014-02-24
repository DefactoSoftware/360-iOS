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
#import "TSFCompetenceViewController.h"
#import "UIColor+TSFColor.h"

@implementation TSFFinishQuestionnaireViewController

- (id)initWithCoder:(NSCoder *)aDecoder {
    if ((self = [super initWithCoder:aDecoder])) {
        _assessorService = [TSFAssessorService sharedService];
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.title = TSFLocalizedString(@"TSFFinishQuestionnaireViewControllerTitle", @"Finish feedback round");
    self.thankLabel.text = TSFLocalizedString(@"TSFFinishQuestionnaireViewControllerThanks", @"Bedankt voor het invullen van de vragenlijst.");
    self.infoLabel.text = TSFLocalizedString(@"TSFFinishQuestionnaireViewControllerInfo", @"Druk op 'versturen' als je tevreden bent over de antwoorden die je hebt ingevuld.");
    
    NSString *sendTitle = TSFLocalizedString(@"TSFFinishQuestionnaireViewControllerSend", @"Versturen");
    
    [self.sendButton setTitle:sendTitle forState:UIControlStateNormal];
    [self.sendButton setTintColor:[UIColor TSFOrangeColor]];
}

- (void)completionSuccess {
    self.sendButton.hidden = YES;
    self.previousButton.enabled = NO;
    self.infoLabel.text = TSFLocalizedString(@"TSFFinishQuestionnaireViewControllerCompletionSuccess", @"De vragenlijst is succesvol verzonden.");
    [self.view layoutSubviews];
}

- (void)canComplete {
    self.sendButton.enabled = YES;
}

- (IBAction)sendButtonPressed:(id)sender {
    __block typeof (self) _self = self;
    [self.questionnaireViewController completeQuestionnaireWithCompletion:^(BOOL success) {
        if (success) {
            [_self completionSuccess];
        }
    }];
}

- (IBAction)previousButtonPressed:(id)sender {
    [self.navigationController popViewControllerAnimated:YES];
}


@end
