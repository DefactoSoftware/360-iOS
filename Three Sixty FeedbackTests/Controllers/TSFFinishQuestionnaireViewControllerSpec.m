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
    
    it(@"calls the assessor service to complete the questionnaire", ^{
        _finishQuestionnaireViewController.assessorService = _mockAssessorService;
        [[_mockAssessorService should] receive:@selector(completeCurrentAssessmentWithSuccess:failure:)];

        [_finishQuestionnaireViewController sendCompletion];
    });
});

SPEC_END