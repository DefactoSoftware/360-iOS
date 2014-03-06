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
        it(@"has an outlet for the subject label", ^{
            [[_userQuestionnaireInfoViewController.subjectLabel shouldNot] beNil];
        });
        
        it(@"has an outlet for the description label", ^{
            [[_userQuestionnaireInfoViewController.descriptionLabel shouldNot] beNil];
        });
        
        it(@"has an outlet for the subject title label", ^{
            [[_userQuestionnaireInfoViewController.subjectTitleLabel shouldNot] beNil];
        });
    });
    
    context(@"iPad", ^{
        __block UIStoryboard *_storyboard;
        __block TSFUserQuestionnaireInfoViewController *_userQuestionnaireInfoViewController;
        
        beforeEach(^{
            _storyboard = [UIStoryboard storyboardWithName:@"Main_iPad" bundle:nil];
            _userQuestionnaireInfoViewController = [_storyboard instantiateViewControllerWithIdentifier:@"TSFUserQuestionnaireInfoViewController"];
            [[[_userQuestionnaireInfoViewController view] shouldNot] beNil];
        });
        
        it(@"instantiates correctly from the storyboard", ^{
            [[_userQuestionnaireInfoViewController should] beKindOfClass:[TSFUserQuestionnaireInfoViewController class]];
        });
        
        it(@"has an outlet for the subject label", ^{
            [[_userQuestionnaireInfoViewController.subjectLabel shouldNot] beNil];
        });
        
        it(@"has an outlet for the description label", ^{
            [[_userQuestionnaireInfoViewController.descriptionLabel shouldNot] beNil];
        });
        
        it(@"has an outlet for the assessors label", ^{
            [[_userQuestionnaireInfoViewController.assessorsLabel shouldNot] beNil];
        });
        
        it(@"has an outlet for the remind assessors button", ^{
            [[_userQuestionnaireInfoViewController.remindAssessorsButton shouldNot] beNil];
        });
        
        it(@"has an outlet for the subject title label", ^{
            [[_userQuestionnaireInfoViewController.subjectTitleLabel shouldNot] beNil];
        });
        
        it(@"has an assessors viewcontroller", ^{
            [_userQuestionnaireInfoViewController displayAssessorsViewController];
            [[_userQuestionnaireInfoViewController.assessorsViewController should] beKindOfClass:[TSFUserQuestionnaireAssessorsViewController class]];
        });
        
        it(@"passes the questionnaire to the assessors viewcontroller", ^{
            TSFQuestionnaire *stubQuestionnaire = [[TSFQuestionnaire alloc] init];
            _userQuestionnaireInfoViewController.questionnaire = stubQuestionnaire;
            [_userQuestionnaireInfoViewController displayAssessorsViewController];
            [[_userQuestionnaireInfoViewController.assessorsViewController.questionnaire should] equal:_userQuestionnaireInfoViewController.questionnaire];
        });
        
        it(@"has an assessors view", ^{
            [[_userQuestionnaireInfoViewController.assessorsView shouldNot] beNil];
        });
        
        it(@"loads the assessors viewcontroller's view in the assessors view", ^{
            [_userQuestionnaireInfoViewController displayAssessorsViewController];
            [[_userQuestionnaireInfoViewController.assessorsView.subviews[0] should] equal:_userQuestionnaireInfoViewController.assessorsViewController.view];
        });
    });
    
    it(@"calls the assessors viewcontroller to remind the assessors", ^{
        id mockAssessorsViewController = [KWMock mockForClass:[TSFUserQuestionnaireAssessorsViewController class]];
        _userQuestionnaireInfoViewController.assessorsViewController = mockAssessorsViewController;
        
        [[mockAssessorsViewController should] receive:@selector(remindAssessors)];
        [_userQuestionnaireInfoViewController remindButtonPressed:nil];
    });
});

SPEC_END