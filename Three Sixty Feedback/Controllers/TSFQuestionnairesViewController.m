//
//  TSFQuestionnairesViewController.m
//  Three Sixty Feedback
//
//  Created by Girgis Ghattas on 26-02-14.
//  Copyright (c) 2014 Defacto. All rights reserved.
//

#import "TSFQuestionnairesViewController.h"
#import "TSFQuestionnairesNavigationController.h"
#import "TSFGenerics.h"
#import "CRToast.h"
#import "TSFQuestionnaireCell.h"
#import "TSFUserQuestionnaireTabBarController.h"
#import "UIColor+TSFColor.h"
#import "NSString+Hashtel.h"

static NSString *const TSFQuestionnaireCellIdentifier = @"TSFQuestionnaireCell";
static NSString *const TSFQuestionnaireViewControllerIdentifier = @"TSFUserQuestionnaireInfoViewController";
static NSString *const TSFNewQuestionnaireViewControllerIdentifier = @"TSFNewQuestionnaireViewControllerNavigation";

@interface TSFQuestionnairesViewController()
@property (nonatomic, assign) BOOL showCompletedQuestionnaires;
@property (nonatomic, strong) TSFUserQuestionnaireInfoViewController *questionnaireInfoViewController;
@property (nonatomic, strong) NSIndexPath *selectedQuestionnaireIndexPath;
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
    self.activeSegmentedControl.tintColor = [UIColor whiteColor];
    self.questionnairesTableView.separatorInset = UIEdgeInsetsZero;
    
    self.questionnairesTableView.dataSource = self;
    self.questionnairesTableView.delegate = self;
    
    self.questionnairesTableView.backgroundColor = [UIColor TSFAssessorsTableViewBackgroundColor];
    
    if (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPhone) {
        self.view.backgroundColor = [UIColor TSFBeigeColor];
        self.questionnairesTableView.backgroundColor = [UIColor TSFBeigeColor];
    }

    self.navigationItem.title = TSFLocalizedString(@"TSFQuestionnairesViewControllerTitle", @"Questionnaires");
    
    [self.activeSegmentedControl setTitle:TSFLocalizedString(@"TSFQuestionnaireViewControllerActive", @"Active") forSegmentAtIndex:0];
    [self.activeSegmentedControl setTitle:TSFLocalizedString(@"TSFQuestionnaireViewControllerCompleted", @"Completed") forSegmentAtIndex:1];
    
    [self.activeSegmentedControl addTarget:self
                                    action:@selector(segmentedControlChanged:)
               forControlEvents:UIControlEventValueChanged];
    
    self.chooseQuestionnaireLabel.text = TSFLocalizedString(@"TSFQuestionnairesViewControllerChooseQuestionnaire", @"Choose a questionnaire on the left side");
    self.orLabel.text = TSFLocalizedString(@"TSFQuestionnairesViewControllerOr", @"or");
    [self.createNewButton setTitle:TSFLocalizedString(@"TSFQuestionnairesViewControllerCreateNew", @"Create a new questionnaire")
                          forState:UIControlStateNormal];
    
    [self checkToDisplayAddNotification];
    [self loadQuestionnaires];
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillDisappear:animated];
    self.tabBarController.navigationItem.title = TSFLocalizedString(@"TSFActiveQuestionnairesViewControllerTitle", @"Active questionnaires");
    self.selectedQuestionnaireIndexPath = nil;
    [self.questionnairesTableView reloadData];
}

- (void)checkToDisplayAddNotification {
    TSFQuestionnairesNavigationController *navigationController = (TSFQuestionnairesNavigationController *)self.navigationController;
    if (navigationController.showAddedNotification) {
        NSDictionary *options = @{kCRToastTextKey : TSFLocalizedString(@"TSFQuestionnairesViewControllerAddedNotification", @"Questionnaire was successfully created"),
                                  kCRToastTextAlignmentKey : @(NSTextAlignmentCenter),
                                  kCRToastBackgroundColorKey : [UIColor TSFGreenColor]};
        [CRToastManager showNotificationWithOptions:options
                                    completionBlock:^{ }];
        navigationController.showAddedNotification = NO;
    }
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
                                  kCRToastBackgroundColorKey : [UIColor TSFErrorColor]};
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

- (void)clearDetailView {
    for (UIView *view in self.detailView.subviews) {
        if (view != self.emptyStateView) {
            [view removeFromSuperview];
        }
    }
    [self.view bringSubviewToFront:self.emptyStateView];
    self.emptyStateView.hidden = NO;
}

- (IBAction)segmentedControlChanged:(id)sender {
    self.selectedQuestionnaireIndexPath = nil;
    self.showCompletedQuestionnaires = self.activeSegmentedControl.selectedSegmentIndex == 1;
    [self.questionnairesTableView reloadData];
    [self clearDetailView];
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

- (TSFUserQuestionnaireInfoViewController *)questionnaireViewControllerForQuestionnaire:(TSFQuestionnaire *)questionnaire {
    TSFUserQuestionnaireInfoViewController *questionnaireViewController = [self.storyboard instantiateViewControllerWithIdentifier:TSFQuestionnaireViewControllerIdentifier];
    questionnaireViewController.questionnaire = questionnaire;
    self.questionnaireInfoViewController = questionnaireViewController;
    return questionnaireViewController;
}

- (IBAction)pushToNewQuestionnaireController:(id)sender {
    UIViewController *newQuestionnaireViewController = [self.storyboard instantiateViewControllerWithIdentifier:TSFNewQuestionnaireViewControllerIdentifier];
    [self.sideMenuViewController setContentViewController:newQuestionnaireViewController];
}

- (void)displayDetailViewForQuestionnaire:(TSFQuestionnaire *)questionnaire {
    TSFUserQuestionnaireInfoViewController *questionnaireViewController = [self questionnaireViewControllerForQuestionnaire:questionnaire];
    
    UIView *questionnaireView = questionnaireViewController.view;
    questionnaireView.translatesAutoresizingMaskIntoConstraints = NO;
    
    [self clearDetailView];
    self.emptyStateView.hidden = YES;
    [self.detailView addSubview:questionnaireView];
    
    NSLayoutConstraint *width =[NSLayoutConstraint
                                constraintWithItem:questionnaireView
                                attribute:NSLayoutAttributeWidth
                                relatedBy:0
                                toItem:self.detailView
                                attribute:NSLayoutAttributeWidth
                                multiplier:1.0
                                constant:0];
    NSLayoutConstraint *height =[NSLayoutConstraint
                                 constraintWithItem:questionnaireView
                                 attribute:NSLayoutAttributeHeight
                                 relatedBy:0
                                 toItem:self.detailView
                                 attribute:NSLayoutAttributeHeight
                                 multiplier:1.0
                                 constant:0];
    NSLayoutConstraint *top = [NSLayoutConstraint
                               constraintWithItem:questionnaireView
                               attribute:NSLayoutAttributeTop
                               relatedBy:NSLayoutRelationEqual
                               toItem:self.detailView
                               attribute:NSLayoutAttributeTop
                               multiplier:1.0f
                               constant:0.f];
    NSLayoutConstraint *leading = [NSLayoutConstraint
                                   constraintWithItem:questionnaireView
                                   attribute:NSLayoutAttributeLeading
                                   relatedBy:NSLayoutRelationEqual
                                   toItem:self.detailView
                                   attribute:NSLayoutAttributeLeading
                                   multiplier:1.0f
                                   constant:0.f];
    [self.detailView addConstraint:width];
    [self.detailView addConstraint:height];
    [self.detailView addConstraint:top];
    [self.detailView addConstraint:leading];
}

#pragma mark - Prepare for segue

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    TSFUserQuestionnaireTabBarController *destinationController = segue.destinationViewController;
    NSInteger selectedQuestionnaireIndex = [self.questionnairesTableView indexPathForSelectedRow].row;
    TSFQuestionnaire *selectedQuestionnaire = (self.showCompletedQuestionnaires) ? self.completedQuestionnaires[selectedQuestionnaireIndex] : self.activeQuestionnaires[selectedQuestionnaireIndex];
    destinationController.questionnaire = selectedQuestionnaire;
}

#pragma mark - UITableView

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    NSMutableArray *reloadIndexPaths = [[NSMutableArray alloc] init];
    
    NSIndexPath *oldSelectedRow = self.selectedQuestionnaireIndexPath;
    self.selectedQuestionnaireIndexPath = indexPath;
    
    if (oldSelectedRow && oldSelectedRow != self.selectedQuestionnaireIndexPath) {
        [reloadIndexPaths addObject:oldSelectedRow];
    }
    [reloadIndexPaths addObject:self.selectedQuestionnaireIndexPath];
    [self.questionnairesTableView reloadRowsAtIndexPaths:reloadIndexPaths
                                        withRowAnimation:UITableViewRowAnimationFade];
    
    if (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad) {
        TSFQuestionnaire *questionnaire = [self questionnaireForRow:indexPath.row];
        [self displayDetailViewForQuestionnaire:questionnaire];
    }
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.showCompletedQuestionnaires ? [self.completedQuestionnaires count] : [self.activeQuestionnaires count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView
         cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    TSFQuestionnaireCell *questionnaireCell = [self.questionnairesTableView dequeueReusableCellWithIdentifier:TSFQuestionnaireCellIdentifier];
    if (!questionnaireCell) {
        questionnaireCell = [[TSFQuestionnaireCell alloc] initWithStyle:UITableViewCellStyleDefault
                                                        reuseIdentifier:TSFQuestionnaireCellIdentifier];
    }
    
    TSFQuestionnaire *questionnaire = [self questionnaireForRow:indexPath.row];
    
    NSInteger assessorsCount = [questionnaire.assessors count];
    NSInteger completedAssessorsCount = [questionnaire completedAssessors];
    questionnaireCell.assessorsCountLabel.text = [NSString stringWithFormat:@"%lu/%lu", (long)completedAssessorsCount, (long)assessorsCount];
    
    questionnaireCell.subjectLabel.text = questionnaire.subject;
    questionnaireCell.titleLabel.text = questionnaire.title;
    
    questionnaireCell.colorView.backgroundColor = [questionnaire.subject hashtel];
    if (self.selectedQuestionnaireIndexPath == indexPath) {
        [questionnaireCell select];
    } else {
        [questionnaireCell unselect];
        questionnaireCell.colorView.backgroundColor = [questionnaire.subject hashtel];
    }
    
    UIView *selectedBackgroundView = [[UIView alloc] init];
    selectedBackgroundView.backgroundColor = [UIColor TSFLightBlueColor];
    questionnaireCell.selectedBackgroundView = selectedBackgroundView;
    
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
