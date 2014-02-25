//
//  TSFUserQuestionnaireViewControllerSpec.m
//  Three Sixty Feedback
//
//  Created by Girgis Ghattas on 25-02-14.
//  Copyright (c) 2014 Defacto. All rights reserved.
//

#import "Kiwi.h"
#import "TSFUserQuestionnaireViewController.h"

SPEC_BEGIN(TSFUserQuestionnaireViewControllerSpec)

describe(@"TSFCompletedQuestionnairesViewController", ^{
    __block UIStoryboard *_storyboard;
    __block TSFUserQuestionnaireViewController *_userQuestionnaireViewController;
    
    beforeEach(^{
        _storyboard = [UIStoryboard storyboardWithName:@"Main_iPhone" bundle:nil];
        _userQuestionnaireViewController = [_storyboard instantiateViewControllerWithIdentifier:@"TSFUserQuestionnaireViewController"];
        [[[_userQuestionnaireViewController view] shouldNot] beNil];
    });
    
    context(@"iPhone", ^{
        it(@"instantiates correctly from the storyboard", ^{
            [[_userQuestionnaireViewController shouldNot] beNil];
        });
        
        it(@"has an assessors tableview", ^{
            [[_userQuestionnaireViewController.assessorsTableView shouldNot] beNil];
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
            [[_userQuestionnaireViewController shouldNot] beNil];
        });
        
        it(@"has an assessors tableview", ^{
            [[_userQuestionnaireViewController.assessorsTableView shouldNot] beNil];
        });
    });
});

SPEC_END