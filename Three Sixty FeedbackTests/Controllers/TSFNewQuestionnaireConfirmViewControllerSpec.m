//
//  TSFNewQuestionnaireConfirmViewControllerSpec.m
//  Three Sixty Feedback
//
//  Created by Girgis Ghattas on 04-03-14.
//  Copyright (c) 2014 Defacto. All rights reserved.
//

#import "Kiwi.h"
#import "TSFNewQuestionnaireConfirmViewController.h"

SPEC_BEGIN(TSFNewQuestionnaireConfirmViewControllerSpec)

describe(@"TSFNewQuestionnaireConfirmViewController", ^{
    __block UIStoryboard *_storyboard;
    __block TSFNewQuestionnaireConfirmViewController *_newQuestionnaireConfirmViewController;
    
    beforeEach(^{
        _storyboard = [UIStoryboard storyboardWithName:@"Main_iPhone" bundle:nil];
        _newQuestionnaireConfirmViewController = [_storyboard instantiateViewControllerWithIdentifier:@"TSFNewQuestionnaireConfirmViewController"];
        [[[_newQuestionnaireConfirmViewController view] shouldNot] beNil];
    });
    
    context(@"iPhone", ^{
        it(@"instantiates correctly from the storyboard", ^{
            [[_newQuestionnaireConfirmViewController shouldNot] beNil];
        });
        
        it(@"has an outlet for the subject title label", ^{
            [[_newQuestionnaireConfirmViewController.subjectLabel shouldNot] beNil];
        });
        
        it(@"has an outlet for the subject label", ^{
            [[_newQuestionnaireConfirmViewController.templateLabel shouldNot] beNil];
        });
        
        it(@"has an outlet for the assessors label", ^{
            [[_newQuestionnaireConfirmViewController.assessorsLabel shouldNot] beNil];
        });
        
        it(@"has an outlet for the create button", ^{
            [[_newQuestionnaireConfirmViewController.createButton shouldNot] beNil];
        });
    });
    
    context(@"iPad", ^{
        __block UIStoryboard *_storyboard;
        __block TSFNewQuestionnaireConfirmViewController *_newQuestionnaireConfirmViewController;
        
        beforeEach(^{
            _storyboard = [UIStoryboard storyboardWithName:@"Main_iPad" bundle:nil];
            _newQuestionnaireConfirmViewController = [_storyboard instantiateViewControllerWithIdentifier:@"TSFNewQuestionnaireConfirmViewController"];
            [[[_newQuestionnaireConfirmViewController view] shouldNot] beNil];
        });
        
        it(@"instantiates correctly from the storyboard", ^{
            [[_newQuestionnaireConfirmViewController shouldNot] beNil];
        });
        
        it(@"has an outlet for the subject title label", ^{
            [[_newQuestionnaireConfirmViewController.subjectLabel shouldNot] beNil];
        });
        
        it(@"has an outlet for the subject label", ^{
            [[_newQuestionnaireConfirmViewController.templateLabel shouldNot] beNil];
        });
        
        it(@"has an outlet for the assessors label", ^{
            [[_newQuestionnaireConfirmViewController.assessorsLabel shouldNot] beNil];
        });
        
        it(@"has an outlet for the create button", ^{
            [[_newQuestionnaireConfirmViewController.createButton shouldNot] beNil];
        });
    });
    
    it(@"has a reference to the questionnaireservice", ^{
        [[_newQuestionnaireConfirmViewController.questionnaireService should] beKindOfClass:[TSFQuestionnaireService class]];
    });
    
    it(@"has a reference to the assessorsservice", ^{
        [[_newQuestionnaireConfirmViewController.assessorService should] beKindOfClass:[TSFAssessorService class]];
    });
});

SPEC_END