//
//  TSFQuestionnairesViewControllerSpec.m
//  Three Sixty Feedback
//
//  Created by Girgis Ghattas on 21-02-14.
//  Copyright (c) 2014 Defacto. All rights reserved.
//

#import "Kiwi.h"
#import "TSFQuestionnairesTabBarController.h"

SPEC_BEGIN(TFQuestionnairesViewControllerSpec)

describe(@"TSFQuestionnairesViewController", ^{
    __block UIStoryboard *_storyboard;
    __block TSFQuestionnairesTabBarController *_questionnairesViewController;
    
    beforeEach(^{
        _storyboard = [UIStoryboard storyboardWithName:@"Main_iPhone" bundle:nil];
        _questionnairesViewController = [_storyboard instantiateViewControllerWithIdentifier:@"TSFQuestionnairesTabBarController"];
        [[[_questionnairesViewController view] shouldNot] beNil];
    });
    
    context(@"iPhone", ^{
        it(@"instantiates correctly from the storyboard", ^{
            [[_questionnairesViewController shouldNot] beNil];
        });
        
        it(@"has an outlet for the tab bar", ^{
            [[_questionnairesViewController.tabBar shouldNot] beNil];
        });
    });
    
    context(@"iPad", ^{
        __block UIStoryboard *_storyboard;
        __block TSFQuestionnairesTabBarController *_questionnairesViewController;
        
        beforeEach(^{
            _storyboard = [UIStoryboard storyboardWithName:@"Main_iPad" bundle:nil];
            _questionnairesViewController = [_storyboard instantiateViewControllerWithIdentifier:@"TSFQuestionnairesTabBarController"];
            [[[_questionnairesViewController view] shouldNot] beNil];
        });
        
        it(@"instantiates correctly from the storyboard", ^{
            [[_questionnairesViewController shouldNot] beNil];
        });
        
        it(@"has an outlet for the tab bar", ^{
            [[_questionnairesViewController.tabBar shouldNot] beNil];
        });
    });
});

SPEC_END