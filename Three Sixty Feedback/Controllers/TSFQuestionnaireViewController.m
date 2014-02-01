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

@interface TSFQuestionnaireViewController ()
@property (nonatomic, assign) NSInteger currentCompetenceNumber;
@property (nonatomic, strong) NSMutableArray *currentKeyBehaviourRatingViews;
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

- (void)viewDidLoad {
    self.title = TSFLocalizedString(@"TSFQuestionnaireViewControllerTitle", @"Feedback round");
    
    [self setUpKeyBehavioursTable];
	[self loadQuestionnaire];
}

- (void)setUpKeyBehavioursTable {
    self.currentCompetenceNumber = 0;
    
    self.keyBehavioursTableView.dataSource = self;
    self.keyBehavioursTableView.delegate = self;
    
    [self.keyBehavioursTableView reloadData];
}

- (void)loadQuestionnaire {
	__block typeof(self) _self = self;
    
	[self.questionnaireService questionnairesWithSuccess: ^(NSArray *questionnaires) {
	    _self.questionnaire = [questionnaires firstObject];
        [_self setUpKeyBehavioursTable];
	} failure: ^(NSError *error) {
	    NSLog(@"Error loading questionnaires. Userinfo: %@. Error: %@", error.userInfo, error.localizedDescription);
	}];
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
        
        [self.currentKeyBehaviourRatingViews removeAllObjects];
        
        [self.keyBehavioursTableView reloadData];
    }
}

#pragma mark - Navigate through competences

- (IBAction)nextCompetenceButtonPressed:(UIBarButtonItem *)sender {
    [self updateCompetence];
}

- (IBAction)previousCompetenceButtonPressed:(UIBarButtonItem *)sender {
    
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
        CGFloat textFontSize = 13.0f;
        CGFloat textWidth = 280.0f;
        
        CGSize constraint = CGSizeMake(textWidth, 20000.0f);
        CGSize titleSize = [currentKeyBehaviour.keyBehaviourDescription boundingRectWithSize:constraint
                                                             options:(NSStringDrawingUsesLineFragmentOrigin | NSStringDrawingUsesFontLeading)
                                                          attributes:@{NSFontAttributeName: [UIFont systemFontOfSize:textFontSize]}
                                                             context:nil].size;
        
        return titleSize.height + 95.0f;
    }
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section {
    return 0.01f;
}

@end
