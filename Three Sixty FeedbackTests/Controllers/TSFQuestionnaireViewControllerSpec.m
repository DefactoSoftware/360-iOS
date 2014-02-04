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
    });
});

SPEC_END