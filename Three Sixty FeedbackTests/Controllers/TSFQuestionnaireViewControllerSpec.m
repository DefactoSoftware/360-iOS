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
        
        it(@"stores the competence view controller in the list of validation errored controllers when validation fails", ^{
            NSInteger randomIndex = arc4random();
            
            id mockCompetenceViewController = [KWMock mockForClass:[TSFCompetenceViewController class]];
            _questionnaireViewController.currentCompetenceViewController = mockCompetenceViewController;
            [[mockCompetenceViewController should] receive:@selector(validateInput) andReturn:theValue(NO)];
            [[mockCompetenceViewController should] receive:@selector(index) andReturn:theValue(randomIndex)];
            
            [_questionnaireViewController updateCurrentCompetenceViewControllerWithCompletion:^(BOOL success) {}];
            [[theValue([_questionnaireViewController.invalidCompetenceViewControllers count]) should] equal:theValue(1)];
            [[[_questionnaireViewController.invalidCompetenceViewControllers objectForKey:[NSNumber numberWithInteger:randomIndex]] should] equal:mockCompetenceViewController];
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
            
            it(@"does not update the current competence view controller when the animation is not completed", ^{
                [_questionnaireViewController pageViewController:_questionnaireViewController.pageController
                                 willTransitionToViewControllers:@[_questionnaireViewController.competenceViewControllers[1]]];
                [_questionnaireViewController pageViewController:_questionnaireViewController.pageController
                                              didFinishAnimating:YES
                                         previousViewControllers:@[_questionnaireViewController.competenceViewControllers[1]]
                                             transitionCompleted:NO];
                
                [[_questionnaireViewController.currentCompetenceViewController should] equal:_questionnaireViewController.competenceViewControllers[0]];
            });
        });
    });
});

SPEC_END