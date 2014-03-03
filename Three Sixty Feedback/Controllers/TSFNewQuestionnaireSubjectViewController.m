//
//  TSFNewQuestionnaireSubjectViewController.m
//  Three Sixty Feedback
//
//  Created by Girgis Ghattas on 03-03-14.
//  Copyright (c) 2014 Defacto. All rights reserved.
//

#import "TSFNewQuestionnaireSubjectViewController.h"
#import "TSFGenerics.h"
#import "UIColor+TSFColor.h"
#import "UITextField+Shake.h"

static NSString *const TSFNewQuestionnaireTemplateSegue = @"TSFNewQuestionnaireTemplateSegue";

@implementation TSFNewQuestionnaireSubjectViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItem.title = TSFLocalizedString(@"TSFNewQuestionnaireSubjectViewControllerTitle", @"Create a new questionnaire");
    self.subjectLabel.text = TSFLocalizedString(@"TSFNewQuestionnaireSubjectViewControllerLabel", @"What is the subject of this feedback evaluation?");
    self.subjectLabel.textColor = [UIColor TSFLightGreyTextColor];
    
    NSString *nextButtonTitle = TSFLocalizedString(@"TSFNewQuestionnaireSubjectViewControllerNext", @"Go to step 2");
    [self.nextButton setTitle:nextButtonTitle forState:UIControlStateNormal];
}

- (BOOL)validate {
    return ![self.subjectTextField.text isEqualToString:@""];
}

- (IBAction)nextButtonPressed:(id)sender {
    if ([self validate]) {
        [self performSegueWithIdentifier:TSFNewQuestionnaireTemplateSegue
                                  sender:self];
    } else {
        [self.subjectTextField shake:10
                           withDelta:10
                            andSpeed:0.05];
    }
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue
                 sender:(id)sender {
    TSFNewQuestionnaireTemplateViewController *destionationViewController = (TSFNewQuestionnaireTemplateViewController *)segue.destinationViewController;
    destionationViewController.subject = self.subjectTextField.text;
}

@end
