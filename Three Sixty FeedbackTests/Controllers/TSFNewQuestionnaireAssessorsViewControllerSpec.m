//
//  TSFNewQuestionnaireAssessorsViewControllerSpec.m
//  Three Sixty Feedback
//
//  Created by Girgis Ghattas on 04-03-14.
//  Copyright (c) 2014 Defacto. All rights reserved.
//

#import "Kiwi.h"
#import "TSFNewQuestionnaireAssessorsViewController.h"

SPEC_BEGIN(TSFNewQuestionnaireAssessorsViewControllerSpec)

describe(@"TSFNewQuestionnaireAssessorsViewController", ^{
    __block UIStoryboard *_storyboard;
    __block TSFNewQuestionnaireAssessorsViewController *_newQuestionnaireAssessorsViewController;
    
    beforeEach(^{
        _storyboard = [UIStoryboard storyboardWithName:@"Main_iPhone" bundle:nil];
        _newQuestionnaireAssessorsViewController = [_storyboard instantiateViewControllerWithIdentifier:@"TSFNewQuestionnaireAssessorsViewController"];
        [[[_newQuestionnaireAssessorsViewController view] shouldNot] beNil];
    });
    
    context(@"iPhone", ^{
        it(@"instantiates correctly from the storyboard", ^{
            [[_newQuestionnaireAssessorsViewController shouldNot] beNil];
        });
        
        it(@"has an outlet for the templates tableview", ^{
            [[_newQuestionnaireAssessorsViewController.assessorsTableView shouldNot] beNil];
        });
        
        it(@"has an outlet for the new assessors title label", ^{
            [[_newQuestionnaireAssessorsViewController.addAssessorTitleLabel shouldNot] beNil];
        });
        
        it(@"has an outlet for the new assessors textfield", ^{
            [[_newQuestionnaireAssessorsViewController.addAssessorTextField shouldNot] beNil];
        });
        
        it(@"has an outlet for the add button", ^{
            [[_newQuestionnaireAssessorsViewController.addButton shouldNot] beNil];
        });
        
        it(@"has an outlet for the header view", ^{
            [[_newQuestionnaireAssessorsViewController.headerView shouldNot] beNil];
        });
        
        it(@"has an outlet for the next button", ^{
            [[_newQuestionnaireAssessorsViewController.nextButton shouldNot] beNil];
        });
    });
    
    context(@"iPad", ^{
        __block UIStoryboard *_storyboard;
        __block TSFNewQuestionnaireAssessorsViewController *_newQuestionnaireAssessorsViewController;
        
        beforeEach(^{
            _storyboard = [UIStoryboard storyboardWithName:@"Main_iPad" bundle:nil];
            _newQuestionnaireAssessorsViewController = [_storyboard instantiateViewControllerWithIdentifier:@"TSFNewQuestionnaireAssessorsViewController"];
            [[[_newQuestionnaireAssessorsViewController view] shouldNot] beNil];
        });
        
        it(@"instantiates correctly from the storyboard", ^{
            [[_newQuestionnaireAssessorsViewController shouldNot] beNil];
        });
        
        it(@"has an outlet for the templates tableview", ^{
            [[_newQuestionnaireAssessorsViewController.assessorsTableView shouldNot] beNil];
        });
        
        it(@"has an outlet for the new assessors title label", ^{
            [[_newQuestionnaireAssessorsViewController.addAssessorTitleLabel shouldNot] beNil];
        });
        
        it(@"has an outlet for the new assessors textfield", ^{
            [[_newQuestionnaireAssessorsViewController.addAssessorTextField shouldNot] beNil];
        });
        
        it(@"has an outlet for the add button", ^{
            [[_newQuestionnaireAssessorsViewController.addButton shouldNot] beNil];
        });
        
        it(@"has an outlet for the header view", ^{
            [[_newQuestionnaireAssessorsViewController.headerView shouldNot] beNil];
        });
        
        it(@"has an outlet for the next button", ^{
            [[_newQuestionnaireAssessorsViewController.nextButton shouldNot] beNil];
        });
    });
});

SPEC_END
    