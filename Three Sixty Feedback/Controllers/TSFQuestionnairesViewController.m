//
//  TSFQuestionnairesViewController.m
//  Three Sixty Feedback
//
//  Created by Girgis Ghattas on 26-02-14.
//  Copyright (c) 2014 Defacto. All rights reserved.
//

#import "TSFQuestionnairesViewController.h"
#import "TSFGenerics.h"
#import "CRToast.h"
#import "TSFQuestionnaireCell.h"
#import "TSFUserQuestionnaireTabBarController.h"

static NSString *const TSFQuestionnaireCellIdentifier = @"TSFQuestionnaireCell";

@interface TSFQuestionnairesViewController()
@property (nonatomic, assign) BOOL showCompletedQuestionnaires;
@end

@implementation TSFQuestionnairesViewController

- (id)initWithCoder:(NSCoder *)aDecoder {
    self = [super initWithCoder:aDecoder];
    if (self) {
        [self sharedSetup];
    }
    return self;
}

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil {
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
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
    self.questionnairesTableView.dataSource = self;
    self.questionnairesTableView.delegate = self;
    
    self.navigationItem.title = TSFLocalizedString(@"TSFQuestionnairesViewControllerTitle", @"Questionnaires");
    
    [self.activeSegmentedControl setTitle:TSFLocalizedString(@"TSFQuestionnaireViewControllerActive", @"Active") forSegmentAtIndex:0];
    [self.activeSegmentedControl setTitle:TSFLocalizedString(@"TSFQuestionnaireViewControllerCompleted", @"Completed") forSegmentAtIndex:1];
    
    [self.activeSegmentedControl addTarget:self
                                    action:@selector(segmentedControlChanged:)
               forControlEvents:UIControlEventValueChanged];
    
    [self loadQuestionnaires];
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillDisappear:animated];
    self.tabBarController.navigationItem.title = TSFLocalizedString(@"TSFActiveQuestionnairesViewControllerTitle", @"Active questionnaires");
}

- (void)loadQuestionnaires {
    __weak typeof (self) _self = self;
    
    [self.questionnaireService userQuestionnairesWithSuccess:^(NSArray *questionnaires) {
        _self.questionnaires = questionnaires;
        [_self reloadData];
        [_self loadAssessors];
    } failure:^(NSError *error) {
        NSDictionary *options = @{kCRToastTextKey : TSFLocalizedString(@"TSFQuestionnairesTabBarControllerError", @"Failed getting questionnaires."),
                                  kCRToastTextAlignmentKey : @(NSTextAlignmentCenter),
                                  kCRToastBackgroundColorKey : [UIColor redColor]};
        [CRToastManager showNotificationWithOptions:options completionBlock:^{ }];
        NSLog(@"Error getting user questionnaires: %@.", error);
    }];
}

- (void)filterQuestionnaires {
    NSMutableArray *activeQuestionnaires = [[NSMutableArray alloc] init];
    NSMutableArray *completedQuestionnaires = [[NSMutableArray alloc] init];
    for (TSFQuestionnaire *questionnaire in self.questionnaires) {
        if ([questionnaire completed]) {
            [completedQuestionnaires addObject:questionnaire];
        } else {
            [activeQuestionnaires addObject:questionnaire];
        }
    }
    self.activeQuestionnaires = activeQuestionnaires;
    self.completedQuestionnaires = completedQuestionnaires;
}

- (IBAction)segmentedControlChanged:(id)sender {
    self.showCompletedQuestionnaires = self.activeSegmentedControl.selectedSegmentIndex == 1;
    [self.questionnairesTableView reloadData];
}

- (void)loadAssessors {
    __weak typeof (self) _self = self;
    
    for (TSFQuestionnaire *questionnaire in self.questionnaires) {
        __block TSFQuestionnaire *_questionnaire = questionnaire;
        
        [self.assessorService assessorsForQuestionnaireId:questionnaire.questionnaireId withSuccess:^(NSArray *assessors) {
            _questionnaire.assessors = assessors;
            [_self filterQuestionnaires];
            [_self reloadData];
        } failure:^(NSError *error) {
            NSLog(@"Error getting user's questionnaire's assessors: %@.", error);
        }];
    }
}

- (void)reloadData {
    NSMutableArray *newQuestionnaires = [[NSMutableArray alloc] init];

    for (TSFQuestionnaire *questionnaire in self.questionnaires) {
        if ((self.activeSegmentedControl.selectedSegmentIndex == 0 && ![questionnaire completed]) ||
            (self.activeSegmentedControl.selectedSegmentIndex == 1 && [questionnaire completed])) {
            [newQuestionnaires addObject:questionnaire];
        }
    }
    [self.questionnairesTableView reloadData];
}

- (TSFQuestionnaire *)questionnaireForRow:(NSInteger)row {
    TSFQuestionnaire *questionnaire = self.showCompletedQuestionnaires ? self.completedQuestionnaires[row] : self.activeQuestionnaires[row];
    
    if ([questionnaire.subject class] == [NSNull class]) {
        questionnaire.subject = TSFLocalizedString(@"TSFActiveQuestionnairesViewControllerNoSubject", @"No subject");
    }
    
    return questionnaire;
}

#pragma mark - Prepare for segue

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    TSFUserQuestionnaireTabBarController *destinationController = segue.destinationViewController;
    destinationController.questionnaire = self.activeQuestionnaires[[self.questionnairesTableView indexPathForSelectedRow].row];
}

#pragma mark - UITableView

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.showCompletedQuestionnaires ? [self.completedQuestionnaires count] : [self.activeQuestionnaires count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    TSFQuestionnaireCell *questionnaireCell = [self.questionnairesTableView dequeueReusableCellWithIdentifier:TSFQuestionnaireCellIdentifier];
    if (!questionnaireCell) {
        questionnaireCell = [[TSFQuestionnaireCell alloc] initWithStyle:UITableViewCellStyleDefault
                                                        reuseIdentifier:TSFQuestionnaireCellIdentifier];
    }
    
    TSFQuestionnaire *questionnaire = [self questionnaireForRow:indexPath.row];
    
    NSInteger assessorsCount = [questionnaire.assessors count];
    NSInteger completedAssessorsCount = [questionnaire completedAssessors];
    questionnaireCell.assessorsCountLabel.text = [NSString stringWithFormat:@"%lu/%lu", completedAssessorsCount, assessorsCount];
    
    questionnaireCell.subjectLabel.text = questionnaire.subject;
    questionnaireCell.titleLabel.text = questionnaire.title;
    
    return questionnaireCell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    TSFQuestionnaire *questionnaire = [self questionnaireForRow:indexPath.row];
    
    CGFloat textFontSize;
    CGFloat textWidth;
    if (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad) {
        textWidth = 728.0f;
        textFontSize  = 17.0f;
    } else {
        textWidth = 280.0f;
        textFontSize = 13.0f;
    }
    
    CGFloat margin = 35.0f;
    
    CGSize constraint = CGSizeMake(textWidth, 20000.0f);
    CGSize subjectSize = CGSizeMake(0, 0);
    CGSize titleSize = CGSizeMake(0, 0);
    
    subjectSize = [questionnaire.subject boundingRectWithSize:constraint
                                                      options:(NSStringDrawingUsesLineFragmentOrigin | NSStringDrawingUsesFontLeading)
                                                   attributes:@{NSFontAttributeName: [UIFont systemFontOfSize:textFontSize]}
                                                      context:nil].size;
    
    titleSize = [questionnaire.title boundingRectWithSize:constraint
                                                  options:(NSStringDrawingUsesLineFragmentOrigin | NSStringDrawingUsesFontLeading)
                                               attributes:@{NSFontAttributeName: [UIFont systemFontOfSize:textFontSize]}
                                                  context:nil].size;
    return subjectSize.height + titleSize.height + margin;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section {
    return 0.01f;
}

@end
