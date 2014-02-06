//
//  TSFQuestionnaireViewController.m
//  Three Sixty Feedback
//
//  Created by Girgis Ghattas on 04-02-14.
//  Copyright (c) 2014 Defacto. All rights reserved.
//

#import "TSFQuestionnaireViewController.h"
#import "TSFCompetenceViewController.h"
#import "TSFFinishQuestionnaireViewController.h"
#import "UIColor+TSFColor.h"
#import "NZAlertView.h"

static NSString *const TSFCompetenceViewControllerTag = @"TSFCompetenceViewController";
static NSString *const TSFFinishQuestionnaireViewControllerTag = @"TSFFinishQuestionnaireViewController";

@interface TSFQuestionnaireViewController()
@property (nonatomic, strong) TSFCompetenceViewController *pendingCompetenceViewController;
@end

@implementation TSFQuestionnaireViewController

- (id)initWithCoder:(NSCoder *)aDecoder {
    if ((self = [super initWithCoder:aDecoder])) {
        _questionnaireService = [TSFQuestionnaireService sharedService];
        _questionnaire = [_questionnaireService.questionnaires firstObject];
        _competenceViewControllers = [[NSMutableArray alloc] init];
        _invalidCompetenceViewControllers = [[NSMapTable alloc] init];
        _succeededCompetenceViewControllers = [[NSMapTable alloc] init];
        _erroredCompetenceViewControllers = [[NSMapTable alloc] init];
    }
    return self;
}

- (void)viewDidLoad {
    self.title = TSFLocalizedString(@"TSFQuestionnaireViewControllerTitle", @"Feedback round");

    self.pageControl.pageIndicatorTintColor = [UIColor TSFLightGreyColor];
    self.pageControl.currentPageIndicatorTintColor = [UIColor TSFOrangeColor];
    
    [self loadCompetenceControllers];
    [self createFinishQuestionnaireViewController];
    [self initializePageController];
}

- (void)initializePageController {
    self.pageController = [[UIPageViewController alloc] initWithTransitionStyle:UIPageViewControllerTransitionStyleScroll
                                                          navigationOrientation:UIPageViewControllerNavigationOrientationHorizontal
                                                                        options:nil];
    self.pageController.dataSource = self;
    self.pageController.delegate = self;
    
    CGRect frame = self.view.bounds;
    frame.origin.y = self.navigationController.navigationBar.frame.size.height;
    frame.size.height -= self.pageControl.frame.size.height;
    self.pageController.view.frame = frame;
    
    if ([self.competenceViewControllers count]) {
        TSFCompetenceViewController *initialViewController = [self competenceViewControllerForCompetenceNumber:0];
        NSArray *viewControllers = @[initialViewController];
        [self.pageController setViewControllers:viewControllers
                                      direction:UIPageViewControllerNavigationDirectionForward
                                       animated:NO
                                     completion:nil];
    }
        
    [self addChildViewController:self.pageController];
    [self.view addSubview:self.pageController.view];
    [self.pageController didMoveToParentViewController:self];
    
    self.pageControl.numberOfPages = [self.questionnaire.competences count] + 1;
}

- (void)loadCompetenceControllers {
    for (NSInteger i = 0; i < [self.questionnaire.competences count]; i++) {
        [self createCompetenceControllerForNumber:i];
    }
    
    self.pageControl.currentPage = 0;
    [self.pageControl setNumberOfPages:[self.questionnaire.competences count]];
    if ([self.competenceViewControllers count]) {
        self.currentCompetenceViewController = self.competenceViewControllers[0];
    }
}

- (TSFCompetenceViewController *)competenceViewControllerForCompetenceNumber:(NSInteger)competenceNumber {
    if ([self.competenceViewControllers count] <= competenceNumber) {
        return nil;
    }
    
    return self.competenceViewControllers[competenceNumber];
}

- (UIStoryboard *)currentStoryboard {
    UIApplication *application = [UIApplication sharedApplication];
    UIWindow *backWindow = application.windows[0];
    return backWindow.rootViewController.storyboard;
}

- (void)createCompetenceControllerForNumber:(NSInteger)number {
    if (number < 0) {
        return;
    } else if (number >= [self.questionnaire.competences count]) {
        return;
    }
    
    TSFCompetenceViewController *competenceViewController = [[self currentStoryboard] instantiateViewControllerWithIdentifier:TSFCompetenceViewControllerTag];
    competenceViewController.questionnaire = self.questionnaire;
    competenceViewController.competence = self.questionnaire.competences[number];
    competenceViewController.index = number;
    
    if (!competenceViewController) {
        return;
    }

    [self.competenceViewControllers addObject:competenceViewController];
}

- (void)createFinishQuestionnaireViewController {
    TSFFinishQuestionnaireViewController *finishQuestionnaireViewController = [[self currentStoryboard] instantiateViewControllerWithIdentifier:TSFFinishQuestionnaireViewControllerTag];

    if (!finishQuestionnaireViewController) {
        return;
    }
    
    finishQuestionnaireViewController.index = [self.competenceViewControllers count];
    self.finishQuestionnaireViewController = finishQuestionnaireViewController;
}

- (void)displayValidationError {
    NSString *validationErrorMessage = TSFLocalizedString(@"TSFCompetenceControllerValidationErrorMessage", @"Please fill in every question before moving on.");
    NZAlertView *validationAlert = [[NZAlertView alloc] initWithStyle:NZAlertStyleError
                                                                title:nil
                                                              message:validationErrorMessage
                                                             delegate:nil];
    [validationAlert setStatusBarColor:[UIColor redColor]];
    [validationAlert setTextAlignment:NSTextAlignmentCenter];
    
    [validationAlert show];
}

- (void)updateCurrentCompetenceViewControllerWithCompletion:(TSFUpdateCurrentCompetenceViewControllerBlock)completion {
    __weak typeof (self) _self = self;
    __block TSFUpdateCurrentCompetenceViewControllerBlock _completion = completion;
    __block TSFCompetenceViewController *_updatingViewController = self.currentCompetenceViewController;
    
    if ([self.currentCompetenceViewController validateInput]) {
        [self.invalidCompetenceViewControllers removeObjectForKey:@(self.currentCompetenceViewController.index)];
        
        [self.currentCompetenceViewController updateCompetenceWithCompletion:^(BOOL success) {
            if (!success) {
                [_self displayValidationError];
                _completion(NO);
            } else {
                [_self.erroredCompetenceViewControllers removeObjectForKey:@(_updatingViewController.index)];
                _completion(YES);
            }
        }];
    } else {
        [self.invalidCompetenceViewControllers setObject:self.currentCompetenceViewController
                                                  forKey:@(self.currentCompetenceViewController.index)];
        [self displayValidationError];
    }
}

#pragma mark - PageViewController

- (UIViewController *)pageViewController:(UIPageViewController *)pageViewController viewControllerBeforeViewController:(UIViewController *)viewController {
    TSFCompetenceViewController *competenceViewController = (TSFCompetenceViewController *)viewController;
    NSInteger index = competenceViewController.index - 1;
    
    if (index < 0) {
        return nil;
    }
    
    return [self competenceViewControllerForCompetenceNumber:index];
}

- (UIViewController *)pageViewController:(UIPageViewController *)pageViewController
       viewControllerAfterViewController:(UIViewController *)viewController {
    TSFCompetenceViewController *competenceViewController = (TSFCompetenceViewController *)viewController;
    NSInteger index = competenceViewController.index + 1;
    
    if (index == self.competenceViewControllers.count) {
        return self.finishQuestionnaireViewController;
    } else if (index > self.competenceViewControllers.count) {
        return nil;
    }
    
    return [self competenceViewControllerForCompetenceNumber:index];
}

- (NSInteger)presentationCountForPageViewController:(UIPageViewController *)pageViewController {
    return [self.competenceViewControllers count] + 1;
}

- (NSInteger)presentationIndexForPageViewController:(UIPageViewController *)pageViewController {
    return 0;
}

- (void)pageViewController:(UIPageViewController *)pageViewController
        didFinishAnimating:(BOOL)finished
   previousViewControllers:(NSArray *)previousViewControllers
       transitionCompleted:(BOOL)completed {
    if (completed && (self.pendingCompetenceViewController.index >= self.currentCompetenceViewController.index) && (self.pendingCompetenceViewController.index < [self.competenceViewControllers count])) {
        __weak typeof (self) _self = self;
        __weak TSFCompetenceViewController *_updatedCompetenceViewController = self.currentCompetenceViewController;
        [self updateCurrentCompetenceViewControllerWithCompletion:^(BOOL success) {
            if (success) {
                [_self.succeededCompetenceViewControllers setObject:_updatedCompetenceViewController
                                                             forKey:@(_updatedCompetenceViewController.index)];
            } else {
                [_self.erroredCompetenceViewControllers setObject:_updatedCompetenceViewController
                                                           forKey:@(_updatedCompetenceViewController.index)];
            }
            
        }];
        self.currentCompetenceViewController = self.pendingCompetenceViewController;
    }
}

- (void)pageViewController:(UIPageViewController *)pageViewController willTransitionToViewControllers:(NSArray *)pendingViewControllers {
    TSFCompetenceViewController *newCompetenceViewController = (TSFCompetenceViewController *)pendingViewControllers[0];
    self.pageControl.currentPage = newCompetenceViewController.index;
    self.pendingCompetenceViewController = newCompetenceViewController;
}

@end
