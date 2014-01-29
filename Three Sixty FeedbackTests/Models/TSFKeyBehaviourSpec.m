//
//  TSFKeyBehaviourSpec.m
//  Three Sixty Feedback
//
//  Created by Girgis on 29/01/14.
//  Copyright (c) 2014 Defacto. All rights reserved.
//

#import "Kiwi.h"
#import "TSFKeyBehaviour.h"

SPEC_BEGIN(TSFKeyBehaviourSpec)

describe(@"TSFKeyBehaviour", ^{
    __block TSFKeyBehaviour *_keyBehaviour;
    __block NSDictionary *_sampleDictionary = @{
                                                @"id": @(arc4random()),
                                                @"description": [NSString stringWithFormat:@"%d" ,arc4random()],
                                                @"key_behaviour_rating": @(arc4random_uniform(5))
                                                };
    
    it(@"creates a new key behaviour model with a dictionary", ^{
        _keyBehaviour = [TSFKeyBehaviour keyBehaviourWithDictionary:_sampleDictionary];
        
        [[_keyBehaviour.keyBehaviourId should] equal:_sampleDictionary[@"id"]];
        [[_keyBehaviour.keyBehaviourDescription should] equal:_sampleDictionary[@"description"]];
        [[_keyBehaviour.rating should] equal:_sampleDictionary[@"key_behaviour_rating"]];
    });
});

SPEC_END