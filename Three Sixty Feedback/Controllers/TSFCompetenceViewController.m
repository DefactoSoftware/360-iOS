//
//  TSFQuestionnaireViewController.m
//  Three Sixty Feedback
//
//  Created by Girgis on 30/01/14.
//  Copyright (c) 2014 Defacto. All rights reserved.
//

#import "TSFCompetenceViewController.h"
#import "TSFCompetenceTitleCell.h"
#import "TSFKeyBehaviourCell.h"
#import "UIColor+TSFColor.h"

static NSString *const TSFCompetenceTitleCellIdentifier = @"TSFCompetenceTitleCell";
static NSString *const TSFKeyBehaviourCellIdentifier = @"TSFKeyBehaviourCell";
static NSString *const TSFFinishQuestionnaireSegue = @"TSFFinishQuestionnaireSegue";

@implementation TSFCompetenceViewController

- (id)initWithCoder:(NSCoder *)aDecoder {
	self = [super initWithCoder:aDecoder];
	if (self) {
        [self sharedSetup];
	}
	return self;
}

- (TSFCompetenceViewController *)initWithCompetence:(TSFCompetence *)competence
                                      questionnaire:(TSFQuestionnaire *)questionnaire {
    self = [super init];
    if (self) {
        _competence = competence;
        _questionnaire = questionnaire;
        [self sharedSetup];
    }
    return self;
}

- (void)sharedSetup {
    _competenceService = [TSFCompetenceService sharedService];
    _currentKeyBehaviourRatingViews = [[NSMutableArray alloc] init];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setUpKeyBehavioursTable];
}

- (void)setUpKeyBehavioursTable {    
    self.keyBehavioursTableView.dataSource = self;
    self.keyBehavioursTableView.delegate = self;
    
    [self.keyBehavioursTableView reloadData];
}

- (BOOL)validateInput {
    if (![self.currentKeyBehaviourRatingViews count]) {
        return NO;
    }
    
    if ([self.currentKeyBehaviourRatingViews count] < [self.competence.keyBehaviours count]) {
        return NO;
    }
    
    for (TSFKeyBehaviourRatingView *ratingView in self.currentKeyBehaviourRatingViews) {
        if (!ratingView.selectedRating) {
            return NO;
        }
    }
    return YES;
}

- (void)updateCompetenceWithCompletion:(TSFUpdateCompetenceBlock)completion {
    __block TSFUpdateCompetenceBlock _completionBlock = completion;
    
    if (![self validateInput]) {
        completion(NO);
        return;
    }
    
    for (NSInteger i = 0; i < [self.competence.keyBehaviours count]; i++) {
        TSFKeyBehaviourRatingView *ratingView = self.currentKeyBehaviourRatingViews[i];
        NSInteger rating = ratingView.selectedRating;
        
        TSFKeyBehaviour *keyBehaviour = self.competence.keyBehaviours[i];
        keyBehaviour.rating = @(rating);
    }

    [self.competenceService updateCompetence:self.competence
                            forQuestionnaire:self.questionnaire
                                 withSuccess:^(TSFCompetence *updatedCompetence) {
                                     _completionBlock(YES);
    }
                                     failure:^(NSError *error) {
                                         _completionBlock(NO);
                                         NSLog(@"Error updating competences. Error: %@. Userinfo: %@.", error.localizedDescription, error.userInfo);
    }];
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
    if (indexPath.row == 0) {
        return [self competenceTitleCellWithCompetence:self.competence];
    } else {
        NSInteger keyBehaviourNumber = indexPath.row - 1;
        TSFKeyBehaviour *currentKeyBehaviour = self.competence.keyBehaviours[keyBehaviourNumber];
        
        return [self keyBehaviourCellWithKeyBehaviour:currentKeyBehaviour];
    }
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    NSInteger numberOfRows = [self.competence.keyBehaviours count] + 1;
    return numberOfRows;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.row == 0) {
        return 70.0f;
    } else {
        TSFKeyBehaviour *currentKeyBehaviour = self.competence.keyBehaviours[indexPath.row - 1];

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
