//
//  TSFPasswordRequestViewControllerSpec.m
//  Three Sixty Feedback
//
//  Created by Girgis Ghattas on 21-02-14.
//  Copyright (c) 2014 Defacto. All rights reserved.
//

#import "Kiwi.h"
#import "TSFPasswordRequestViewController.h"

SPEC_BEGIN(TSFPasswordRequestViewControllerSpec)

describe(@"TSFPasswordRequestViewController", ^{
    __block UIStoryboard *_storyboard;
    __block TSFPasswordRequestViewController *_passwordRequestViewController;
    
    beforeEach(^{
        _storyboard = [UIStoryboard storyboardWithName:@"Main_iPhone" bundle:nil];
        _passwordRequestViewController = [_storyboard instantiateViewControllerWithIdentifier:@"TSFPasswordRequestViewController"];
        [[[_passwordRequestViewController view] shouldNot] beNil];
    });
    
    context(@"iPhone", ^{
        it(@"instantiates correctly from the storyboard", ^{
            [[_passwordRequestViewController shouldNot] beNil];
        });
        
        it(@"has an outlet for the email label", ^{
            [[_passwordRequestViewController.emailLabel shouldNot] beNil];
        });
        
        it(@"has an outlet for the email textfield", ^{
            [[_passwordRequestViewController.emailTextField shouldNot] beNil];
        });
        
        it(@"has an outlet for the request button", ^{
            [[_passwordRequestViewController.requestButton shouldNot] beNil];
        });
        
        it(@"has an outlet for the success label", ^{
            [[_passwordRequestViewController.successLabel shouldNot] beNil];
        });
    });
    
    context(@"iPad", ^{
        __block UIStoryboard *_storyboard;
        __block TSFPasswordRequestViewController *_passwordRequestViewController;
        
        beforeEach(^{
            _storyboard = [UIStoryboard storyboardWithName:@"Main_iPad" bundle:nil];
            _passwordRequestViewController = [_storyboard instantiateViewControllerWithIdentifier:@"TSFPasswordRequestViewController"];
            [[[_passwordRequestViewController view] shouldNot] beNil];
        });
        
        it(@"instantiates correctly from the storyboard", ^{
            [[_passwordRequestViewController shouldNot] beNil];
        });
        
        it(@"has an outlet for the email label", ^{
            [[_passwordRequestViewController.emailLabel shouldNot] beNil];
        });
        
        it(@"has an outlet for the email textfield", ^{
            [[_passwordRequestViewController.emailTextField shouldNot] beNil];
        });
        
        it(@"has an outlet for the success label", ^{
            [[_passwordRequestViewController.successLabel shouldNot] beNil];
        });

        it(@"has an outlet for the request button", ^{
            [[_passwordRequestViewController.requestButton shouldNot] beNil];
        });
    });
});

SPEC_END