//
//  TSFQuestionnaireViewController.h
//  Three Sixty Feedback
//
//  Created by Girgis Ghattas on 04-02-14.
//  Copyright (c) 2014 Defacto. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "TSFQuestionnaireService.h"
#import "TSFCompetenceViewController.h"
#import "TSFFinishQuestionnaireViewController.h"

typedef void (^TSFUpdateCurrentCompetenceViewControllerBlock)(BOOL);
typedef void (^TSFCompleteQuestionnaireViewControllerBlock)(BOOL);

@class TSFFinishQuestionnaireViewController;

@interface TSFQuestionnaireViewController : UIViewController <UIPageViewControllerDataSource, UIPageViewControllerDelegate>

@property (nonatomic, strong) UIPageViewController *pageController;
@property (weak, nonatomic) IBOutlet UIScrollView *scrollView;
@property (weak, nonatomic) IBOutlet UIPageControl *pageControl;
@property (weak, nonatomic) IBOutlet UIButton *previousButton;
@property (weak, nonatomic) IBOutlet UIButton *nextButton;
@property (weak, nonatomic) IBOutlet UIButton *firstButton;
@property (weak, nonatomic) IBOutlet UIButton *lastButton;
@property (nonatomic, strong) TSFQuestionnaireService *questionnaireService;
@property (nonatomic, strong) TSFAssessorService *assessorService;
@property (nonatomic, strong) TSFQuestionnaire *questionnaire;
@property (nonatomic, strong) NSMutableArray *competenceViewControllers;
@property (nonatomic, strong) NSMapTable *invalidCompetenceViewControllers;
@property (nonatomic, strong) NSMapTable *updatedCompetenceViewControllers;
@property (nonatomic, strong) NSMapTable *erroredCompetenceViewControllers;
@property (nonatomic, strong) TSFCompetenceViewController *currentCompetenceViewController;
@property (nonatomic, strong) TSFFinishQuestionnaireViewController *finishQuestionnaireViewController;

- (void)loadCompetenceControllers;
- (void)createFinishQuestionnaireViewController;
- (void)displayCompletionError;
- (BOOL)failedCompetencesCheck;
- (void)completeQuestionnaireCheck;
- (void)updateCurrentCompetenceViewController;
- (void)completeQuestionnaireWithCompletion:(TSFCompleteQuestionnaireViewControllerBlock)completion;
- (IBAction)previousButtonPressed:(id)sender;
- (IBAction)firstButtonPressed:(id)sender;
- (IBAction)lastButtonPressed:(id)sender;
- (IBAction)nextButtonPressed:(id)sender;

@end
