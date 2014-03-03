//
//  TSFNewQuestionnaireTemplateViewController.m
//  Three Sixty Feedback
//
//  Created by Girgis Ghattas on 03-03-14.
//  Copyright (c) 2014 Defacto. All rights reserved.
//

#import "Kiwi.h"
#import "TSFNewQuestionnaireTemplateViewController.h"

SPEC_BEGIN(TSFNewQuestionnaireTemplateViewControllerSpec)

describe(@"TSFNewQuestionnaireTemplateViewController", ^{
    __block UIStoryboard *_storyboard;
    __block TSFNewQuestionnaireTemplateViewController *_newQuestionnaireTemplateViewController;
    
    beforeEach(^{
        _storyboard = [UIStoryboard storyboardWithName:@"Main_iPhone" bundle:nil];
        _newQuestionnaireTemplateViewController = [_storyboard instantiateViewControllerWithIdentifier:@"TSFNewQuestionnaireTemplateViewController"];
        [[[_newQuestionnaireTemplateViewController view] shouldNot] beNil];
    });
    
    context(@"iPhone", ^{
        it(@"instantiates correctly from the storyboard", ^{
            [[_newQuestionnaireTemplateViewController shouldNot] beNil];
        });
    });
    
    context(@"iPad", ^{
        __block UIStoryboard *_storyboard;
        __block TSFNewQuestionnaireTemplateViewController *_newQuestionnaireTemplateViewController;
        
        beforeEach(^{
            _storyboard = [UIStoryboard storyboardWithName:@"Main_iPad" bundle:nil];
            _newQuestionnaireTemplateViewController = [_storyboard instantiateViewControllerWithIdentifier:@"TSFNewQuestionnaireTemplateViewController"];
            [[[_newQuestionnaireTemplateViewController view] shouldNot] beNil];
        });
        
        it(@"instantiates correctly from the storyboard", ^{
            [[_newQuestionnaireTemplateViewController shouldNot] beNil];
        });
    });
    
    it(@"has a reference to the template service", ^{
        [[_newQuestionnaireTemplateViewController.templateService should] beKindOfClass:[TSFTemplateService class]];
    });
});

SPEC_END