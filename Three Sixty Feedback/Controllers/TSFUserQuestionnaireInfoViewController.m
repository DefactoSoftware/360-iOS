//
//  TSFUserQuestionnaireInfoViewController.m
//  Three Sixty Feedback
//
//  Created by Girgis Ghattas on 25-02-14.
//  Copyright (c) 2014 Defacto. All rights reserved.
//

#import "TSFUserQuestionnaireInfoViewController.h"
#import "TSFUserQuestionnaireAssessorsViewController.h"
#import "TSFGenerics.h"
#import "TSFAssessorCell.h"
#import "CRToast.h"
#import "UIColor+TSFColor.h"

static NSString *const TSFQuestionnaireAssessorsSegueIdentifier = @"TSFAssessorsPopoverSegue";
static NSString *const TSFAssessorCellIdentifier = @"TSFAssessorCell";

@implementation TSFUserQuestionnaireInfoViewController

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
    
    self.tabBarController.tabBarItem.title = TSFLocalizedString(@"TSFUserQuestionnaireInfoViewControllerTab", @"My questionnaire");

    self.subjectTitleLabel.text = TSFLocalizedString(@"TSFUserQuestionnaireInfoViewControllerSubjectFormat", @"This questionnaire is about");
    self.subjectLabel.text = self.questionnaire.subject;
    self.descriptionLabel.text = self.questionnaire.questionnaireDescription;
    
    self.subjectTitleLabel.textColor = [UIColor TSFLightGreyTextColor];
    self.descriptionLabel.textColor = [UIColor TSFLightGreyTextColor];
    self.subjectLabel.textColor = [UIColor TSFLightGreyTextColor];

    [self setupAssessorsTableView];
}

- (void)setupAssessorsTableView {
    self.assessorsLabel.text = TSFLocalizedString(@"TSFUserQuestionnaireInfoViewControllerAssessors", @"Assessors");
    [self.remindAssessorsButton setTitle:TSFLocalizedString(@"TSFUserQuestionnaireInfoViewControllerRemindButton", @"Send reminders")
                                forState:UIControlStateNormal];

    if(UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad) {
        self.assessorsTableView.dataSource = self;
        self.assessorsTableView.delegate = self;
        self.assessorsTableView.backgroundColor = [UIColor TSFAssessorsTableViewBackgroundColor];
        self.assessorsTableView.layer.cornerRadius = 5.0f;
        [self.assessorsTableView reloadData];
    }
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
                NSDictionary *options = @{kCRToastTextKey : TSFLocalizedString(@"TSFUserQuestionnaireInfoViewControllerReminderError", @"Assessor has already been reminded in the last 24 hours."),
                                          kCRToastTextAlignmentKey : @(NSTextAlignmentCenter),
                                          kCRToastBackgroundColorKey : [UIColor redColor]};
                [CRToastManager showNotificationWithOptions:options completionBlock:^{ }];
                NSLog(@"Error reminding assessor: %@", error);
            }];
        }
    }
}

- (void)reloadAssessors {
    __weak typeof (self) _self = self;
    [self.assessorService assessorsForQuestionnaireId:self.questionnaire.questionnaireId withSuccess:^(id responseObject) {
        _self.questionnaire.assessors = (NSArray *)responseObject;
        [_self setupAssessorsTableView];
    } failure:^(NSError *error) {
        NSLog(@"Error getting assessors: %@.", error);
    }];
}

#pragma mark - Prepare for segue

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    if ([segue.identifier isEqualToString:TSFQuestionnaireAssessorsSegueIdentifier]) {
        TSFUserQuestionnaireAssessorsViewController *destinationViewController = (TSFUserQuestionnaireAssessorsViewController *)segue.destinationViewController;
        destinationViewController.questionnaire = self.questionnaire;
    }
}

#pragma mark - UITableView

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return [self.questionnaire.assessors count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView
         cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    TSFAssessorCell *assessorCell = [self.assessorsTableView dequeueReusableCellWithIdentifier:TSFAssessorCellIdentifier];
    if (!assessorCell) {
        assessorCell = [[TSFAssessorCell alloc] initWithStyle:UITableViewCellStyleDefault
                                              reuseIdentifier:TSFAssessorCellIdentifier];
    }

    TSFAssessor *assessor = self.questionnaire.assessors[indexPath.row];
    [assessorCell displayAssessor:assessor];

    return assessorCell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    TSFAssessorCell *assessorCell = (TSFAssessorCell *)[self tableView:self.assessorsTableView
                              cellForRowAtIndexPath:indexPath];
    return [assessorCell calculatedHeight];
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section {
    return 0.01f;
}

@end
