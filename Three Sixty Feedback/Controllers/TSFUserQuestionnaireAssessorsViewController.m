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

- (NSString *)remindedAtString:(NSDate *)remindedAt {
    NSString *remindedAtFormat = TSFLocalizedString(@"TSFUserQuestionnaireAssessorsViewControllerRemindedAt", @"Last reminded at %@");
    return [NSString stringWithFormat:remindedAtFormat, [NSDate stringFromDate:remindedAt]];
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
    
    if (assessor.lastRemindedAt) {
        assessorCell.remindedAtLabel.text = [self remindedAtString:assessor.lastRemindedAt];
    }
    
    return assessorCell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    TSFAssessor *assessor = self.questionnaire.assessors[indexPath.row];
    
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
    CGSize emailSize = CGSizeMake(0, 0);
    CGSize remindedAtSize = CGSizeMake(0, 0);
    
    emailSize = [assessor.email boundingRectWithSize:constraint
                                                      options:(NSStringDrawingUsesLineFragmentOrigin | NSStringDrawingUsesFontLeading)
                                                   attributes:@{NSFontAttributeName: [UIFont systemFontOfSize:textFontSize]}
                                                      context:nil].size;
    
    if (assessor.lastRemindedAt) {
        NSString *remindedAtString = [self remindedAtString:assessor.lastRemindedAt];
        remindedAtSize = [remindedAtString boundingRectWithSize:constraint
                                                      options:(NSStringDrawingUsesLineFragmentOrigin | NSStringDrawingUsesFontLeading)
                                                   attributes:@{NSFontAttributeName: [UIFont systemFontOfSize:textFontSize]}
                                                      context:nil].size;
    }
    return emailSize.height + remindedAtSize.height + margin;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section {
    return 0.01f;
}

@end
