//
//  TSFLoginViewControllerSpec.m
//  Three Sixty Feedback
//
//  Created by Girgis Ghattas on 19-02-14.
//  Copyright (c) 2014 Defacto. All rights reserved.
//

#import "Kiwi.h"
#import "TSFLoginViewController.h"

SPEC_BEGIN(TSFLoginViewControllerSpec)

describe(@"TSFLoginViewController", ^{
    context(@"iPhone", ^{
        __block UIStoryboard *_storyboard;
        __block TSFLoginViewController *_loginViewController;
        
        beforeEach(^{
            _storyboard = [UIStoryboard storyboardWithName:@"Main_iPhone" bundle:nil];
            _loginViewController = [_storyboard instantiateViewControllerWithIdentifier:@"TSFLoginViewController"];
            [[[_loginViewController view] shouldNot] beNil];
        });
        
        it(@"instantiates correctly from the storyboard", ^{
            [[_loginViewController shouldNot] beNil];
        });
        
        it(@"has an outlet for the email adress field and label", ^{
            [[_loginViewController.emailLabel shouldNot] beNil];
            [[_loginViewController.emailTextField shouldNot] beNil];
        });
        
        it(@"has an outlet for the password field and label", ^{
            [[_loginViewController.passwordLabel shouldNot] beNil];
            [[_loginViewController.passwordTextField shouldNot] beNil];
        });
        
        it(@"has an outlet for the login button", ^{
            [[_loginViewController.loginButton shouldNot] beNil];
        });
    });
    
    context(@"iPad", ^{
        __block UIStoryboard *_storyboard;
        __block TSFLoginViewController *_loginViewController;
        
        beforeEach(^{
            _storyboard = [UIStoryboard storyboardWithName:@"Main_iPad" bundle:nil];
            _loginViewController = [_storyboard instantiateViewControllerWithIdentifier:@"TSFLoginViewController"];
            [[[_loginViewController view] shouldNot] beNil];
        });
        
        it(@"instantiates correctly from the storyboard", ^{
            [[_loginViewController shouldNot] beNil];
        });
        
        it(@"has an outlet for the email adress field and label", ^{
            [[_loginViewController.emailLabel shouldNot] beNil];
            [[_loginViewController.emailTextField shouldNot] beNil];
        });
        
        it(@"has an outlet for the password field and label", ^{
            [[_loginViewController.passwordLabel shouldNot] beNil];
            [[_loginViewController.passwordTextField shouldNot] beNil];
        });
        
        it(@"has an outlet for the login button", ^{
            [[_loginViewController.loginButton shouldNot] beNil];
        });
    });
});

SPEC_END