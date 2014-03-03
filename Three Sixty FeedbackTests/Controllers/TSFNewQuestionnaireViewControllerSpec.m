//
//  TSFNewQuestionnaireViewControllerSpec.m
//  Three Sixty Feedback
//
//  Created by Girgis Ghattas on 03-03-14.
//  Copyright (c) 2014 Defacto. All rights reserved.
//

#import "Kiwi.h"
#import "TSFNewQuestionnaireViewController.h"

SPEC_BEGIN(TSFNewQuestionnaireViewControllerSpec)

describe(@"TSFNewQuestionnaireViewController", ^{
    __block UIStoryboard *_storyboard;
    __block TSFNewQuestionnaireViewController *_newQuestionnaireViewController;
    
    beforeEach(^{
        _storyboard = [UIStoryboard storyboardWithName:@"Main_iPhone" bundle:nil];
        _newQuestionnaireViewController = [_storyboard instantiateViewControllerWithIdentifier:@"TSFNewQuestionnaireViewController"];
        [[[_newQuestionnaireViewController view] shouldNot] beNil];
    });
    
    context(@"iPhone", ^{
        it(@"instantiates correctly from the storyboard", ^{
            [[_newQuestionnaireViewController shouldNot] beNil];
        });
    });
    
    context(@"iPad", ^{
        __block UIStoryboard *_storyboard;
        __block TSFNewQuestionnaireViewController *_newQuestionnaireViewController;
        
        beforeEach(^{
            _storyboard = [UIStoryboard storyboardWithName:@"Main_iPad" bundle:nil];
            _newQuestionnaireViewController = [_storyboard instantiateViewControllerWithIdentifier:@"TSFNewQuestionnaireViewController"];
            [[[_newQuestionnaireViewController view] shouldNot] beNil];
        });
        
        it(@"instantiates correctly from the storyboard", ^{
            [[_newQuestionnaireViewController shouldNot] beNil];
        });
    });
    
    it(@"has a pageviewcontroller", ^{
        [[_newQuestionnaireViewController.pageViewController shouldNot] beNil];
    });

    it(@"instantiates an array of viewcontroller", ^{
        [[_newQuestionnaireViewController.viewControllers shouldNot] beNil];
    });
    
    it(@"instantiates the subject viewcontroller first", ^{
        [[[_newQuestionnaireViewController.viewControllers firstObject] should] beKindOfClass:[TSFNewQuestionnaireSubjectViewController class]];
    });
});

SPEC_END