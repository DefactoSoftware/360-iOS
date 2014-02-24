//
//  TSFActiveQuestionnairesViewControllerSpec.m
//  Three Sixty Feedback
//
//  Created by Girgis Ghattas on 21-02-14.
//  Copyright (c) 2014 Defacto. All rights reserved.
//

#import "Kiwi.h"
#import "TSFActiveQuestionnairesViewController.h"

SPEC_BEGIN(TSFActiveQuestionnairesViewControllerSpec)

describe(@"TSFActiveQuestionnairesViewcontroller", ^{
    __block UIStoryboard *_storyboard;
    __block TSFActiveQuestionnairesViewController *_activeQuestionnairesViewController;
    
    beforeEach(^{
        _storyboard = [UIStoryboard storyboardWithName:@"Main_iPhone" bundle:nil];
        _activeQuestionnairesViewController = [_storyboard instantiateViewControllerWithIdentifier:@"TSFActiveQuestionnairesViewController"];
        [[[_activeQuestionnairesViewController view] shouldNot] beNil];
    });
    
    context(@"iPhone", ^{
        it(@"instantiates correctly from the storyboard", ^{
            [[_activeQuestionnairesViewController shouldNot] beNil];
        });
    });
    
    context(@"iPad", ^{
        __block UIStoryboard *_storyboard;
        __block TSFActiveQuestionnairesViewController *_activeQuestionnairesViewController;
        
        beforeEach(^{
            _storyboard = [UIStoryboard storyboardWithName:@"Main_iPad" bundle:nil];
            _activeQuestionnairesViewController = [_storyboard instantiateViewControllerWithIdentifier:@"TSFActiveQuestionnairesViewController"];
            [[[_activeQuestionnairesViewController view] shouldNot] beNil];
        });
        
        it(@"instantiates correctly from the storyboard", ^{
            [[_activeQuestionnairesViewController shouldNot] beNil];
        });
    });
});

SPEC_END