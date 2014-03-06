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
#import "CRToast.h"
#import "UIColor+TSFColor.h"

static NSString *const TSFAssessorCellIdentifier = @"TSFAssessorCell";

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
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.assessorsTableView.delegate = self;
    self.assessorsTableView.dataSource = self;
    self.assessorsTableView.backgroundColor = (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad) ? [UIColor TSFAssessorsTableViewBackgroundColor] : [UIColor TSFBeigeColor];
    self.assessorsTableView.layer.cornerRadius = 5.0f;
    self.assessorsTableView.separatorInset = UIEdgeInsetsMake(0, 15.0f, 0, 15.0f);
    [self.assessorsTableView reloadData];
    [self.remindButton setTitle:TSFLocalizedString(@"TSFUserQuestionnaireAssessorsViewControllerRemind", @"Send reminders")
                       forState:UIControlStateNormal];
    [self.remindButton setIconImage:[UIImage imageNamed:@"time"]];
}

- (void)reloadAssessors {
    __weak typeof (self) _self = self;
    [self.assessorService assessorsForQuestionnaireId:self.questionnaire.questionnaireId withSuccess:^(id responseObject) {
        _self.questionnaire.assessors = (NSArray *)responseObject;
        [_self viewDidLoad];
    } failure:^(NSError *error) {
        NSLog(@"Error reloading assessors: %@.", error);
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
                NSDictionary *options = @{kCRToastTextKey : TSFLocalizedString(@"TSFUserQuestionnaireAssessorsViewControllerReminderError", @"Assessor has already been reminded in the last 24 hours."),
                                          kCRToastTextAlignmentKey : @(NSTextAlignmentCenter),
                                          kCRToastBackgroundColorKey : [UIColor redColor]};
                [CRToastManager showNotificationWithOptions:options completionBlock:^{ }];
                NSLog(@"Error reminding assessor: %@", error);
            }];
        }
    }
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
    return [self.questionnaire.assessors count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    return [self assessorCellForAssessor:indexPath.row];
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

- (void)tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath {
    cell.backgroundColor = [UIColor clearColor];
}

@end
