//
//  TSFQuestionnaireViewController.h
//  Three Sixty Feedback
//
//  Created by Girgis on 30/01/14.
//  Copyright (c) 2014 Defacto. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "TSFBaseViewController.h"
#import "TSFQuestionnaireService.h"
#import "TSFCompetenceService.h"
#import "TSFGenerics.h"

@interface TSFQuestionnaireViewController : TSFBaseViewController <UITableViewDataSource, UITableViewDelegate>

@property (nonatomic, strong) TSFQuestionnaireService *questionnaireService;
@property (nonatomic, strong) TSFCompetenceService *competenceService;
@property (nonatomic, strong) TSFQuestionnaire *questionnaire;
@property (weak, nonatomic) IBOutlet UITableView *keyBehavioursTableView;
@property (nonatomic, strong) NSMutableArray *currentKeyBehaviourRatingViews;
@property (weak, nonatomic) IBOutlet UIBarButtonItem *previousButton;
@property (weak, nonatomic) IBOutlet UIBarButtonItem *nextButton;

- (IBAction)nextCompetenceButtonPressed:(UIBarButtonItem *)sender;
- (IBAction)previousCompetenceButtonPressed:(UIBarButtonItem *)sender;
- (BOOL)validateInput;
- (void)displayLastCompetence;

@end
