//
//  TSFQuestionnaireViewControllerSpec.m
//  Three Sixty Feedback
//
//  Created by Girgis Ghattas on 04-02-14.
//  Copyright (c) 2014 Defacto. All rights reserved.
//

#import "Kiwi.h"
#import "TSFQuestionnaireViewController.h"
#import "TSFCompetenceViewController.h"
#import "TSFFinishQuestionnaireViewController.h"

SPEC_BEGIN(TSFQuestionnaireViewControllerSpec)

describe(@"TSFQuestionnaireViewController", ^{
    __block UIStoryboard *_storyboard;
    __block TSFQuestionnaireViewController*_questionnaireViewController;
    
    beforeEach (^{
        _storyboard = [UIStoryboard storyboardWithName:@"Main_iPhone" bundle:nil];
        _questionnaireViewController = [_storyboard instantiateViewControllerWithIdentifier:@"TSFQuestionnaireViewController"];
        
        UIView *view = _questionnaireViewController.view;
        [[view shouldNot] beNil];
	});
    
    it(@"instantiates correctly from the storyboard", ^{
        [[_questionnaireViewController shouldNot] beNil];
        [[_questionnaireViewController should] beKindOfClass:[TSFQuestionnaireViewController class]];
	});
    
    it(@"has an outlet for the page control", ^{
        [[_questionnaireViewController.pageControl shouldNot] beNil];
    });
    
    it(@"has a reference to the questionnaire service", ^{
        [[_questionnaireViewController.questionnaireService shouldNot] beNil];
        [[_questionnaireViewController.questionnaireService should] beKindOfClass:[TSFQuestionnaireService class]];
    });
    
    it(@"has a reference to the assessor service", ^{
        [[_questionnaireViewController.assessorService shouldNot] beNil];
        [[_questionnaireViewController.assessorService should] beKindOfClass:[TSFAssessorService class]];
    });

    context(@"iPad", ^{
        beforeEach (^{
            _storyboard = [UIStoryboard storyboardWithName:@"Main_iPhone" bundle:nil];
            _questionnaireViewController = [_storyboard instantiateViewControllerWithIdentifier:@"TSFQuestionnaireViewController"];
            
            UIView *view = _questionnaireViewController.view;
            [[view shouldNot] beNil];
        });
        
        it(@"instantiates correctly from the storyboard", ^{
            [[_questionnaireViewController shouldNot] beNil];
            [[_questionnaireViewController should] beKindOfClass:[TSFQuestionnaireViewController class]];
        });
        
        it(@"has an outlet for the page control", ^{
            [[_questionnaireViewController.pageControl shouldNot] beNil];
        });
        
        it(@"has a reference to the questionnaire service", ^{
            [[_questionnaireViewController.questionnaireService shouldNot] beNil];
            [[_questionnaireViewController.questionnaireService should] beKindOfClass:[TSFQuestionnaireService class]];
        });
    });
    
    it(@"has a pagecontroller", ^{
        [[_questionnaireViewController.pageController shouldNot] beNil];
        [[_questionnaireViewController.pageController should] beKindOfClass:[UIPageViewController class]];
    });
    
    it(@"creates a finish questionnaire viewcontroller", ^{
        [_questionnaireViewController createFinishQuestionnaireViewController];
        TSFFinishQuestionnaireViewController *finishQuestionnaireViewController = _questionnaireViewController.finishQuestionnaireViewController;
        
        [[finishQuestionnaireViewController shouldNot] beNil];
        [[finishQuestionnaireViewController should] beKindOfClass:[TSFFinishQuestionnaireViewController class]];
        [[theValue(finishQuestionnaireViewController.index) should] equal:theValue(0)];
        [[finishQuestionnaireViewController.questionnaireViewController should] equal:_questionnaireViewController];
    });
    
    context(@"with a questionnaire", ^{
        __block TSFQuestionnaire *_questionnaire;
        __block TSFCompetence *_competenceOne;
        __block TSFCompetence *_competenceTwo;
        
        beforeEach(^{
            _questionnaire = [[TSFQuestionnaire alloc] init];
            _competenceOne = [[TSFCompetence alloc] init];
            _competenceTwo = [[TSFCompetence alloc] init];
            
            _questionnaire.competences = @[_competenceOne, _competenceTwo];
            _questionnaireViewController.questionnaire = _questionnaire;

            [_questionnaireViewController loadCompetenceControllers];
        });
        
        it(@"calls the assessor service to complete the questionnaire", ^{
            id mockAssessorService = [KWMock mockForClass:[TSFAssessorService class]];
            
            _questionnaireViewController.assessorService = mockAssessorService;
            [[mockAssessorService should] receive:@selector(completeCurrentAssessmentWithSuccess:failure:)];
            
            [_questionnaireViewController completeQuestionnaireWithCompletion:^(BOOL success) {}];
        });
        
        context(@"storing the controllers after update", ^{
            __block id _mockCompetenceViewController;
            __block TSFCompetenceViewController *_pendingCompetenceViewController;
            __block NSInteger _index;
            
            beforeEach(^{
                _mockCompetenceViewController = [KWMock mockForClass:[TSFCompetenceViewController class]];
                _index = 0;
                _questionnaireViewController.currentCompetenceViewController = _mockCompetenceViewController;
                _pendingCompetenceViewController = [[TSFCompetenceViewController alloc] init];
                _pendingCompetenceViewController.index = _index + 1;
                
                [_mockCompetenceViewController stub:@selector(index) andReturn:theValue(_index)];
            });
            
            it(@"stores the competence view controller in the list of succeeded controllers when the update succeeds", ^{
                [[_mockCompetenceViewController should] receive:@selector(validateInput) andReturn:theValue(YES)];
                [_mockCompetenceViewController stub:@selector(updateCompetenceWithCompletion:) withBlock:^id(NSArray *params) {
                    void (^completionBlock)(BOOL success) = params[0];
                    completionBlock(YES);
                    return nil;
                }];
                
                [_questionnaireViewController pageViewController:_questionnaireViewController.pageController
                                 willTransitionToViewControllers:@[_pendingCompetenceViewController]];
                [_questionnaireViewController pageViewController:_questionnaireViewController.pageController
                                              didFinishAnimating:YES
                                         previousViewControllers:@[_mockCompetenceViewController]
                                             transitionCompleted:YES];
                
                [[theValue([_questionnaireViewController.succeededCompetenceViewControllers count]) should] equal:theValue(1)];
                [[[_questionnaireViewController.succeededCompetenceViewControllers objectForKey:@(_index)] should] equal:_mockCompetenceViewController];
            });
            
            it(@"stores the competence view controller in the list of validation errored controllers when validation fails", ^{
                [[_mockCompetenceViewController should] receive:@selector(validateInput) andReturn:theValue(NO)];
                
                [_questionnaireViewController updateCurrentCompetenceViewControllerWithCompletion:^(BOOL success) {}];
                [[theValue([_questionnaireViewController.invalidCompetenceViewControllers count]) should] equal:theValue(1)];
                [[[_questionnaireViewController.invalidCompetenceViewControllers objectForKey:@(_index)] should] equal:_mockCompetenceViewController];
            });
            
            it(@"removes the stored invalid controller when the update succeeds", ^{
                [_questionnaireViewController.invalidCompetenceViewControllers setObject:_mockCompetenceViewController forKey:@(_index)];
                [[_mockCompetenceViewController should] receive:@selector(validateInput) andReturn:theValue(YES)];
                [[_mockCompetenceViewController should] receive:@selector(updateCompetenceWithCompletion:)];
                
                [_questionnaireViewController updateCurrentCompetenceViewControllerWithCompletion:^(BOOL success) {}];
                
                [[theValue([_questionnaireViewController.invalidCompetenceViewControllers count]) should] equal:theValue(0)];
            });
            
            it(@"stores the competence view controller in the list of errored controllers when the update fails", ^{
                [[_mockCompetenceViewController should] receive:@selector(validateInput) andReturn:theValue(YES)];
                [_mockCompetenceViewController stub:@selector(updateCompetenceWithCompletion:) withBlock:^id(NSArray *params) {
                    void (^completionBlock)(BOOL success) = params[0];
                    completionBlock(NO);
                    return nil;
                }];
                
                [_questionnaireViewController pageViewController:_questionnaireViewController.pageController
                                 willTransitionToViewControllers:@[_pendingCompetenceViewController]];
                [_questionnaireViewController pageViewController:_questionnaireViewController.pageController
                                              didFinishAnimating:YES
                                         previousViewControllers:@[[[TSFCompetenceViewController alloc] init]]
                                             transitionCompleted:YES];
                
                [[theValue([_questionnaireViewController.erroredCompetenceViewControllers count]) should] equal:theValue(1)];
                [[[_questionnaireViewController.erroredCompetenceViewControllers objectForKey:@(_index)] should] equal:_mockCompetenceViewController];
            });
            
            it(@"removes the stored errored controller when the update succeeds", ^{
                [_questionnaireViewController.erroredCompetenceViewControllers setObject:_mockCompetenceViewController forKey:@(_index)];
                [[_mockCompetenceViewController should] receive:@selector(validateInput) andReturn:theValue(YES)];
                [_mockCompetenceViewController stub:@selector(updateCompetenceWithCompletion:) withBlock:^id(NSArray *params) {
                    void (^completionBlock)(BOOL success) = params[0];
                    completionBlock(YES);
                    return nil;
                }];
                
                [_questionnaireViewController updateCurrentCompetenceViewControllerWithCompletion:^(BOOL success) {}];
                
                [[theValue([_questionnaireViewController.erroredCompetenceViewControllers count]) should] equal:theValue(0)];
            });
        });
        
        it(@"instantiates competence viewcontrollers based on the questionnaires competences", ^{
            [[theValue([_questionnaireViewController.competenceViewControllers count]) should] equal:theValue(2)];
            [[[_questionnaireViewController.competenceViewControllers firstObject] should] beKindOfClass:[TSFCompetenceViewController class]];
        });
        
        it(@"passes the competence and questionnaire to the competence viewcontrollers", ^{
            TSFCompetenceViewController *firstCompetenceViewController = _questionnaireViewController.competenceViewControllers[0];
            [[firstCompetenceViewController.competence should] equal:_competenceOne];
            [[firstCompetenceViewController.questionnaire should] equal:_questionnaire];

            TSFCompetenceViewController *secondCompetenceViewController = _questionnaireViewController.competenceViewControllers[1];
            [[secondCompetenceViewController.competence should] equal:_competenceTwo];
        });
        
        it(@"sets the correct index on the competence viewcontroller", ^{
            TSFCompetenceViewController *firstCompetenceViewController = _questionnaireViewController.competenceViewControllers[0];
            TSFCompetenceViewController *secondCompetenceViewController = _questionnaireViewController.competenceViewControllers[1];
            
            [[theValue(firstCompetenceViewController.index) should] equal:theValue(0)];
            [[theValue(secondCompetenceViewController.index) should] equal:theValue(1)];
        });
        
        it(@"sets the first competence view controller as the current", ^{
            [[_questionnaireViewController.currentCompetenceViewController should] equal:_questionnaireViewController.competenceViewControllers[0]];
        });
        
        context(@"updating the competence", ^{
            __block id _mockCompetenceViewController;
            
            beforeEach(^{
                _mockCompetenceViewController = [KWMock mockForClass:[TSFCompetenceViewController class]];
                _questionnaireViewController.currentCompetenceViewController = _mockCompetenceViewController;
                _questionnaireViewController.competenceViewControllers[0] = _mockCompetenceViewController;
            });
            
            it(@"calls the update method on the competence view controller when the validation succeeds", ^{
                [[_mockCompetenceViewController should] receive:@selector(validateInput) andReturn:theValue(YES)];
                [[_mockCompetenceViewController should] receive:@selector(updateCompetenceWithCompletion:)];
                [[_mockCompetenceViewController should] receive:@selector(index)];
                
                [_questionnaireViewController updateCurrentCompetenceViewControllerWithCompletion:^(BOOL success) {}];
            });
            
            it(@"does not call the update method when the validation fails", ^{
                [[_mockCompetenceViewController should] receive:@selector(index)];
                [[_mockCompetenceViewController should] receive:@selector(validateInput) andReturn:theValue(NO)];
                
                [_questionnaireViewController updateCurrentCompetenceViewControllerWithCompletion:^(BOOL success) {}];
            });
        });
        
        context(@"navigating to next competence", ^{
            __block TSFCompetenceViewController *_competenceViewController;
            
            beforeEach(^{
                _competenceViewController = [[TSFCompetenceViewController alloc] init];
                
                _questionnaireViewController.currentCompetenceViewController = _competenceViewController;
                _questionnaireViewController.competenceViewControllers[0] = _competenceViewController;
                
                _questionnaireViewController.currentCompetenceViewController = _questionnaireViewController.competenceViewControllers[0];
            });
            
            it(@"updates the current competence view controller to the new one", ^{
                [_questionnaireViewController pageViewController:_questionnaireViewController.pageController
                                 willTransitionToViewControllers:@[_questionnaireViewController.competenceViewControllers[1]]];
                [_questionnaireViewController pageViewController:_questionnaireViewController.pageController
                                              didFinishAnimating:YES
                                         previousViewControllers:@[_questionnaireViewController.competenceViewControllers[1]]
                                             transitionCompleted:YES];
                [[_questionnaireViewController.currentCompetenceViewController should] equal:_questionnaireViewController.competenceViewControllers[1]];
            });
            
            it(@"updates the current competence view controller to the new one when navigating backwards", ^{
                _questionnaireViewController.currentCompetenceViewController = _questionnaireViewController.competenceViewControllers[1];
                
                [_questionnaireViewController pageViewController:_questionnaireViewController.pageController
                                 willTransitionToViewControllers:@[_questionnaireViewController.competenceViewControllers[0]]];
                [_questionnaireViewController pageViewController:_questionnaireViewController.pageController
                                              didFinishAnimating:YES
                                         previousViewControllers:@[_questionnaireViewController.competenceViewControllers[0]]
                                             transitionCompleted:YES];
                [[_questionnaireViewController.currentCompetenceViewController should] equal:_questionnaireViewController.competenceViewControllers[0]];
            });
            
            it(@"does not update the current competence view controller when navigating to the previous one", ^{
                id mockCompetenceViewController = [KWMock mockForClass:[TSFCompetenceViewController class]];
                _questionnaireViewController.competenceViewControllers[1] = mockCompetenceViewController;
                
                [_questionnaireViewController pageViewController:_questionnaireViewController.pageController
                                 willTransitionToViewControllers:@[_questionnaireViewController.competenceViewControllers[0]]];
                [_questionnaireViewController pageViewController:_questionnaireViewController.pageController
                                              didFinishAnimating:YES 
                                         previousViewControllers:@[_questionnaireViewController.competenceViewControllers[0]]
                                             transitionCompleted:YES];
            });
            
            it(@"does not update the current competence view controller when the animation is not completed", ^{
                [_questionnaireViewController pageViewController:_questionnaireViewController.pageController
                                 willTransitionToViewControllers:@[_questionnaireViewController.competenceViewControllers[1]]];
                [_questionnaireViewController pageViewController:_questionnaireViewController.pageController
                                              didFinishAnimating:YES
                                         previousViewControllers:@[_questionnaireViewController.competenceViewControllers[1]]
                                             transitionCompleted:NO];
                
                [[_questionnaireViewController.currentCompetenceViewController should] equal:_questionnaireViewController.competenceViewControllers[0]];
            });
            
            it(@"presents the finish questionnaire viewcontroller at the end", ^{
                UIViewController *finalViewController = [_questionnaireViewController pageViewController:_questionnaireViewController.pageController
                                                                       viewControllerAfterViewController:_questionnaireViewController.competenceViewControllers[1]];
                
                [[finalViewController should] beKindOfClass:[TSFFinishQuestionnaireViewController class]];
            });
            
            it(@"presents the last competence viewcontroller when navigating backwards from the final viewcontroller", ^{
                [_questionnaireViewController createFinishQuestionnaireViewController];
                TSFFinishQuestionnaireViewController *finalViewController = _questionnaireViewController.finishQuestionnaireViewController;
                
                UIViewController *competenceController = [_questionnaireViewController pageViewController:_questionnaireViewController.pageController
                                                                       viewControllerBeforeViewController:finalViewController];
            
                [[competenceController shouldNot] beNil];
                [[competenceController should] beKindOfClass:[TSFCompetenceViewController class]];
            });
        });
        
        context(@"checking failed competences before completing the questionnaire", ^{
            __block id _mockPageController;
            __block id _mockAssessorService;
            
            beforeEach(^{
                _mockPageController = [KWMock mockForClass:[UIPageViewController class]];
                _mockAssessorService = [KWMock mockForClass:[TSFAssessorService class]];
                
                _questionnaireViewController.pageController = _mockPageController;
                _questionnaireViewController.assessorService = _mockAssessorService;
                _questionnaireViewController.currentCompetenceViewController = _questionnaireViewController.competenceViewControllers[1];
            });
            
            it(@"switches to the invalid competence before sending", ^{
                [_questionnaireViewController.invalidCompetenceViewControllers setObject:_questionnaireViewController.competenceViewControllers[0]
                                                                                  forKey:@(0)];
                [_questionnaireViewController.invalidCompetenceViewControllers setObject:_questionnaireViewController.competenceViewControllers[1]
                                                                                  forKey:@(1)];
                [[_mockPageController should] receive:@selector(setViewControllers:direction:animated:completion:)
                                        withArguments:@[_questionnaireViewController.competenceViewControllers[0]], [KWAny any], theValue(NO), [KWAny any]];
                
                BOOL check = [_questionnaireViewController completeQuestionnaireCheck];
                
                [[_questionnaireViewController.currentCompetenceViewController should] equal:_questionnaireViewController.competenceViewControllers[0]];
                [[theValue(check) should] equal:theValue(NO)];
            });
            
            it(@"switches to the errored competence before sending", ^{
                [_questionnaireViewController.erroredCompetenceViewControllers setObject:_questionnaireViewController.competenceViewControllers[0]
                                                                                  forKey:@(0)];
                [_questionnaireViewController.erroredCompetenceViewControllers setObject:_questionnaireViewController.competenceViewControllers[1]
                                                                                  forKey:@(1)];
                
                [[_mockPageController should] receive:@selector(setViewControllers:direction:animated:completion:)
                                        withArguments:@[_questionnaireViewController.competenceViewControllers[0]], [KWAny any], theValue(NO), [KWAny any]];
                
                BOOL check = [_questionnaireViewController completeQuestionnaireCheck];
                
                [[_questionnaireViewController.currentCompetenceViewController should] equal:_questionnaireViewController.competenceViewControllers[0]];
                [[theValue(check) should] equal:theValue(NO)];
            });
            
            it(@"returns yes when there are no invalid or errored competences", ^{
                BOOL check = [_questionnaireViewController completeQuestionnaireCheck];
                
                [[theValue(check) should] equal:theValue(YES)];
            });
        });
    });
});

SPEC_END