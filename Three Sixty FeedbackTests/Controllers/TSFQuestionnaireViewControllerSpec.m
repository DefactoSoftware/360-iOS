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
});

SPEC_END
