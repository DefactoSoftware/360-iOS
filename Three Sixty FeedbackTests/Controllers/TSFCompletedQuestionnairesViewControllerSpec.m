//
//  TSFFinishedQuestionnairesViewControllerSpec.m
//  Three Sixty Feedback
//
//  Created by Girgis Ghattas on 25-02-14.
//  Copyright (c) 2014 Defacto. All rights reserved.
//

#import "Kiwi.h"
#import "TSFCompletedQuestionnairesViewController.h"

SPEC_BEGIN(TSFCompletedQuestionnairesViewControllerSpec)

describe(@"TSFCompletedQuestionnairesViewController", ^{
    __block UIStoryboard *_storyboard;
    __block TSFCompletedQuestionnairesViewController *_completedQuestionnairesViewController;
    
    beforeEach(^{
        _storyboard = [UIStoryboard storyboardWithName:@"Main_iPhone" bundle:nil];
        _completedQuestionnairesViewController = [_storyboard instantiateViewControllerWithIdentifier:@"TSFCompletedQuestionnairesViewController"];
        [[[_completedQuestionnairesViewController view] shouldNot] beNil];
    });
    
    context(@"iPhone", ^{
        it(@"instantiates correctly from the storyboard", ^{
            [[_completedQuestionnairesViewController shouldNot] beNil];
        });
        
        it(@"has a questionnaire tableview", ^{
            [[_completedQuestionnairesViewController.questionnairesTableView shouldNot] beNil];
        });
    });
    
    context(@"iPad", ^{
        __block UIStoryboard *_storyboard;
        __block TSFCompletedQuestionnairesViewController *_completedQuestionnairesViewController;
        
        beforeEach(^{
            _storyboard = [UIStoryboard storyboardWithName:@"Main_iPad" bundle:nil];
            _completedQuestionnairesViewController = [_storyboard instantiateViewControllerWithIdentifier:@"TSFCompletedQuestionnairesViewController"];
            [[[_completedQuestionnairesViewController view] shouldNot] beNil];
        });
        
        it(@"instantiates correctly from the storyboard", ^{
            [[_completedQuestionnairesViewController shouldNot] beNil];
        });
        
        it(@"has a questionnaire tableview", ^{
            [[_completedQuestionnairesViewController.questionnairesTableView shouldNot] beNil];
        });
    });
});

SPEC_END