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
    __block UIStoryboard *_storyboard;
    __block TSFLoginViewController *_loginViewController;
    
    beforeEach(^{
        _storyboard = [UIStoryboard storyboardWithName:@"Main_iPhone" bundle:nil];
        _loginViewController = [_storyboard instantiateViewControllerWithIdentifier:@"TSFLoginViewController"];
        [[[_loginViewController view] shouldNot] beNil];
    });
    
    context(@"iPhone", ^{
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
    
    it(@"has an instance of the session service", ^{
        [[_loginViewController.sessionService should] beKindOfClass:[TSFSessionService class]];
    });
    
    it(@"calls the session service to login", ^{
        id mockSessionService = [KWMock mockForClass:[TSFSessionService class]];
        _loginViewController.sessionService = mockSessionService;
        
        NSString *stubEmail = [NSString stringWithFormat:@"%d", arc4random()];
        NSString *stubPassword = [NSString stringWithFormat:@"%d", arc4random()];
        _loginViewController.emailTextField.text = stubEmail;
        _loginViewController.passwordTextField.text = stubPassword;
        
        [[mockSessionService should] receive:@selector(createNewSessionWithEmail:password:success:failure:)
                               withArguments:stubEmail, stubPassword, [KWAny any], [KWAny any]];
        
        [_loginViewController loginButtonPressed:nil];
    });
});

SPEC_END