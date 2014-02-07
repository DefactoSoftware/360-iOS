//
//  TSFFinishQuestionnaireViewControllerSpec.m
//  Three Sixty Feedback
//
//  Created by Girgis Ghattas on 02-02-14.
//  Copyright (c) 2014 Defacto. All rights reserved.
//

#import "Kiwi.h"
#import "TSFFinishQuestionnaireViewController.h"

SPEC_BEGIN(TSFFinishQuestionnaireViewControllerSpec)

describe(@"TSFFinishQuestionnaireViewController", ^{
    __block UIStoryboard *_storyboard;
    __block TSFFinishQuestionnaireViewController *_finishQuestionnaireViewController;
    __block id _mockAssessorService;
    
    beforeEach (^{
        _storyboard = [UIStoryboard storyboardWithName:@"Main_iPhone" bundle:nil];
        _finishQuestionnaireViewController = [_storyboard instantiateViewControllerWithIdentifier:@"TSFFinishQuestionnaireViewController"];
        
        _mockAssessorService = [KWMock mockForClass:[TSFAssessorService class]];
        
        UIView *view = _finishQuestionnaireViewController.view;
        [[view shouldNot] beNil];
	});
    
    it(@"instantiates correctly from the storyboard", ^{
        [[_finishQuestionnaireViewController shouldNot] beNil];
        [[_finishQuestionnaireViewController should] beKindOfClass:[TSFFinishQuestionnaireViewController class]];
	});
    
    it(@"instantiates a reference to the assessor service", ^{
        [[_finishQuestionnaireViewController.assessorService shouldNot] beNil];
        [[_finishQuestionnaireViewController.assessorService should] beKindOfClass:[TSFAssessorService class]];
    });
    
    it(@"has an outlet for the thank label", ^{
        [[_finishQuestionnaireViewController.thankLabel shouldNot] beNil];
    });

    it(@"has an outlet for the info label", ^{
        [[_finishQuestionnaireViewController.infoLabel shouldNot] beNil];
    });
    
    it(@"has an outlet for the send button", ^{
        [[_finishQuestionnaireViewController.sendButton shouldNot] beNil];
    });
    
    it(@"has an outlet for the previous button", ^{
        [[_finishQuestionnaireViewController.previousButton shouldNot] beNil];
    });
    
    it(@"disables the send button initially", ^{
        [[theValue(_finishQuestionnaireViewController.sendButton.enabled) should] equal:theValue(NO)];
    });
    
    context(@"iPad", ^{
        beforeEach(^{
            _storyboard = [UIStoryboard storyboardWithName:@"Main_iPad" bundle:nil];
            _finishQuestionnaireViewController = [_storyboard instantiateViewControllerWithIdentifier:@"TSFFinishQuestionnaireViewController"];
            
            UIView *view = _finishQuestionnaireViewController.view;
            [[view shouldNot] beNil];
        });
        
        it(@"instantiates correctly from the storyboard", ^{
            [[_finishQuestionnaireViewController shouldNot] beNil];
            [[_finishQuestionnaireViewController should] beKindOfClass:[TSFFinishQuestionnaireViewController class]];
        });
        
        it(@"instantiates a reference to the assessor service", ^{
            [[_finishQuestionnaireViewController.assessorService shouldNot] beNil];
            [[_finishQuestionnaireViewController.assessorService should] beKindOfClass:[TSFAssessorService class]];
        });
        
        it(@"has an outlet for the thank label", ^{
            [[_finishQuestionnaireViewController.thankLabel shouldNot] beNil];
        });
        
        it(@"has an outlet for the info label", ^{
            [[_finishQuestionnaireViewController.infoLabel shouldNot] beNil];
        });
        
        it(@"has an outlet for the send button", ^{
            [[_finishQuestionnaireViewController.sendButton shouldNot] beNil];
        });
        
        it(@"has an outlet for the previous button", ^{
            [[_finishQuestionnaireViewController.previousButton shouldNot] beNil];
        });
    });
    
    context(@"pressing the send button", ^{
        __block id _mockQuestionnaireViewController;
        
        beforeEach(^{
            _mockQuestionnaireViewController = [KWMock mockForClass:[TSFQuestionnaireViewController class]];
            _finishQuestionnaireViewController.questionnaireViewController = _mockQuestionnaireViewController;
        });
        
        it(@"calls the questionnaire viewcontroller when the user presses the send button", ^{
            [[_mockQuestionnaireViewController should] receive:@selector(completeQuestionnaireWithCompletion:)];
            
            [_finishQuestionnaireViewController sendButtonPressed:nil];
        });
    });
});

SPEC_END