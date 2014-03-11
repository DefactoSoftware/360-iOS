//
//  TSFThanksViewControllerSpec.m
//  Three Sixty Feedback
//
//  Created by Girgis Ghattas on 11-03-14.
//  Copyright (c) 2014 Defacto. All rights reserved.
//

#import "Kiwi.h"
#import "TSFThanksViewController.h"

SPEC_BEGIN(TSFThanksViewControllerSpec)

describe(@"TSFThanksViewController", ^{
    __block UIStoryboard *_storyboard;
    __block TSFThanksViewController *_thanksViewController;
    
    beforeEach (^{
        _storyboard = [UIStoryboard storyboardWithName:@"Main_iPhone" bundle:nil];
        _thanksViewController = [_storyboard instantiateViewControllerWithIdentifier:@"TSFThanksViewController"];
        
        UIView *view = _thanksViewController.view;
        [[view shouldNot] beNil];
	});
    
    it(@"instantiates correctly from the storyboard", ^{
        [[_thanksViewController shouldNot] beNil];
        [[_thanksViewController should] beKindOfClass:[TSFThanksViewController class]];
	});
    
    it(@"has an outlet for the header label", ^{
        [[_thanksViewController.headerLabel shouldNot] beNil];
    });
    
    it(@"has an outlet for the thanks label", ^{
        [[_thanksViewController.thanksLabel shouldNot] beNil];
    });
    
    context(@"iPad", ^{
        beforeEach (^{
            _storyboard = [UIStoryboard storyboardWithName:@"Main_iPad" bundle:nil];
            _thanksViewController = [_storyboard instantiateViewControllerWithIdentifier:@"TSFThanksViewController"];
            
            UIView *view = _thanksViewController.view;
            [[view shouldNot] beNil];
        });
        
        it(@"instantiates correctly from the storyboard", ^{
            [[_thanksViewController shouldNot] beNil];
            [[_thanksViewController should] beKindOfClass:[TSFThanksViewController class]];
        });
        
        it(@"has an outlet for the header label", ^{
            [[_thanksViewController.headerLabel shouldNot] beNil];
        });
        
        it(@"has an outlet for the thanks label", ^{
            [[_thanksViewController.thanksLabel shouldNot] beNil];
        });
    });
});

SPEC_END
    