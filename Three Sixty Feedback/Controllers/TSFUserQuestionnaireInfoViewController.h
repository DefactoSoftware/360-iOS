//
//  TSFUserQuestionnaireInfoViewController.h
//  Three Sixty Feedback
//
//  Created by Girgis Ghattas on 25-02-14.
//  Copyright (c) 2014 Defacto. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "TSFUserQuestionnaireAssessorsViewController.h"
#import "TSFQuestionnaire.h"
#import "TSFAssessorService.h"
#import "TSFBaseViewController.h"
#import "TSFButton.h"

@interface TSFUserQuestionnaireInfoViewController : TSFBaseViewController

@property (nonatomic, strong) TSFQuestionnaire *questionnaire;
@property (nonatomic, strong) TSFAssessorService *assessorService;
@property (nonatomic, strong) TSFUserQuestionnaireAssessorsViewController *assessorsViewController;
@property (weak, nonatomic) IBOutlet UILabel *subjectLabel;
@property (weak, nonatomic) IBOutlet UILabel *descriptionLabel;
@property (weak, nonatomic) IBOutlet UIScrollView *scrollView;
@property (weak, nonatomic) IBOutlet UILabel *assessorsLabel;
@property (weak, nonatomic) IBOutlet TSFButton *remindAssessorsButton;
@property (weak, nonatomic) IBOutlet TSFButton *showTemplateButton;
@property (weak, nonatomic) IBOutlet UILabel *subjectTitleLabel;
@property (weak, nonatomic) IBOutlet UIView *assessorsView;

- (IBAction)remindButtonPressed:(id)sender;
- (void)displayAssessorsViewController;

@end
