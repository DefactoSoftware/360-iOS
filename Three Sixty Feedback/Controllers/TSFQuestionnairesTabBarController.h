//
//  TSFQuestionnairesViewController.h
//  Three Sixty Feedback
//
//  Created by Girgis Ghattas on 21-02-14.
//  Copyright (c) 2014 Defacto. All rights reserved.
//


#import <UIKit/UIKit.h>
#import "RESideMenu.h"
#import "TSFBaseViewController.h"
#import "TSFQuestionnaireService.h"
#import "TSFActiveQuestionnairesViewController.h"
#import "TSFFinishedQuestionnairesViewController.h"
#import "TSFAssessorService.h"

@class TSFActiveQuestionnairesViewController;

@interface TSFQuestionnairesTabBarController : UITabBarController

@property (weak, nonatomic) IBOutlet UIBarButtonItem *menuButton;
@property (weak, nonatomic) IBOutlet UITabBar *tabBar;
@property (nonatomic, strong) TSFQuestionnaireService *questionnaireService;
@property (nonatomic, strong) TSFAssessorService *assessorService;
@property (nonatomic, strong) TSFActiveQuestionnairesViewController *activeQuestionnairesViewController;
@property (nonatomic, strong) TSFFinishedQuestionnairesViewController *finishedQuestionnairesViewController;
@property (nonatomic, strong) NSArray *questionnaires;

- (void)loadQuestionnaires;
- (void)loadAssessors;
- (IBAction)menuButtonPressed:(id)sender;

@end