//
//  TSFUserQuestionnaireInfoViewController.m
//  Three Sixty Feedback
//
//  Created by Girgis Ghattas on 25-02-14.
//  Copyright (c) 2014 Defacto. All rights reserved.
//

#import "TSFUserQuestionnaireInfoViewController.h"
#import "TSFUserQuestionnaireAssessorsViewController.h"
#import "TSFTemplateViewController.h"
#import "TSFGenerics.h"
#import "TSFAssessorCell.h"
#import "CRToast.h"
#import "UIColor+TSFColor.h"

static NSString *const TSFUserQuestionnaireAssessorsViewControllerIdentifier = @"TSFUserQuestionnaireAssessorsViewController";
static NSString *const TSFQuestionnaireAssessorsSegueIdentifier = @"TSFAssessorsPopoverSegue";
static NSString *const TSFTemplateModalSegueIdentifier = @"TSFTemplateModalSegue";
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
    [super viewDidLoad];
    
    self.tabBarController.tabBarItem.title = TSFLocalizedString(@"TSFUserQuestionnaireInfoViewControllerTab", @"My questionnaire");

    self.subjectTitleLabel.text = TSFLocalizedString(@"TSFUserQuestionnaireInfoViewControllerSubjectFormat", @"This questionnaire is about");
    self.subjectLabel.text = self.questionnaire.subject;
    self.descriptionLabel.text = self.questionnaire.questionnaireDescription;
    
    self.subjectTitleLabel.textColor = [UIColor TSFLightGreyTextColor];
    self.descriptionLabel.textColor = [UIColor TSFLightGreyTextColor];
    self.subjectLabel.textColor = [UIColor TSFLightGreyTextColor];
    [self.showTemplateButton setTitle:TSFLocalizedString(@"TSFUserQuestionnaireInfoViewControllerShowTemplate", @"Questions")
                             forState:UIControlStateNormal];
    [self.remindAssessorsButton setIconImage:[UIImage imageNamed:@"time"]];
    [self.showTemplateButton setIconImage:[UIImage imageNamed:@"questionnaire"]];
    
    self.assessorsLabel.text = TSFLocalizedString(@"TSFUserQuestionnaireInfoViewControllerAssessors", @"Assessors");
    [self.remindAssessorsButton setTitle:TSFLocalizedString(@"TSFUserQuestionnaireInfoViewControllerRemindButton", @"Send reminders")
                                forState:UIControlStateNormal];
    
    if (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad) {
        [self displayAssessorsViewController];
    }
}

- (void)displayAssessorsViewController {
    self.assessorsViewController = [self.storyboard instantiateViewControllerWithIdentifier:TSFUserQuestionnaireAssessorsViewControllerIdentifier];
    self.assessorsViewController.questionnaire = self.questionnaire;
    
    for (UIView *view in self.assessorsView.subviews) {
        [view removeFromSuperview];
    }
    
    UIView *assessorsControllerView = self.assessorsViewController.view;
    assessorsControllerView.translatesAutoresizingMaskIntoConstraints = NO;
    
    [self.assessorsView addSubview:assessorsControllerView];
    
    NSLayoutConstraint *width = [NSLayoutConstraint
                                constraintWithItem:assessorsControllerView
                                 attribute:NSLayoutAttributeWidth
                                 relatedBy:0
                                 toItem:self.assessorsView
                                 attribute:NSLayoutAttributeWidth
                                 multiplier:1.0
                                 constant:0];
    NSLayoutConstraint *height = [NSLayoutConstraint
                                 constraintWithItem:assessorsControllerView
                                 attribute:NSLayoutAttributeHeight
                                 relatedBy:0
                                 toItem:self.assessorsView
                                 attribute:NSLayoutAttributeHeight
                                 multiplier:1.0
                                 constant:0];
    NSLayoutConstraint *top = [NSLayoutConstraint
                               constraintWithItem:assessorsControllerView
                               attribute:NSLayoutAttributeTop
                               relatedBy:NSLayoutRelationEqual
                               toItem:self.assessorsView
                               attribute:NSLayoutAttributeTop
                               multiplier:1.0f
                               constant:0];
    NSLayoutConstraint *leading = [NSLayoutConstraint
                                   constraintWithItem:assessorsControllerView
                                   attribute:NSLayoutAttributeLeading
                                   relatedBy:NSLayoutRelationEqual
                                   toItem:self.assessorsView
                                   attribute:NSLayoutAttributeLeading
                                   multiplier:1.0
                                   constant:0];
    [self.assessorsView addConstraint:width];
    [self.assessorsView addConstraint:height];
    [self.assessorsView addConstraint:top];
    [self.assessorsView addConstraint:leading];
}

- (IBAction)remindButtonPressed:(id)sender {
    [self.assessorsViewController remindAssessors];
}

#pragma mark - Prepare for segue

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    if ([segue.identifier isEqualToString:TSFQuestionnaireAssessorsSegueIdentifier]) {
        TSFUserQuestionnaireAssessorsViewController *destinationViewController = (TSFUserQuestionnaireAssessorsViewController *)segue.destinationViewController;
        destinationViewController.questionnaire = self.questionnaire;
    } else if ([segue.identifier isEqualToString:TSFTemplateModalSegueIdentifier]) {
        TSFTemplateViewController *destinationViewController = (TSFTemplateViewController *)segue.destinationViewController;
        destinationViewController.questionnaireTemplate = self.questionnaire;
    }
}

@end
