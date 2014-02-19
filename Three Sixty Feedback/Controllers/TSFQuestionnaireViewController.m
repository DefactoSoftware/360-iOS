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
        _assessorService = [TSFAssessorService sharedService];
        _questionnaire = [_questionnaireService.questionnaires firstObject];
        _competenceViewControllers = [[NSMutableArray alloc] init];
        _invalidCompetenceViewControllers = [[NSMapTable alloc] init];
        _updatedCompetenceViewControllers = [[NSMapTable alloc] init];
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

#pragma mark - Initializing page controller and child viewcontrollers


- (void)initializePageController {
    self.pageController = [[UIPageViewController alloc] initWithTransitionStyle:UIPageViewControllerTransitionStyleScroll
                                                          navigationOrientation:UIPageViewControllerNavigationOrientationHorizontal
                                                                        options:nil];
    self.pageController.dataSource = self;
    self.pageController.delegate = self;
    
    CGRect frame = self.view.bounds;
    frame.origin.y = self.navigationController.navigationBar.frame.size.height;
    frame.size.height -= self.pageControl.frame.size.height * 2;
    if (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad) {
        frame.size.height -= self.firstButton.frame.size.height;
    }
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
    finishQuestionnaireViewController.questionnaireViewController = self;
    self.finishQuestionnaireViewController = finishQuestionnaireViewController;
}

#pragma mark - Alert messages

- (void)displayValidationError {
    NSString *message = TSFLocalizedString(@"TSFCompetenceControllerValidationErrorMessage", @"Please fill in every question before moving on.");
    NZAlertView *alert = [[NZAlertView alloc] initWithStyle:NZAlertStyleError
                                                                title:nil
                                                              message:message
                                                             delegate:nil];
    [alert setStatusBarColor:[UIColor redColor]];
    [alert setTextAlignment:NSTextAlignmentCenter];
    
    [alert show];
}

- (void)displayUpdateError {
    NSString *message = TSFLocalizedString(@"TSFFinishQuestionnaireViewControllerUpdateError", @"Er is iets misgegaan bij het versturen van de competentie.");
    NSString *title = TSFLocalizedString(@"TSFFinishQuestionnaireViewControllerUpdateErrorMessage", @"Probeer het nogmaals.");
    
    NZAlertView *alert = [[NZAlertView alloc] initWithStyle:NZAlertStyleError
                                                                title:title
                                                              message:message
                                                             delegate:nil];
    [alert setStatusBarColor:[UIColor redColor]];
    [alert setTextAlignment:NSTextAlignmentCenter];
    
    [alert show];
}

- (void)displayCompletionError {
    NSString *message = TSFLocalizedString(@"TSFFinishQuestionnaireViewControllerError", @"Er is iets misgegaan bij het versturen.");
    NSString *title = TSFLocalizedString(@"TSFFinishQuestionnaireViewControllerErrorMessage", @"Probeer het nogmaals.");
    
    NZAlertView *alert = [[NZAlertView alloc] initWithStyle:NZAlertStyleError
                                                                title:title
                                                              message:message
                                                             delegate:nil];
    [alert setStatusBarColor:[UIColor redColor]];
    [alert setTextAlignment:NSTextAlignmentCenter];
    
    [alert show];
}

#pragma mark - Updating and completing

- (void)updateCurrentCompetenceViewController {
    __weak typeof (self) _self = self;
    __block TSFCompetenceViewController *_updatingViewController = self.currentCompetenceViewController;
    
    if ([self.currentCompetenceViewController validateInput]) {
        [self.invalidCompetenceViewControllers removeObjectForKey:@(self.currentCompetenceViewController.index)];
        
        [self.currentCompetenceViewController updateCompetenceWithCompletion:^(BOOL success) {
            if (!success) {
                [_self.erroredCompetenceViewControllers setObject:_updatingViewController
                                                           forKey:@(_updatingViewController.index)];
            } else {
                [_self.erroredCompetenceViewControllers removeObjectForKey:@(_updatingViewController.index)];
            }
            [_self.updatedCompetenceViewControllers setObject:_updatingViewController
                                                       forKey:@(_updatingViewController.index)];
            [_self completeQuestionnaireCheck];
        }];
    } else {
        [self.invalidCompetenceViewControllers setObject:self.currentCompetenceViewController
                                                  forKey:@(self.currentCompetenceViewController.index)];
        [_self.updatedCompetenceViewControllers setObject:_updatingViewController
                                                   forKey:@(_updatingViewController.index)];
        [_self completeQuestionnaireCheck];
    }
}

- (void)jumpToCompetencePage:(NSInteger)page {
    self.currentCompetenceViewController = self.competenceViewControllers[page];
    [self.pageController setViewControllers:@[self.currentCompetenceViewController]
                                  direction:UIPageViewControllerNavigationDirectionReverse
                                   animated:NO
                                 completion:^(BOOL finished) {}];
    
    self.pageControl.currentPage = self.currentCompetenceViewController.index;
}

- (BOOL)failedCompetencesCheck {
    if ([self.invalidCompetenceViewControllers count]) {
        NSEnumerator *invalidControllersEnumerator = [self.invalidCompetenceViewControllers objectEnumerator];
        TSFCompetenceViewController *firstInvalidCompetenceViewController = [invalidControllersEnumerator nextObject];
        [self jumpToCompetencePage:firstInvalidCompetenceViewController.index];
        [self displayValidationError];
        return NO;
    } else if ([self.erroredCompetenceViewControllers count]) {
        NSEnumerator *erroredControllersEnumerator = [self.erroredCompetenceViewControllers objectEnumerator];
        TSFCompetenceViewController *firstErroredCompetenceViewController = [erroredControllersEnumerator nextObject];
        [self jumpToCompetencePage:firstErroredCompetenceViewController.index];
        [self displayUpdateError];
        return NO;
    }
    return YES;
}

- (void)completeQuestionnaireCheck {
    if ([self.updatedCompetenceViewControllers count] == [self.competenceViewControllers count]) {
        [self.finishQuestionnaireViewController canComplete];
    }
}

- (void)completeQuestionnaireWithCompletion:(TSFCompleteQuestionnaireViewControllerBlock)completion {
    __block TSFCompleteQuestionnaireViewControllerBlock _completion = completion;
    
    if ([self failedCompetencesCheck]) {
        [self.assessorService completeCurrentAssessmentWithSuccess:^(NSNumber *success) {
            _completion(YES);
        } failure:^(NSError *error) {
            _completion(NO);
        }];
    }
}

- (IBAction)previousButtonPressed:(id)sender {
    NSInteger previousCompetenceViewControllerIndex = self.currentCompetenceViewController.index - 1;
    if (previousCompetenceViewControllerIndex >= 0) {
        TSFCompetenceViewController *previousViewController = self.competenceViewControllers[previousCompetenceViewControllerIndex];
        
        if ([[self.pageController.viewControllers firstObject] isKindOfClass:[TSFFinishQuestionnaireViewController class]]) {
            previousViewController = [self.competenceViewControllers lastObject];
        }
        
        self.currentCompetenceViewController = previousViewController;
        
        __block typeof (self) _self = self;
        [self.pageController setViewControllers:@[previousViewController]
                                      direction:UIPageViewControllerNavigationDirectionReverse
                                       animated:YES
                                     completion:^(BOOL finished) {
            _self.pageControl.currentPage -= 1;
        }];
    }
}

- (IBAction)firstButtonPressed:(id)sender {
    __block typeof (self) _self = self;
    [self.pageController setViewControllers:@[[self.competenceViewControllers firstObject]]
                                  direction:UIPageViewControllerNavigationDirectionReverse
                                   animated:NO
                                 completion:^(BOOL finished) {
        _self.pageControl.currentPage = 0;
        _self.currentCompetenceViewController = [_self.competenceViewControllers firstObject];
    }];
}

- (IBAction)lastButtonPressed:(id)sender {
    __weak typeof (self) _self = self;
    [self.pageController setViewControllers:@[self.finishQuestionnaireViewController]
                                  direction:UIPageViewControllerNavigationDirectionForward
                                   animated:NO
                                 completion:^(BOOL finished) {
                                     _self.pageControl.currentPage = [_self.competenceViewControllers count];
        _self.currentCompetenceViewController = [_self.competenceViewControllers lastObject];
    }];
}

- (IBAction)nextButtonPressed:(id)sender {
    [self updateCurrentCompetenceViewController];
    
    __block UIViewController *_nextViewController;
    if (self.currentCompetenceViewController.index + 1 == [self.competenceViewControllers count]) {
        _nextViewController = self.finishQuestionnaireViewController;
    } else {
        NSInteger newCompetenceControllerIndex = self.currentCompetenceViewController.index + 1;
        _nextViewController = [self competenceViewControllerForCompetenceNumber:newCompetenceControllerIndex];
        self.currentCompetenceViewController = (TSFCompetenceViewController *)_nextViewController;
    }
    
    __block typeof (self) _self = self;
    [self.pageController setViewControllers:@[_nextViewController]
                                  direction:UIPageViewControllerNavigationDirectionForward
                                   animated:YES
                                 completion:^(BOOL finished) {
     _self.pageControl.currentPage += 1;
    }];
}

#pragma mark - PageViewController delegate

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

- (void)pageViewController:(UIPageViewController *)pageViewController
        didFinishAnimating:(BOOL)finished
   previousViewControllers:(NSArray *)previousViewControllers
       transitionCompleted:(BOOL)completed {
    if (completed) {
        if (self.pendingCompetenceViewController.index >= self.currentCompetenceViewController.index && (self.pendingCompetenceViewController.index <= [self.competenceViewControllers count])) {
            [self updateCurrentCompetenceViewController];
        }
        
        self.currentCompetenceViewController = self.pendingCompetenceViewController;
        self.pageControl.currentPage = self.currentCompetenceViewController.index;
    }
}

- (void)pageViewController:(UIPageViewController *)pageViewController willTransitionToViewControllers:(NSArray *)pendingViewControllers {
    TSFCompetenceViewController *newCompetenceViewController = (TSFCompetenceViewController *)pendingViewControllers[0];
    self.pendingCompetenceViewController = newCompetenceViewController;
}

@end