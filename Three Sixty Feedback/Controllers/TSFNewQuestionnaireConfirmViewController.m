//
//  TSFNewQuestionnaireConfirmViewController.m
//  Three Sixty Feedback
//
//  Created by Girgis Ghattas on 04-03-14.
//  Copyright (c) 2014 Defacto. All rights reserved.
//

#import "TSFNewQuestionnaireConfirmViewController.h"
#import "TSFQuestionnairesViewController.h"
#import "TSFQuestionnairesNavigationController.h"
#import "TSFAppDelegate.h"
#import "CRToast.h"
#import "UIColor+TSFColor.h"
#import "TSFGenerics.h"

static NSString *const TSFQuestionnairesNavigationControllerIdentifier = @"TSFQuestionnairesViewControllerNavigation";

@interface TSFNewQuestionnaireConfirmViewController()
@property (nonatomic, assign) NSInteger invitedAssessorsCount;
@end

@implementation TSFNewQuestionnaireConfirmViewController

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
    _questionnaireService = [TSFQuestionnaireService sharedService];
    _assessorService = [TSFAssessorService sharedService];
    _invitedAssessorsCount = 0;
}

- (void)checkInvitationCompleted {
    if (self.invitedAssessorsCount == [self.assessors count]) {
        TSFAppDelegate *delegate = [[UIApplication sharedApplication] delegate];
        TSFQuestionnairesNavigationController *questionnairesNavigationController = [self.storyboard instantiateViewControllerWithIdentifier:TSFQuestionnairesNavigationControllerIdentifier];
        questionnairesNavigationController.showAddedNotification = YES;
        delegate.window.rootViewController = questionnairesNavigationController;
    }
}

- (void)inviteAssessorsForQuestionnaire:(TSFQuestionnaire *)questionnaire {
    __weak typeof(self) _self = self;
    
    for (NSString *assessorEmail in self.assessors) {
        [self.assessorService createAssessorWithEmail:assessorEmail
                                   forQuestionnaireId:questionnaire.questionnaireId
                                          withSuccess:^(id responseObject) {
                                              _self.invitedAssessorsCount++;
                                              [_self checkInvitationCompleted];
                                          }
                                              failure:^(NSError *error) {
                                                  NSDictionary *options = @{kCRToastTextKey : TSFLocalizedString(@"TSFNewQuestionnaireConfirmViewControllerInviteError", @"Could not invite assessor."),
                                                                            kCRToastTextAlignmentKey : @(NSTextAlignmentCenter),
                                                                            kCRToastBackgroundColorKey : [UIColor TSFErrorColor]};
                                                  [CRToastManager showNotificationWithOptions:options completionBlock:^{ }];
                                              }];
    }
}

- (void)createQuestionnaire {
    __weak typeof (self) _self = self;
    [self.questionnaireService createQuestionnaireWithSubject:self.subject
                                                   templateId:self.questionnaireTemplate.templateId
                                                      success:^(TSFQuestionnaire *questionnaire) {
                                                          [_self inviteAssessorsForQuestionnaire:questionnaire];
    }
                                                      failure:^(NSError *error) {
                                                          NSDictionary *options = @{kCRToastTextKey : TSFLocalizedString(@"TSFNewQuestionnaireConfirmViewControllerCreateError", @"Could not create questionnaire."),
                                                                                    kCRToastTextAlignmentKey : @(NSTextAlignmentCenter),
                                                                                    kCRToastBackgroundColorKey : [UIColor TSFErrorColor]};
                                                          [CRToastManager showNotificationWithOptions:options completionBlock:^{ }];
    }];
}

- (IBAction)confirmButtonPressed:(id)sender {
    [self createQuestionnaire];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    NSString *subjectLabelFormat = TSFLocalizedString(@"TSFNewQuestionnaireConfirmViewControllerSubjectFormat", @"The subject of the matter will be %@.");
    NSString *templateLabelFormat = TSFLocalizedString(@"TSFNewQuestionnaireViewControllerTemplateFormat", @"You have chosen the questionnaire %@ for this evaluation");
    NSString *assessorsLabelFormat = TSFLocalizedString(@"TSFNewQuestionnaireViewControllerAssessorsLabelFormat", @"The invitations will be sent to: %@.");
    NSString *assessorsList = [self.assessors componentsJoinedByString:@", "];
    
    NSString *subject = [NSString stringWithFormat:subjectLabelFormat, self.subject];
    NSString *template = [NSString stringWithFormat:templateLabelFormat, self.questionnaireTemplate.title];
    NSString *assessors = [NSString stringWithFormat:assessorsLabelFormat, assessorsList];
    
    [self.createButton setTitle:TSFLocalizedString(@"TSFNewQuestionnaireConfirmViewControllerCreate", @"Create feedback evaluation")
                       forState:UIControlStateNormal];
    
    NSMutableAttributedString *subjectAttributed = [[NSMutableAttributedString alloc] initWithString:subject];
    NSMutableAttributedString *templateAttributed = [[NSMutableAttributedString alloc] initWithString:template];
    NSMutableAttributedString *assessorsAttributed = [[NSMutableAttributedString alloc]  initWithString:assessors];
    
    [subjectAttributed beginEditing];
    [self boldMatchedString:self.subject
  inMutableAttributedString:subjectAttributed];
    [subjectAttributed endEditing];
    
    [templateAttributed beginEditing];
    [self boldMatchedString:self.questionnaireTemplate.title
  inMutableAttributedString:templateAttributed];
    [templateAttributed endEditing];
    
    [assessorsAttributed beginEditing];
    [self boldMatchedString:assessorsList
  inMutableAttributedString:assessorsAttributed];
    [assessorsAttributed endEditing];
    
    [self.subjectLabel setAttributedText:subjectAttributed];
    [self.templateLabel setAttributedText:templateAttributed];
    [self.assessorsLabel setAttributedText:assessorsAttributed];
}

- (void)boldMatchedString:(NSString *)matchedString inMutableAttributedString:(NSMutableAttributedString *)attributedString {
    CGFloat fontSize = (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad) ? 14.0f : 13.0f;
    NSString *fontName = @"Helvetica-Bold";
    
    NSError *error = nil;
    if (matchedString) {
        NSRegularExpression *scaleRegex = [NSRegularExpression regularExpressionWithPattern:matchedString
                                                                                    options:NSRegularExpressionCaseInsensitive
                                                                                      error:&error];
        NSTextCheckingResult *scaleResult = [scaleRegex firstMatchInString:(NSString *)attributedString.string
                                                                   options:0
                                                                     range:NSMakeRange(0, [attributedString length])];
        [attributedString addAttribute:NSFontAttributeName
                                 value:[UIFont fontWithName:fontName size:fontSize]
                                 range:NSMakeRange(scaleResult.range.location, scaleResult.range.length)];
    }
}

@end
