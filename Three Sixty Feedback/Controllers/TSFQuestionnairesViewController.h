//
//  TSFQuestionnairesViewController.h
//  Three Sixty Feedback
//
//  Created by Girgis Ghattas on 26-02-14.
//  Copyright (c) 2014 Defacto. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "TSFBaseViewController.h"
#import "TSFAssessorService.h"
#import "TSFQuestionnaireService.h"
#import "TSFUserQuestionnaireInfoViewController.h"
#import "CRToast.h"

@interface TSFQuestionnairesViewController : TSFBaseViewController <UITableViewDelegate, UITableViewDataSource>

@property (nonatomic, strong) TSFAssessorService *assessorService;
@property (nonatomic, strong) TSFQuestionnaireService *questionnaireService;
@property (weak, nonatomic) IBOutlet UITableView *questionnairesTableView;
@property (nonatomic, strong) NSArray *questionnaires;
@property (nonatomic, strong) NSArray *activeQuestionnaires;
@property (nonatomic, strong) NSArray *completedQuestionnaires;
@property (weak, nonatomic) IBOutlet UISegmentedControl *activeSegmentedControl;
@property (weak, nonatomic) IBOutlet UIView *detailView;

- (void)reloadData;
- (void)loadAssessors;
- (void)loadQuestionnaires;
- (void)filterQuestionnaires;
- (IBAction)segmentedControlChanged:(id)sender;
- (TSFUserQuestionnaireInfoViewController *)questionnaireViewControllerForQuestionnaire:(TSFQuestionnaire *)questionnaire;

@end
