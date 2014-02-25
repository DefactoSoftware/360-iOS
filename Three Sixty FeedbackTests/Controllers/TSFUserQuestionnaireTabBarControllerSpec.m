//
//  TSFUserQuestionnaireViewControllerSpec.m
//  Three Sixty Feedback
//
//  Created by Girgis Ghattas on 25-02-14.
//  Copyright (c) 2014 Defacto. All rights reserved.
//

#import "Kiwi.h"
#import "TSFUserQuestionnaireTabBarController.h"

SPEC_BEGIN(TSFUserQuestionnaireTabBarControllerSpec)

describe(@"TSFUserQuestionnaireTabBarController", ^{
    __block UIStoryboard *_storyboard;
    __block TSFUserQuestionnaireTabBarController *_userQuestionnaireTabBarController;
    
    beforeEach(^{
        _storyboard = [UIStoryboard storyboardWithName:@"Main_iPhone" bundle:nil];
        _userQuestionnaireTabBarController = [_storyboard instantiateViewControllerWithIdentifier:@"TSFUserQuestionnaireTabBarController"];
        [[[_userQuestionnaireTabBarController view] shouldNot] beNil];
    });
    
    context(@"iPhone", ^{
        it(@"instantiates correctly from the storyboard", ^{
            [[_userQuestionnaireTabBarController shouldNot] beNil];
        });
    });
    
    context(@"iPad", ^{
        __block UIStoryboard *_storyboard;
        
        beforeEach(^{
            _storyboard = [UIStoryboard storyboardWithName:@"Main_iPad" bundle:nil];
            _userQuestionnaireTabBarController = [_storyboard instantiateViewControllerWithIdentifier:@"TSFUserQuestionnaireTabBarController"];
            [[[_userQuestionnaireTabBarController view] shouldNot] beNil];
        });
        
        it(@"instantiates correctly from the storyboard", ^{
            [[_userQuestionnaireTabBarController shouldNot] beNil];
        });
        
        it(@"hides the tabbar", ^{
            [[theValue(_userQuestionnaireTabBarController.tabBar.hidden) should] equal:theValue(YES)];
        });
    });
    
    it(@"sets the info viewcontroller", ^{
        [[_userQuestionnaireTabBarController.infoViewController should] beKindOfClass:[TSFUserQuestionnaireInfoViewController class]];
    });
    
    it(@"sets the assessors viewcontroller", ^{
        [[_userQuestionnaireTabBarController.assessorsViewController should] beKindOfClass:[TSFUserQuestionnaireAssessorsViewController class]];
    });
    
    context(@"passing the questionnaire to the other viewcontrollers", ^{
        __block TSFQuestionnaire *_questionnaire;
        
        beforeEach(^{
            _questionnaire = [[TSFQuestionnaire alloc] init];
            _userQuestionnaireTabBarController.questionnaire = _questionnaire;
            [_userQuestionnaireTabBarController viewDidLoad];
        });
        
        it(@"passes the questionnaire to the info viewcontroller", ^{
            [[_userQuestionnaireTabBarController.infoViewController.questionnaire should] equal:_questionnaire];
        });
        
        it(@"passes the questionnaire to the assessors viewcontroller", ^{
            [[_userQuestionnaireTabBarController.assessorsViewController.questionnaire should] equal:_questionnaire];
        });
    });
});

SPEC_END