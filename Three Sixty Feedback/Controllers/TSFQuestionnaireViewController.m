//
//  TSFQuestionnaireViewController.m
//  Three Sixty Feedback
//
//  Created by Girgis on 30/01/14.
//  Copyright (c) 2014 Defacto. All rights reserved.
//

#import "TSFQuestionnaireViewController.h"
#import "TSFCompetenceTitleCell.h"
#import "TSFKeyBehaviourCell.h"
#import "NZAlertView.h"
#import "UIColor+TSFColor.h"

static NSString *const TSFCompetenceTitleCellIdentifier = @"TSFCompetenceTitleCell";
static NSString *const TSFKeyBehaviourCellIdentifier = @"TSFKeyBehaviourCell";

static NSString *const TSFFinishQuestionnaireSegue = @"TSFFinishQuestionnaireSegue";

@interface TSFQuestionnaireViewController ()
@property (nonatomic, assign) NSInteger currentCompetenceNumber;
@property (nonatomic, strong) UIProgressView *progressView;
@end

@implementation TSFQuestionnaireViewController

- (id)initWithCoder:(NSCoder *)aDecoder {
	self = [super initWithCoder:aDecoder];
	if (self) {
		_questionnaireService = [TSFQuestionnaireService sharedService];
        _competenceService = [TSFCompetenceService sharedService];
        _currentKeyBehaviourRatingViews = [[NSMutableArray alloc] init];
	}
	return self;
}

- (void)viewDidAppear:(BOOL)animated {
    [self refreshProgressView];
}

- (void)viewDidLoad {
    self.title = TSFLocalizedString(@"TSFQuestionnaireViewControllerTitle", @"Feedback round");
    [self addProgressView];
    [self loadQuestionnaire];
    
    [self setUpKeyBehavioursTable];
    [self addGestureRecognizers];
}

- (void)refreshProgressView {
    self.progressView.progress = (float) self.currentCompetenceNumber / [self.questionnaire.competences count];
}

- (void)addProgressView {
    self.progressView = [[UIProgressView alloc] initWithProgressViewStyle:UIProgressViewStyleBar];

    self.progressView.frame = CGRectMake(0,
                                         self.navigationController.navigationBar.frame.size.height - self.progressView.frame.size.height,
                                         self.view.frame.size.width,
                                         self.progressView.frame.size.height);
    
    self.progressView.progress = 0;
    [self.view addSubview:self.progressView];
    
    [self.navigationController.navigationBar addSubview:self.progressView];
}


- (void)addGestureRecognizers {
    UISwipeGestureRecognizer *nextSwipeRecognizer = [[UISwipeGestureRecognizer alloc] initWithTarget:self action:@selector(handleNextSwipeFrom:)];
    UISwipeGestureRecognizer *previousSwipeRecognizer = [[UISwipeGestureRecognizer alloc] initWithTarget:self action:@selector(handlePreviousSwipeFrom:)];
    [nextSwipeRecognizer setDirection:(UISwipeGestureRecognizerDirectionLeft)];
    [previousSwipeRecognizer setDirection:(UISwipeGestureRecognizerDirectionRight)];
    [self.view addGestureRecognizer:nextSwipeRecognizer];
    [self.view addGestureRecognizer:previousSwipeRecognizer];
}

- (void)handleNextSwipeFrom:(UISwipeGestureRecognizer *)recognizer {
    [self updateCompetenceOrSendQuestionnaire];
}

- (void)handlePreviousSwipeFrom:(UISwipeGestureRecognizer *)recognizer {
    [self navigateToPreviousCompetence];
}

- (void)loadQuestionnaire {
    self.questionnaire = [self.questionnaireService.questionnaires firstObject];
}

- (void)setUpKeyBehavioursTable {
    if (!self.currentCompetenceNumber) {
        self.currentCompetenceNumber = 0;
    }
    [self refreshPreviousButton];
    
    self.keyBehavioursTableView.dataSource = self;
    self.keyBehavioursTableView.delegate = self;
    
    [self.keyBehavioursTableView reloadData];
}

- (void)displayLastCompetence {
    [self loadQuestionnaire];
    NSInteger competenceNumber = [self.questionnaire.competences count] - 1;
    self.currentCompetenceNumber = competenceNumber;
}

- (void)refreshPreviousButton {
    if (self.currentCompetenceNumber) {
        self.previousButton.enabled = YES;
    } else {
        self.previousButton.enabled = NO;
    }
}

- (void)checkPreviousButton {
    if (self.currentCompetenceNumber) {
    }
}

- (void)displayValidationError {
    NSString *validationErrorMessage = TSFLocalizedString(@"TSFQuestionnaireViewControllerValidationErrorMessage", @"Please fill in every question before moving on.");
    NZAlertView *validationAlert = [[NZAlertView alloc] initWithStyle:NZAlertStyleError
                                                                title:nil
                                                              message:validationErrorMessage
                                                             delegate:nil];
    [validationAlert setStatusBarColor:[UIColor redColor]];
    [validationAlert setTextAlignment:NSTextAlignmentCenter];
    
    [validationAlert show];
}

- (BOOL)validateInput {
    TSFCompetence *currentCompetence = self.questionnaire.competences[self.currentCompetenceNumber];
    
    if (![self.currentKeyBehaviourRatingViews count]) {
        return NO;
    }
    
    if ([self.currentKeyBehaviourRatingViews count] < [currentCompetence.keyBehaviours count]) {
        return NO;
    }
    
    for (TSFKeyBehaviourRatingView *ratingView in self.currentKeyBehaviourRatingViews) {
        if (!ratingView.selectedRating) {
            return NO;
        }
    }
    return YES;
}

- (void)updateCompetence {
    if (![self validateInput]) {
        [self displayValidationError];
        return;
    }
    
    TSFCompetence *competence = self.questionnaire.competences[self.currentCompetenceNumber];
    for (NSInteger i = 0; i < [competence.keyBehaviours count]; i++) {
        TSFKeyBehaviourRatingView *ratingView = self.currentKeyBehaviourRatingViews[i];
        NSInteger rating = ratingView.selectedRating;
        
        TSFKeyBehaviour *keyBehaviour = competence.keyBehaviours[i];
        keyBehaviour.rating = @(rating);
    }
    
    __weak TSFQuestionnaireViewController *_self = self;
    [self.competenceService updateCompetence:competence
                            forQuestionnaire:self.questionnaire
                                 withSuccess:^(TSFCompetence *updatedCompetence) {
                                     [_self navigateToNextCompetence];
    }
                                     failure:^(NSError *error) {
                                         NSLog(@"Error updating competences. Error: %@. Userinfo: %@.", error.localizedDescription, error.userInfo);
    }];
}

- (void)navigateToNextCompetence {
    NSInteger newCompetenceNumber = self.currentCompetenceNumber + 1;
    if ([self.questionnaire.competences count] > newCompetenceNumber) {
        self.currentCompetenceNumber = newCompetenceNumber;
        
        [self reloadCompetenceTableToNext:YES];
        [self refreshProgressView];
    }
    
    [self refreshPreviousButton];
}

- (void)navigateToPreviousCompetence {
    NSInteger newCompetenceNumber = self.currentCompetenceNumber - 1;
    if (newCompetenceNumber > -1) {
        self.currentCompetenceNumber = newCompetenceNumber;
        
        [self reloadCompetenceTableToNext:NO];
        [self refreshProgressView];
    }
    
    [self refreshPreviousButton];
}

- (void)reloadCompetenceTableToNext:(BOOL)next {
    [self.currentKeyBehaviourRatingViews removeAllObjects];
    NSInteger animation = next ? UITableViewRowAnimationLeft : UITableViewRowAnimationRight;
    [self.keyBehavioursTableView reloadSections:[NSIndexSet indexSetWithIndex:0] withRowAnimation:animation];
    [self.keyBehavioursTableView setContentOffset:CGPointMake(0.0f, -self.keyBehavioursTableView.contentInset.top) animated:YES];
}

- (void)updateCompetenceOrSendQuestionnaire {
    if (self.currentCompetenceNumber + 1 == [self.questionnaire.competences count]) {
        self.progressView.progress = 1;
        [self performSegueWithIdentifier:TSFFinishQuestionnaireSegue sender:self];
    } else {
        [self updateCompetence];
    }
}

#pragma mark - Navigate through competences

- (IBAction)nextCompetenceButtonPressed:(UIBarButtonItem *)sender {
    [self updateCompetenceOrSendQuestionnaire];
}

- (IBAction)previousCompetenceButtonPressed:(UIBarButtonItem *)sender {
    [self navigateToPreviousCompetence];
}

#pragma mark - UITableView delegate

- (TSFCompetenceTitleCell *)competenceTitleCellWithCompetence:(TSFCompetence *)competence {
    TSFCompetenceTitleCell *competenceTitleCell = [self.keyBehavioursTableView dequeueReusableCellWithIdentifier:TSFCompetenceTitleCellIdentifier];
	if (!competenceTitleCell) {
		competenceTitleCell = [[TSFCompetenceTitleCell alloc] initWithStyle:UITableViewCellStyleDefault
                                                            reuseIdentifier:TSFCompetenceTitleCellIdentifier];
	}
    
    competenceTitleCell.nameLabel.text = competence.title;

    return competenceTitleCell;
}

- (TSFKeyBehaviourCell *)keyBehaviourCellWithKeyBehaviour:(TSFKeyBehaviour *)keyBehaviour {
    TSFKeyBehaviourCell *keyBehaviourCell = [self.keyBehavioursTableView dequeueReusableCellWithIdentifier:TSFKeyBehaviourCellIdentifier];
    if (!keyBehaviourCell) {
        keyBehaviourCell = [[TSFKeyBehaviourCell alloc] initWithStyle:UITableViewCellStyleDefault
                                                      reuseIdentifier:TSFKeyBehaviourCellIdentifier];
    }
    
    keyBehaviourCell.keyBehaviour = keyBehaviour;
    keyBehaviourCell.descriptionLabel.text = keyBehaviour.keyBehaviourDescription;
    [self.currentKeyBehaviourRatingViews addObject:keyBehaviourCell.keyBehaviourRatingView];
    
    return keyBehaviourCell;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    TSFCompetence *currentCompetence = self.questionnaire.competences[self.currentCompetenceNumber];
    
    if (indexPath.row == 0) {
        return [self competenceTitleCellWithCompetence:currentCompetence];
    } else {
        NSInteger keyBehaviourNumber = indexPath.row - 1;
        TSFKeyBehaviour *currentKeyBehaviour = currentCompetence.keyBehaviours[keyBehaviourNumber];
        
        return [self keyBehaviourCellWithKeyBehaviour:currentKeyBehaviour];
    }
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    NSInteger numberOfRows = 0;
    if (self.questionnaire && [self.questionnaire.competences count]) {
        TSFCompetence *currentCompetence = self.questionnaire.competences[self.currentCompetenceNumber];
        numberOfRows = [currentCompetence.keyBehaviours count] + 1;
    }
    return numberOfRows;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.row == 0) {
        return 70.0f;
    } else {
        TSFCompetence *currentCompetence = self.questionnaire.competences[self.currentCompetenceNumber];
        TSFKeyBehaviour *currentKeyBehaviour = currentCompetence.keyBehaviours[indexPath.row - 1];

        CGFloat textFontSize;
        CGFloat textWidth;
        if (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad) {
            textWidth = 728.0f;
            textFontSize  = 17.0f;
        } else {
            textWidth = 280.0f;
            textFontSize = 13.0f;
        }
        
        CGFloat margin = (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad) ? 110.0f : 95.0f;
        
        CGSize constraint = CGSizeMake(textWidth, 20000.0f);
        CGSize titleSize = [currentKeyBehaviour.keyBehaviourDescription boundingRectWithSize:constraint
                                                             options:(NSStringDrawingUsesLineFragmentOrigin | NSStringDrawingUsesFontLeading)
                                                          attributes:@{NSFontAttributeName: [UIFont systemFontOfSize:textFontSize]}
                                                             context:nil].size;
        
        return titleSize.height + margin;
    }
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section {
    return 0.01f;
}

@end
