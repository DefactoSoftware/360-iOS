//
//  TSFMainViewControllerSpec.m
//  Three Sixty Feedback
//
//  Created by Girgis Ghattas on 20-02-14.
//  Copyright (c) 2014 Defacto. All rights reserved.
//

#import "Kiwi.h"
#import "TSFMainViewController.h"

SPEC_BEGIN(TSFMainViewControllerSpec)

describe(@"TSFMainViewController", ^{
    __block UIStoryboard *_storyboard;
    __block TSFMainViewController *_mainViewController;
    
    beforeEach(^{
        _storyboard = [UIStoryboard storyboardWithName:@"Main_iPhone" bundle:nil];
        _mainViewController = [_storyboard instantiateViewControllerWithIdentifier:@"TSFMainViewController"];
        [[[_mainViewController view] shouldNot] beNil];
    });
    
    context(@"iPhone", ^{
        it(@"instantiates correctly from the storyboard", ^{
            [[_mainViewController shouldNot] beNil];
        });
    });
    
    context(@"iPad", ^{
        __block UIStoryboard *_storyboard;
        __block TSFMainViewController *_mainViewController;
        
        beforeEach(^{
            _storyboard = [UIStoryboard storyboardWithName:@"Main_iPad" bundle:nil];
            _mainViewController = [_storyboard instantiateViewControllerWithIdentifier:@"TSFMainViewController"];
            [[[_mainViewController view] shouldNot] beNil];
        });
        
        it(@"instantiates correctly from the storyboard", ^{
            [[_mainViewController shouldNot] beNil];
        });
    });
});

SPEC_END