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

@interface TSFQuestionnaireViewController : UIViewController <UIPageViewControllerDataSource, UIPageViewControllerDelegate>

@property (nonatomic, strong) UIPageViewController *pageController;
@property (weak, nonatomic) IBOutlet UIScrollView *scrollView;
@property (weak, nonatomic) IBOutlet UIPageControl *pageControl;
@property (nonatomic, strong) TSFQuestionnaireService *questionnaireService;
@property (nonatomic, strong) TSFQuestionnaire *questionnaire;
@property (nonatomic, strong) NSMutableArray *competenceViewControllers;
@property (nonatomic, strong) NSMapTable *invalidCompetenceViewControllers;
@property (nonatomic, strong) NSMapTable *succeededCompetenceViewControllers;
@property (nonatomic, strong) NSMapTable *erroredCompetenceViewControllers;
@property (nonatomic, strong) TSFCompetenceViewController *currentCompetenceViewController;
@property (nonatomic, strong) TSFFinishQuestionnaireViewController *finishQuestionnaireViewController;

- (void)loadCompetenceControllers;
- (void)createFinishQuestionnaireViewController;
- (void)updateCurrentCompetenceViewControllerWithCompletion:(TSFUpdateCurrentCompetenceViewControllerBlock)completion;

@end
