//
//  TSFUserQuestionnaireAssessorsViewControllerSpec.m
//  Three Sixty Feedback
//
//  Created by Girgis Ghattas on 25-02-14.
//  Copyright (c) 2014 Defacto. All rights reserved.
//

#import "Kiwi.h"
#import "TSFUserQuestionnaireAssessorsViewController.h"
#import "TSFUserQuestionnaireViewController.h"

SPEC_BEGIN(TSFUserQuestionnaireAssessorViewControllerSpec)

describe(@"TSFUserQuestionnaireAssessorsViewController", ^{
    __block UIStoryboard *_storyboard;
    __block TSFUserQuestionnaireViewController *_userQuestionnaireViewController;
    __block TSFUserQuestionnaireAssessorsViewController *_userQuestionnaireAssessorsViewController;
    
    beforeEach(^{
        _storyboard = [UIStoryboard storyboardWithName:@"Main_iPhone" bundle:nil];
        _userQuestionnaireViewController = [_storyboard instantiateViewControllerWithIdentifier:@"TSFUserQuestionnaireViewController"];
        _userQuestionnaireAssessorsViewController = [_userQuestionnaireViewController.viewControllers lastObject];
        [[[_userQuestionnaireViewController view] shouldNot] beNil];
        [[[_userQuestionnaireAssessorsViewController view] shouldNot] beNil];
    });
    
    context(@"iPhone", ^{
        it(@"has an outlet for the assessors tableview", ^{
            [[_userQuestionnaireAssessorsViewController.assessorsTableView shouldNot] beNil];
        });
    });
    
    context(@"iPad", ^{
        __block UIStoryboard *_storyboard;
        __block TSFUserQuestionnaireViewController *_userQuestionnaireViewController;
        __block TSFUserQuestionnaireAssessorsViewController *_userQuestionnaireAssessorsViewController;
        
        beforeEach(^{
            _storyboard = [UIStoryboard storyboardWithName:@"Main_iPad" bundle:nil];
            _userQuestionnaireViewController = [_storyboard instantiateViewControllerWithIdentifier:@"TSFUserQuestionnaireViewController"];
            _userQuestionnaireAssessorsViewController = [_userQuestionnaireViewController.viewControllers lastObject];
            [[[_userQuestionnaireViewController view] shouldNot] beNil];
            [[[_userQuestionnaireAssessorsViewController view] shouldNot] beNil];
        });
        
        it(@"instantiates correctly from the storyboard", ^{
            [[[_userQuestionnaireViewController.viewControllers lastObject] shouldNot] beNil];
            [[[_userQuestionnaireViewController.viewControllers lastObject] should] beKindOfClass:[TSFUserQuestionnaireAssessorsViewController class]];
        });
        
        it(@"has an outlet for the title label", ^{
            [[_userQuestionnaireAssessorsViewController.assessorsTableView shouldNot] beNil];
        });
    });
});

SPEC_END