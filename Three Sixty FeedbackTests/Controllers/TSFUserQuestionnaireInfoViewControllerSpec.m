//
//  TSFUserQuestionnaireInfoViewControllerSpec.m
//  Three Sixty Feedback
//
//  Created by Girgis Ghattas on 25-02-14.
//  Copyright (c) 2014 Defacto. All rights reserved.
//

#import "Kiwi.h"
#import "TSFUserQuestionnaireInfoViewController.h"
#import "TSFUserQuestionnaireViewController.h"

SPEC_BEGIN(TSFUserQuestionnaireInfoViewControllerSpec)

describe(@"TSFUserQuestionnaireInfoViewController", ^{
    __block UIStoryboard *_storyboard;
    __block TSFUserQuestionnaireViewController *_userQuestionnaireViewController;
    
    beforeEach(^{
        _storyboard = [UIStoryboard storyboardWithName:@"Main_iPhone" bundle:nil];
        _userQuestionnaireViewController = [_storyboard instantiateViewControllerWithIdentifier:@"TSFUserQuestionnaireViewController"];
        [[[_userQuestionnaireViewController view] shouldNot] beNil];
    });
    
    context(@"iPhone", ^{
        it(@"instantiates correctly from the storyboard", ^{
            [[[_userQuestionnaireViewController.viewControllers firstObject] shouldNot] beNil];
            [[[_userQuestionnaireViewController.viewControllers firstObject] should] beKindOfClass:[TSFUserQuestionnaireInfoViewController class]];
        });
    });
    
    context(@"iPad", ^{
        __block UIStoryboard *_storyboard;
        __block TSFUserQuestionnaireViewController *_userQuestionnaireViewController;
        
        beforeEach(^{
            _storyboard = [UIStoryboard storyboardWithName:@"Main_iPad" bundle:nil];
            _userQuestionnaireViewController = [_storyboard instantiateViewControllerWithIdentifier:@"TSFUserQuestionnaireViewController"];
            [[[_userQuestionnaireViewController view] shouldNot] beNil];
        });
        
        it(@"instantiates correctly from the storyboard", ^{
            [[[_userQuestionnaireViewController.viewControllers firstObject] shouldNot] beNil];
            [[[_userQuestionnaireViewController.viewControllers firstObject] should] beKindOfClass:[TSFUserQuestionnaireInfoViewController class]];
        });
    });
});

SPEC_END