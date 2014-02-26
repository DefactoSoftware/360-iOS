//
//  TSFUserQuestionnaireAssessorsViewController.m
//  Three Sixty Feedback
//
//  Created by Girgis Ghattas on 25-02-14.
//  Copyright (c) 2014 Defacto. All rights reserved.
//

#import "TSFUserQuestionnaireAssessorsViewController.h"
#import "TSFUserQuestionnaireTabBarController.h"
#import "TSFAssessorCell.h"
#import "TSFGenerics.h"
#import "NSDate+StringParsing.h"
#import "TSFRemindAssessorsCell.h"
#import "CRToastManager+TSFToast.h"

static NSString *const TSFAssessorCellIdentifier = @"TSFAssessorCell";
static NSString *const TSFRemindAssessorCellIdentifier = @"TSFRemindAssessorsCell";

@interface TSFUserQuestionnaireAssessorsViewController()
@property (nonatomic, assign) NSInteger customCells;
@end

@implementation TSFUserQuestionnaireAssessorsViewController

- (id)initWithCoder:(NSCoder *)aDecoder {
    self = [super initWithCoder:aDecoder];
    if (self) {
        [self sharedSetup];
    }
    return self;
}

- (id)initWithNibName:(NSString *)nibNameOrNil
               bundle:(NSBundle *)nibBundleOrNil {
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        [self sharedSetup];
    }
    return self;
}

- (void)sharedSetup {
    _assessorService = [TSFAssessorService sharedService];
    _customCells = 1;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.assessorsTableView.delegate = self;
    self.assessorsTableView.dataSource = self;
    [self.assessorsTableView reloadData];
}

- (void)reloadAssessors {
    __weak typeof (self) _self = self;
    [self.assessorService assessorsForQuestionnaireId:self.questionnaire.questionnaireId withSuccess:^(id responseObject) {
        _self.questionnaire.assessors = (NSArray *)responseObject;
        [_self viewDidLoad];
    } failure:^(NSError *error) {
        [CRToastManager showErrorNotificationWithMessage:TSFLocalizedString(@"TSFUserQuestionnaireAssessorsViewControllerReloadError", @"Could not reload assessors.")
                                                   error:error
                                         completionBlock:^{}];
    }];
}

- (IBAction)remindButtonPressed:(id)sender {
    [self remindAssessors];
}

- (void)remindAssessors {
    for (TSFAssessor *assessor in self.questionnaire.assessors) {
        if (!assessor.completed) {
            __weak typeof (self) _self = self;
            [self.assessorService remindAssessorWithId:assessor.assessorId success:^(id response) {
                [_self reloadAssessors];
            } failure:^(NSError *error) {
                [CRToastManager showErrorNotificationWithMessage:TSFLocalizedString(@"TSFUserQuestionnaireAssessorsViewControllerReminderError", @"Assessor has already been reminded in the last 24 hours.")
                                                           error:error
                                                 completionBlock:^{}];
            }];
        }
    }
}

- (TSFRemindAssessorsCell *)remindAssessorsCell {
    TSFRemindAssessorsCell *remindAssessorsCell = [self.assessorsTableView dequeueReusableCellWithIdentifier:TSFRemindAssessorCellIdentifier];
    if (!remindAssessorsCell) {
        remindAssessorsCell = [[TSFRemindAssessorsCell alloc] initWithStyle:UITableViewCellStyleDefault
                                                           reuseIdentifier:TSFRemindAssessorCellIdentifier];
    }

    return remindAssessorsCell;
}

- (TSFAssessorCell *)assessorCellForAssessor:(NSInteger)assessorNumber {
    TSFAssessorCell *assessorCell = [self.assessorsTableView dequeueReusableCellWithIdentifier:TSFAssessorCellIdentifier];
    if (!assessorCell) {
        assessorCell = [[TSFAssessorCell alloc] initWithStyle:UITableViewCellStyleDefault
                                              reuseIdentifier:TSFAssessorCellIdentifier];
    }

    TSFAssessor *assessor = self.questionnaire.assessors[assessorNumber];
    [assessorCell displayAssessor:assessor];
    return assessorCell;
}

#pragma mark - UITableView

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return [self.questionnaire.assessors count] + self.customCells;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.row == 0) {
        return [self remindAssessorsCell];
    } else {
        return [self assessorCellForAssessor:indexPath.row - self.customCells];
    }
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.row == 0) {
        return 65.0f;
    } else {
        TSFAssessorCell *assessorCell = (TSFAssessorCell *)[self tableView:self.assessorsTableView
                            cellForRowAtIndexPath:indexPath];
        return [assessorCell calculatedHeight];
    }
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section {
    return 0.01f;
}

@end
