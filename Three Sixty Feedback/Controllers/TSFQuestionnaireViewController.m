//
//  TSFQuestionnaireViewController.m
//  Three Sixty Feedback
//
//  Created by Girgis Ghattas on 04-02-14.
//  Copyright (c) 2014 Defacto. All rights reserved.
//

#import "TSFQuestionnaireViewController.h"
#import "TSFCompetenceViewController.h"

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

}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    
    [self loadCompetenceControllers:animated];
}

- (void)loadCompetenceControllers:(BOOL)animated {
    for (NSInteger i = 0; i < [self.questionnaire.competences count]; i++) {
        [self loadScrollViewWithPage:i];
    }
    
    self.pageControl.currentPage = 0;
    [self.pageControl setNumberOfPages:[self.questionnaire.competences count]];
    
    TSFCompetenceViewController *competenceViewController = [self competenceViewControllerForCompetenceNumber:self.pageControl.currentPage];
    if (!competenceViewController.view.superview) {
        [competenceViewController viewWillAppear:animated];
    }
    
    self.scrollView.contentSize = CGSizeMake(self.scrollView.frame.size.width * [self.childViewControllers count], self.scrollView.frame.size.height);
}

- (TSFCompetenceViewController *)currentCompetenceViewController {
    return [self competenceViewControllerForCompetenceNumber:self.pageControl.currentPage];
}

- (TSFCompetenceViewController *)competenceViewControllerForCompetenceNumber:(NSInteger)competenceNumber {
    return self.competenceViewControllers[competenceNumber];
}

- (void)loadScrollViewWithPage:(NSInteger)pageNumber {
    if (pageNumber < 0) {
        return;
    } else if (pageNumber >= [self.questionnaire.competences count]) {
        return;
    }

    UIApplication *application = [UIApplication sharedApplication];
    UIWindow *backWindow = application.windows[0];
    UIStoryboard *storyboard = backWindow.rootViewController.storyboard;
    
    TSFCompetenceViewController *competenceViewController = [storyboard instantiateViewControllerWithIdentifier:TSFCompetenceViewControllerTag];
    competenceViewController.questionnaire = self.questionnaire;
    competenceViewController.competence = self.questionnaire.competences[pageNumber];
    
    if (!competenceViewController) {
        return;
    }
    
    if (!competenceViewController.view.superview) {
        CGRect frame = self.scrollView.frame;
        frame.origin.x = frame.size.width * pageNumber;
        frame.origin.y = 0;
        competenceViewController.view.frame = frame;
        [self.scrollView addSubview:competenceViewController.view];
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

#pragma mark - PageControl changePage action
- (IBAction)changePage:(id)sender {
    
}

@end
