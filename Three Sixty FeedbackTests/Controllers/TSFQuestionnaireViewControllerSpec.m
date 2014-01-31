//
//  TSFQuestionnaireViewControllerSpec.m
//  Three Sixty Feedback
//
//  Created by Girgis on 30/01/14.
//  Copyright (c) 2014 Defacto. All rights reserved.
//

#import "Kiwi.h"
#import "TSFQuestionnaireViewController.h"

SPEC_BEGIN(TSFQuestionnaireViewControllerSpec)

describe(@"TSFQuestionnaireViewController", ^{
    __block TSFQuestionnaireViewController *_questionnaireViewController;
    
    beforeEach ( ^{
        UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"Main_iPhone" bundle:nil];
        _questionnaireViewController = [storyboard instantiateViewControllerWithIdentifier:@"TSFQuestionnaireViewController"];
        
        UIView *view = _questionnaireViewController.view;
        [[view shouldNot] beNil];
	});
    
    it(@"instantiates correctly from the storyboard", ^{
        [[_questionnaireViewController shouldNot] beNil];
        [[_questionnaireViewController should] beKindOfClass:[TSFQuestionnaireViewController class]];
	});
    
    it(@"instantiates a questionnaire service", ^{
        [[_questionnaireViewController.questionnaireService shouldNot] beNil];
        [[_questionnaireViewController.questionnaireService should] beKindOfClass:[TSFQuestionnaireService class]];
	});
    
    it(@"has a navigationbar button for the next key behaviour", ^{
        [[_questionnaireViewController.nextKeyBehaviourButton shouldNot] beNil];
    });
    
    it(@"has a navigationbar button for the previous key behaviour", ^{
        [[_questionnaireViewController.previousKeyBehaviourButton shouldNot] beNil];
    });
    
    it(@"calls the questionnaire service for the questionnaire", ^{
        id mockQuestionnaireService = [KWMock mockForClass:[TSFQuestionnaireService class]];
        _questionnaireViewController.questionnaireService = mockQuestionnaireService;
        
        [[mockQuestionnaireService should] receive:@selector(questionnairesWithSuccess:failure:)];
        
        [_questionnaireViewController loadQuestionnaire];
	});
});

SPEC_END
