//
//  TSFQuestionnaireViewController.m
//  Three Sixty Feedback
//
//  Created by Girgis Ghattas on 04-02-14.
//  Copyright (c) 2014 Defacto. All rights reserved.
//

#import "TSFQuestionnaireViewController.h"
#import "TSFCompetenceViewController.h"
#import "UIColor+TSFColor.h"

static NSString *const TSFCompetenceViewControllerTag = @"TSFCompetenceViewController";

@implementation TSFQuestionnaireViewController

- (id)initWithCoder:(NSCoder *)aDecoder {
    if ((self = [super initWithCoder:aDecoder])) {
        _questionnaireService = [TSFQuestionnaireService sharedService];
        _questionnaire = [_questionnaireService.questionnaires firstObject];
        _competenceViewControllers = [[NSMutableArray alloc] init];
    }
    return self;
}

- (void)viewDidLoad {
    self.title = TSFLocalizedString(@"TSFQuestionnaireViewControllerTitle", @"Feedback round");

    self.pageControl.pageIndicatorTintColor = [UIColor TSFLightGreyColor];
    self.pageControl.currentPageIndicatorTintColor = [UIColor TSFOrangeColor];
    
    [self loadCompetenceControllers];
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
    
    self.pageControl.numberOfPages = [self.questionnaire.competences count];
}

- (void)loadCompetenceControllers {
    for (NSInteger i = 0; i < [self.questionnaire.competences count]; i++) {
        [self createCompetenceControllerForNumber:i];
    }
    
    self.pageControl.currentPage = 0;
    [self.pageControl setNumberOfPages:[self.questionnaire.competences count]];
}

- (TSFCompetenceViewController *)currentCompetenceViewController {
    return [self competenceViewControllerForCompetenceNumber:self.pageControl.currentPage];
}

- (TSFCompetenceViewController *)competenceViewControllerForCompetenceNumber:(NSInteger)competenceNumber {
    if ([self.competenceViewControllers count] <= competenceNumber) {
        return nil;
    }
    
    return self.competenceViewControllers[competenceNumber];
}

- (void)createCompetenceControllerForNumber:(NSInteger)number {
    if (number < 0) {
        return;
    } else if (number >= [self.questionnaire.competences count]) {
        return;
    }

    UIApplication *application = [UIApplication sharedApplication];
    UIWindow *backWindow = application.windows[0];
    UIStoryboard *storyboard = backWindow.rootViewController.storyboard;
    
    TSFCompetenceViewController *competenceViewController = [storyboard instantiateViewControllerWithIdentifier:TSFCompetenceViewControllerTag];
    competenceViewController.questionnaire = self.questionnaire;
    competenceViewController.competence = self.questionnaire.competences[number];
    competenceViewController.index = number;
    
    if (!competenceViewController) {
        return;
    }

    [self.competenceViewControllers addObject:competenceViewController];
}
- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
    TSFCompetenceViewController *competenceViewController = [self currentCompetenceViewController];
    if (competenceViewController.view.superview) {
        [competenceViewController viewDidAppear:animated];
    }
}

- (void)viewWillDisappear:(BOOL)animated {
    TSFCompetenceViewController *competenceViewController = [self currentCompetenceViewController];
    if (competenceViewController.view.superview) {
        [competenceViewController viewWillDisappear:animated];
    }
    [super viewWillDisappear:animated];
}

- (void)viewDidDisappear:(BOOL)animated {
    TSFCompetenceViewController *competenceViewController = [self currentCompetenceViewController];
    if (competenceViewController.view.superview) {
        [competenceViewController viewDidDisappear:animated];
    }
    [super viewDidDisappear:animated];
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

- (UIViewController *)pageViewController:(UIPageViewController *)pageViewController viewControllerAfterViewController:(UIViewController *)viewController {
    TSFCompetenceViewController *competenceViewController = (TSFCompetenceViewController *)viewController;
    NSInteger index = competenceViewController.index + 1;
    
    if (index >= self.competenceViewControllers.count) {
        return nil;
    }
    
    return [self competenceViewControllerForCompetenceNumber:index];
}

- (NSInteger)presentationCountForPageViewController:(UIPageViewController *)pageViewController {
    return [self.competenceViewControllers count];
}

- (NSInteger)presentationIndexForPageViewController:(UIPageViewController *)pageViewController {
    return 0;
}

- (void)pageViewController:(UIPageViewController *)pageViewController willTransitionToViewControllers:(NSArray *)pendingViewControllers {
    TSFCompetenceViewController *newCompetenceViewController = (TSFCompetenceViewController *)pendingViewControllers[0];
    self.pageControl.currentPage = newCompetenceViewController.index;
}

@end
