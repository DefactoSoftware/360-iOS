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

@interface TSFQuestionnaireViewController : UIViewController <UIPageViewControllerDataSource, UIPageViewControllerDelegate>

@property (nonatomic, strong) UIPageViewController *pageController;
@property (weak, nonatomic) IBOutlet UIScrollView *scrollView;
@property (weak, nonatomic) IBOutlet UIPageControl *pageControl;
@property (nonatomic, strong) TSFQuestionnaireService *questionnaireService;
@property (nonatomic, strong) TSFQuestionnaire *questionnaire;
@property (nonatomic, strong) NSMutableArray *competenceViewControllers;
@property (nonatomic, strong) NSArray *failedCompetenceUpdates;
@property (nonatomic, strong) TSFCompetenceViewController *currentCompetenceViewController;

- (void)loadCompetenceControllers;

@end
