//
//  TSFHomeViewControllerSpec.m
//  Three Sixty Feedback
//
//  Created by Girgis Ghattas on 03-02-14.
//  Copyright (c) 2014 Defacto. All rights reserved.
//

#import "Kiwi.h"
#import "TSFHomeViewController.h"

SPEC_BEGIN(TSFHomeViewControllerSpec)

describe(@"TSFHomeViewController", ^{
    __block UIStoryboard *_storyboard;
    __block TSFHomeViewController*_homeViewController;
    __block id _mockAssessorService;
    
    beforeEach (^{
        _storyboard = [UIStoryboard storyboardWithName:@"Main_iPhone" bundle:nil];
        _homeViewController = [_storyboard instantiateViewControllerWithIdentifier:@"TSFHomeViewController"];
        
        UIView *view = _homeViewController.view;
        [[view shouldNot] beNil];
	});
    
    it(@"instantiates correctly from the storyboard", ^{
        [[_homeViewController shouldNot] beNil];
        [[_homeViewController should] beKindOfClass:[TSFHomeViewController class]];
	});
    
    it(@"has an outlet for the intro label", ^{
        [[_homeViewController.introLabel shouldNot] beNil];
    });
});

SPEC_END