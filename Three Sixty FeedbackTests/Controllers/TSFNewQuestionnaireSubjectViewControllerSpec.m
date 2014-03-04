//
//  TSFNewQuestionnaireSubjectViewControllerSpec.m
//  Three Sixty Feedback
//
//  Created by Girgis Ghattas on 03-03-14.
//  Copyright (c) 2014 Defacto. All rights reserved.
//

#import "Kiwi.h"
#import "TSFNewQuestionnaireSubjectViewController.h"

SPEC_BEGIN(TSFNewQuestionnaireSubjectViewControllerSpec)

describe(@"TSFNewQuestionnaireSubjectViewController", ^{
    __block UIStoryboard *_storyboard;
    __block TSFNewQuestionnaireSubjectViewController *_newQuestionnaireSubjectViewController;
    
    beforeEach(^{
        _storyboard = [UIStoryboard storyboardWithName:@"Main_iPhone" bundle:nil];
        _newQuestionnaireSubjectViewController = [_storyboard instantiateViewControllerWithIdentifier:@"TSFNewQuestionnaireSubjectViewController"];
        [[[_newQuestionnaireSubjectViewController view] shouldNot] beNil];
    });
    
    context(@"iPhone", ^{
        it(@"instantiates correctly from the storyboard", ^{
            [[_newQuestionnaireSubjectViewController shouldNot] beNil];
        });
        
        it(@"has an outlet for the subject label", ^{
            [[_newQuestionnaireSubjectViewController.subjectLabel shouldNot] beNil];
        });
        
        it(@"has an outlet for the subject textfield", ^{
            [[_newQuestionnaireSubjectViewController.subjectTextField shouldNot] beNil];
        });
    });
    
    context(@"iPad", ^{
        __block UIStoryboard *_storyboard;
        __block TSFNewQuestionnaireSubjectViewController *_newQuestionnaireSubjectViewController;
        
        beforeEach(^{
            _storyboard = [UIStoryboard storyboardWithName:@"Main_iPad" bundle:nil];
            _newQuestionnaireSubjectViewController = [_storyboard instantiateViewControllerWithIdentifier:@"TSFNewQuestionnaireSubjectViewController"];
            [[[_newQuestionnaireSubjectViewController view] shouldNot] beNil];
        });
        
        it(@"instantiates correctly from the storyboard", ^{
            [[_newQuestionnaireSubjectViewController shouldNot] beNil];
        });
        
        it(@"has an outlet for the subject label", ^{
            [[_newQuestionnaireSubjectViewController.subjectLabel shouldNot] beNil];
        });
        
        it(@"has an outlet for the subject textfield", ^{
            [[_newQuestionnaireSubjectViewController.subjectTextField shouldNot] beNil];
        });
    });
    
    context(@"validating the input", ^{
        it(@"is valid with a subject", ^{
            _newQuestionnaireSubjectViewController.subjectTextField.text = [NSString stringWithFormat:@"%d", arc4random()];
            [[theValue([_newQuestionnaireSubjectViewController validate]) should] equal:theValue(YES)];
        });
        
        it(@"is not valid without a subject", ^{
            [[theValue([_newQuestionnaireSubjectViewController validate]) should] equal:theValue(NO)];
        });
    });
});

SPEC_END