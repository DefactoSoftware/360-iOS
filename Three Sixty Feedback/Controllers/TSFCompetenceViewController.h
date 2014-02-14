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

typedef void (^TSFUpdateCompetenceBlock)(BOOL);

@interface TSFCompetenceViewController : TSFBaseViewController <UITableViewDataSource, UITableViewDelegate, UITextViewDelegate>

@property (nonatomic, assign) NSInteger index;
@property (nonatomic, strong) TSFCompetenceService *competenceService;
@property (nonatomic, strong) TSFQuestionnaire *questionnaire;
@property (nonatomic, strong) TSFCompetence *competence;
@property (weak, nonatomic) IBOutlet UITableView *keyBehavioursTableView;
@property (nonatomic, strong) NSMutableArray *currentKeyBehaviourRatingViews;
@property (weak, nonatomic) IBOutlet UIBarButtonItem *previousButton;
@property (weak, nonatomic) IBOutlet UIBarButtonItem *nextButton;
@property (weak, nonatomic) IBOutlet UIScrollView *scrollView;

- (TSFCompetenceViewController *)initWithCompetence:(TSFCompetence *)competence questionnaire:(TSFQuestionnaire *)questionnaire;
- (BOOL)validateInput;
- (void)updateCompetenceWithCompletion:(TSFUpdateCompetenceBlock)completion;

@end
