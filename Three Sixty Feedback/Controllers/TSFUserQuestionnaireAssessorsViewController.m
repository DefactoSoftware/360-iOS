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

static NSString *const TSFAssessorCellIdentifier = @"TSFAssessorCell";
static NSString *const TSFCompletedImageName = @"completed";
static NSString *const TSFNotCompletedImageName = @"not_completed";

@implementation TSFUserQuestionnaireAssessorsViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.assessorsTableView.delegate = self;
    self.assessorsTableView.dataSource = self;
    [self.assessorsTableView reloadData];
}

#pragma mark - UITableView

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return [self.questionnaire.assessors count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    TSFAssessorCell *assessorCell = [self.assessorsTableView dequeueReusableCellWithIdentifier:TSFAssessorCellIdentifier];
    if (!assessorCell) {
        assessorCell = [[TSFAssessorCell alloc] initWithStyle:UITableViewCellStyleDefault
                                              reuseIdentifier:TSFAssessorCellIdentifier];
    }
    
    TSFAssessor *assessor = self.questionnaire.assessors[indexPath.row];
    assessorCell.emailLabel.text = assessor.email;
    
    if (assessor.completed) {
        assessorCell.completedImageView.image = [UIImage imageNamed:TSFCompletedImageName];
    } else {
        assessorCell.completedImageView.image = [UIImage imageNamed:TSFNotCompletedImageName];
    }
    
    return assessorCell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section {
    return 0.01f;
}

@end
