//
//  TSFMenuViewControllerSpec.m
//  Three Sixty Feedback
//
//  Created by Girgis Ghattas on 21-02-14.
//  Copyright (c) 2014 Defacto. All rights reserved.
//

#import "Kiwi.h"
#import "TSFMenuViewController.h"

SPEC_BEGIN(TSFMenuViewControllerSpec)

describe(@"TSFMenuViewController", ^{
    __block UIStoryboard *_storyboard;
    __block TSFMenuViewController *_menuViewController;
    
    beforeEach(^{
        _storyboard = [UIStoryboard storyboardWithName:@"Main_iPhone" bundle:nil];
        _menuViewController = [_storyboard instantiateViewControllerWithIdentifier:@"TSFMenuViewController"];
        [[[_menuViewController view] shouldNot] beNil];
    });
    
    context(@"iPhone", ^{
        it(@"instantiates correctly from the storyboard", ^{
            [[_menuViewController shouldNot] beNil];
        });
        
        it(@"has a menu tableview", ^{
            [[_menuViewController.menuTableView shouldNot] beNil];
        });
    });
    
    context(@"iPad", ^{
        __block UIStoryboard *_storyboard;
        __block TSFMenuViewController *_menuViewController;
        
        beforeEach(^{
            _storyboard = [UIStoryboard storyboardWithName:@"Main_iPad" bundle:nil];
            _menuViewController = [_storyboard instantiateViewControllerWithIdentifier:@"TSFMenuViewController"];
            [[[_menuViewController view] shouldNot] beNil];
        });
        
        it(@"instantiates correctly from the storyboard", ^{
            [[_menuViewController shouldNot] beNil];
        });
        
        it(@"has a menu tableview", ^{
            [[_menuViewController.menuTableView shouldNot] beNil];
        });
    });
    
    it(@"has a reference to the session service", ^{
        [[_menuViewController.sessionService should] beKindOfClass:[TSFSessionService class]];
    });
    
    it(@"logs out the user", ^{
        id mockSessionService = [KWMock mockForClass:[TSFSessionService class]];
        _menuViewController.sessionService = mockSessionService;
        [[mockSessionService should] receive:@selector(deleteCurrentSessionWithSuccess:failure:)];
        
        [_menuViewController logout];
    });
});

SPEC_END