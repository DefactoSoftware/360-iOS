//
//  TSFTemplateViewControllerSpec.m
//  Three Sixty Feedback
//
//  Created by Girgis Ghattas on 03-03-14.
//  Copyright (c) 2014 Defacto. All rights reserved.
//

#import "Kiwi.h"
#import "TSFTemplateViewController.h"

SPEC_BEGIN(TSFTemplateViewControllerSpec)

describe(@"TSFTemplateViewController", ^{
    __block UIStoryboard *_storyboard;
    __block TSFTemplateViewController *_templateViewController;
    
    beforeEach(^{
        _storyboard = [UIStoryboard storyboardWithName:@"Main_iPhone" bundle:nil];
        _templateViewController = [_storyboard instantiateViewControllerWithIdentifier:@"TSFTemplateViewController"];
        [[[_templateViewController view] shouldNot] beNil];
    });
    
    context(@"iPhone", ^{
        it(@"instantiates correctly from the storyboard", ^{
            [[_templateViewController shouldNot] beNil];
        });
        
        it(@"has a questionnaire tableview", ^{
            [[_templateViewController.templateTableView shouldNot] beNil];
        });
        
        it(@"has an outlet for the close button", ^{
            [[_templateViewController.closeButton shouldNot] beNil];
        });
        
        it(@"has an outlet for the header label", ^{
            [[_templateViewController.headerLabel shouldNot] beNil];
        });
    });
    
    context(@"iPad", ^{
        __block UIStoryboard *_storyboard;
        __block TSFTemplateViewController *_templateViewController;
        
        beforeEach(^{
            _storyboard = [UIStoryboard storyboardWithName:@"Main_iPad" bundle:nil];
            _templateViewController = [_storyboard instantiateViewControllerWithIdentifier:@"TSFTemplateViewController"];
            [[[_templateViewController view] shouldNot] beNil];
        });
        
        it(@"instantiates correctly from the storyboard", ^{
            [[_templateViewController shouldNot] beNil];
        });
        
        it(@"has a questionnaire tableview", ^{
            [[_templateViewController.templateTableView shouldNot] beNil];
        });
        
        it(@"has an outlet for the close button", ^{
            [[_templateViewController.closeButton shouldNot] beNil];
        });
        
        it(@"has an outlet for the header label", ^{
            [[_templateViewController.headerLabel shouldNot] beNil];
        });
    });
});

SPEC_END