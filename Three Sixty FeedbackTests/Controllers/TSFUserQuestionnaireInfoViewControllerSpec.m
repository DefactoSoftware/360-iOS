//
//  TSFUserQuestionnaireInfoViewControllerSpec.m
//  Three Sixty Feedback
//
//  Created by Girgis Ghattas on 25-02-14.
//  Copyright (c) 2014 Defacto. All rights reserved.
//

#import "Kiwi.h"
#import "TSFUserQuestionnaireInfoViewController.h"
#import "TSFUserQuestionnaireTabBarController.h"

SPEC_BEGIN(TSFUserQuestionnaireInfoViewControllerSpec)

describe(@"TSFUserQuestionnaireInfoViewController", ^{
    __block UIStoryboard *_storyboard;
    __block TSFUserQuestionnaireTabBarController *_userQuestionnaireViewController;
    __block TSFUserQuestionnaireInfoViewController *_userQuestionnaireInfoViewController;
    
    beforeEach(^{
        _storyboard = [UIStoryboard storyboardWithName:@"Main_iPhone" bundle:nil];
        _userQuestionnaireViewController = [_storyboard instantiateViewControllerWithIdentifier:@"TSFUserQuestionnaireTabBarController"];
        _userQuestionnaireInfoViewController = [_userQuestionnaireViewController.viewControllers firstObject];
        [[[_userQuestionnaireViewController view] shouldNot] beNil];
        [[[_userQuestionnaireInfoViewController view] shouldNot] beNil];
    });
    
    context(@"iPhone", ^{
        it(@"has an outlet for the title label", ^{
            [[_userQuestionnaireInfoViewController.titleLabel shouldNot] beNil];
        });
        
        it(@"has an outlet for the subject label", ^{
            [[_userQuestionnaireInfoViewController.subjectLabel shouldNot] beNil];
        });
        
        it(@"has an outlet for the description label", ^{
            [[_userQuestionnaireInfoViewController.descriptionLabel shouldNot] beNil];
        });
    });
    
    context(@"iPad", ^{
        __block UIStoryboard *_storyboard;
        __block TSFUserQuestionnaireTabBarController *_userQuestionnaireViewController;
        __block TSFUserQuestionnaireInfoViewController *_userQuestionnaireInfoViewController;
        
        beforeEach(^{
            _storyboard = [UIStoryboard storyboardWithName:@"Main_iPad" bundle:nil];
            _userQuestionnaireViewController = [_storyboard instantiateViewControllerWithIdentifier:@"TSFUserQuestionnaireTabBarController"];
            _userQuestionnaireInfoViewController = [_userQuestionnaireViewController.viewControllers firstObject];
            [[[_userQuestionnaireViewController view] shouldNot] beNil];
            [[[_userQuestionnaireInfoViewController view] shouldNot] beNil];
        });
        
        it(@"instantiates correctly from the storyboard", ^{
            [[[_userQuestionnaireViewController.viewControllers firstObject] shouldNot] beNil];
            [[[_userQuestionnaireViewController.viewControllers firstObject] should] beKindOfClass:[TSFUserQuestionnaireInfoViewController class]];
        });
        
        it(@"has an outlet for the title label", ^{
            [[_userQuestionnaireInfoViewController.titleLabel shouldNot] beNil];
        });
        
        it(@"has an outlet for the subject label", ^{
            [[_userQuestionnaireInfoViewController.subjectLabel shouldNot] beNil];
        });
        
        it(@"has an outlet for the description label", ^{
            [[_userQuestionnaireInfoViewController.descriptionLabel shouldNot] beNil];
        });
        
        it(@"has an outlet for the assessors button", ^{
            [[_userQuestionnaireInfoViewController.assessorsButton shouldNot] beNil];
        });
    });
});

SPEC_END