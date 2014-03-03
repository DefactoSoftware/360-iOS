//
//  TSFNewQuestionnaireViewController.m
//  Three Sixty Feedback
//
//  Created by Girgis Ghattas on 03-03-14.
//  Copyright (c) 2014 Defacto. All rights reserved.
//

#import "TSFNewQuestionnaireViewController.h"
#import "TSFGenerics.h"

static NSString *const TSFNewQuestionnaireSubjectViewControllerIdentifier = @"TSFNewQuestionnaireSubjectViewController";

@interface TSFNewQuestionnaireViewController()
@property (nonatomic, assign) NSInteger currentPage;
@end

@implementation TSFNewQuestionnaireViewController

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
    self.pageViewController = [[UIPageViewController alloc] initWithTransitionStyle:UIPageViewControllerTransitionStyleScroll
                                                              navigationOrientation:UIPageViewControllerNavigationOrientationHorizontal
                                                                            options:nil];
    self.pageViewController.dataSource = self;
    self.pageViewController.delegate = self;
    
    self.currentPage = 0;
}

- (void)setupViewControllers {
    TSFNewQuestionnaireSubjectViewController *subjectViewController = [self.storyboard
                                                                       instantiateViewControllerWithIdentifier:TSFNewQuestionnaireSubjectViewControllerIdentifier];
    
    self.viewControllers = @[
                             subjectViewController
                             ];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItem.title = TSFLocalizedString(@"TSFNewQuestionnaireViewControllerTitle", @"Create new questionnaire");
    
    [self setupViewControllers];
}

#pragma mark - PageViewController

- (UIViewController *)pageViewController:(UIPageViewController *)pageViewController
      viewControllerBeforeViewController:(UIViewController *)viewController {
    if (!self.currentPage) {
        return nil;
    }
    
    return self.viewControllers[self.currentPage - 1];
}

- (UIViewController *)pageViewController:(UIPageViewController *)pageViewController
       viewControllerAfterViewController:(UIViewController *)viewController {
    if ([self.viewControllers count] == self.currentPage) {
        return nil;
    }
    
    return self.viewControllers[self.currentPage + 1];
}

@end
