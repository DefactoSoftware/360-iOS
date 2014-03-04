//
//  TSFNewQuestionnaireConfirmViewControllerSpec.m
//  Three Sixty Feedback
//
//  Created by Girgis Ghattas on 04-03-14.
//  Copyright (c) 2014 Defacto. All rights reserved.
//

#import "Kiwi.h"
#import "TSFNewQuestionnaireConfirmViewController.h"

SPEC_BEGIN(TSFNewQuestionnaireConfirmViewControllerSpec)

describe(@"TSFNewQuestionnaireConfirmViewController", ^{
    __block UIStoryboard *_storyboard;
    __block TSFNewQuestionnaireConfirmViewController *_newQuestionnaireConfirmViewController;
    
    beforeEach(^{
        _storyboard = [UIStoryboard storyboardWithName:@"Main_iPhone" bundle:nil];
        _newQuestionnaireConfirmViewController = [_storyboard instantiateViewControllerWithIdentifier:@"TSFNewQuestionnaireConfirmViewController"];
        [[[_newQuestionnaireConfirmViewController view] shouldNot] beNil];
    });
    
    context(@"iPhone", ^{
        it(@"instantiates correctly from the storyboard", ^{
            [[_newQuestionnaireConfirmViewController shouldNot] beNil];
        });
    });
    
    context(@"iPad", ^{
        __block UIStoryboard *_storyboard;
        __block TSFNewQuestionnaireConfirmViewController *_newQuestionnaireConfirmViewController;
        
        beforeEach(^{
            _storyboard = [UIStoryboard storyboardWithName:@"Main_iPad" bundle:nil];
            _newQuestionnaireConfirmViewController = [_storyboard instantiateViewControllerWithIdentifier:@"TSFNewQuestionnaireConfirmViewController"];
            [[[_newQuestionnaireConfirmViewController view] shouldNot] beNil];
        });
        
        it(@"instantiates correctly from the storyboard", ^{
            [[_newQuestionnaireConfirmViewController shouldNot] beNil];
        });
    });
    
});

SPEC_END