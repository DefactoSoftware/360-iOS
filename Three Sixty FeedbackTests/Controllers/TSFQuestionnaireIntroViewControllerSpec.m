//
//  TSFQuestionnaireIntroViewControllerSpec.m
//  Three Sixty Feedback
//
//  Created by Girgis Ghattas on 02-02-14.
//  Copyright (c) 2014 Defacto. All rights reserved.
//

#import "Kiwi.h"
#import "TSFQuestionnaireIntroViewController.h"

SPEC_BEGIN(TSFQuestionnaireIntroViewControllerSpec)

describe(@"TSFQuestionnaireIntroViewController", ^{
    __block UIStoryboard *_storyboard;
    __block TSFQuestionnaireIntroViewController *_questionnaireIntroViewController;
    __block id _mockQuestionnaireService;

    context(@"iPhone", ^{
        beforeEach (^{
            _storyboard = [UIStoryboard storyboardWithName:@"Main_iPhone" bundle:nil];
            _questionnaireIntroViewController = [_storyboard instantiateViewControllerWithIdentifier:@"TSFQuestionnaireIntroViewController"];
            
            _mockQuestionnaireService = [KWMock mockForClass:[TSFQuestionnaireService class]];
            _questionnaireIntroViewController.questionnaireService = _mockQuestionnaireService;
            [[_mockQuestionnaireService should] receive:@selector(questionnairesWithSuccess:failure:)];
            
            UIView *view = _questionnaireIntroViewController.view;
            [[view shouldNot] beNil];
        });
        
        it(@"instantiates correctly from the storyboard", ^{
            [[_questionnaireIntroViewController shouldNot] beNil];
            [[_questionnaireIntroViewController should] beKindOfClass:[TSFQuestionnaireIntroViewController class]];
        });
        
        it(@"has an outlet for the scrollview", ^{
            [[_questionnaireIntroViewController.introScrollView shouldNot] beNil];
        });
        
        it(@"has an outlet for the intro label", ^{
            [[_questionnaireIntroViewController.introLabel shouldNot] beNil];
        });
        
        it(@"has an outlet for the subject label", ^{
            [[_questionnaireIntroViewController.subjectLabel shouldNot] beNil];
        });
        
        it(@"has an outlet for the info label", ^{
            [[_questionnaireIntroViewController.infoLabel shouldNot] beNil];
        });
        
        it(@"has an outlet for the time label", ^{
            [[_questionnaireIntroViewController.introScrollView shouldNot] beNil];
        });
        
        it(@"has an outlet for the start button", ^{
            [[_questionnaireIntroViewController.startButton shouldNot] beNil];
        });
        
    });
    
    context(@"iPad", ^{
        beforeEach (^{
            _storyboard = [UIStoryboard storyboardWithName:@"Main_iPad" bundle:nil];
            _questionnaireIntroViewController = [_storyboard instantiateViewControllerWithIdentifier:@"TSFQuestionnaireIntroViewController"];
            
            _mockQuestionnaireService = [KWMock mockForClass:[TSFQuestionnaireService class]];
            _questionnaireIntroViewController.questionnaireService = _mockQuestionnaireService;
            [[_mockQuestionnaireService should] receive:@selector(questionnairesWithSuccess:failure:)];
            
            UIView *view = _questionnaireIntroViewController.view;
            [[view shouldNot] beNil];
        });
        
        it(@"instantiates correctly from the storyboard", ^{
            [[_questionnaireIntroViewController shouldNot] beNil];
            [[_questionnaireIntroViewController should] beKindOfClass:[TSFQuestionnaireIntroViewController class]];
        });
        
        it(@"has an outlet for the scrollview", ^{
            [[_questionnaireIntroViewController.introScrollView shouldNot] beNil];
        });
        
        it(@"has an outlet for the intro label", ^{
            [[_questionnaireIntroViewController.introLabel shouldNot] beNil];
        });
        
        it(@"has an outlet for the subject label", ^{
            [[_questionnaireIntroViewController.subjectLabel shouldNot] beNil];
        });
        
        it(@"has an outlet for the info label", ^{
            [[_questionnaireIntroViewController.infoLabel shouldNot] beNil];
        });
        
        it(@"has an outlet for the time label", ^{
            [[_questionnaireIntroViewController.introScrollView shouldNot] beNil];
        });
        
        it(@"has an outlet for the start button", ^{
            [[_questionnaireIntroViewController.startButton shouldNot] beNil];
        });
        
    });
});

SPEC_END