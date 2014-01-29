//
//  TSFKeyBehaviourMapperSpec.m
//  Three Sixty Feedback
//
//  Created by Girgis on 29/01/14.
//  Copyright (c) 2014 Defacto. All rights reserved.
//

#import "Kiwi.h"
#import "TSFKeyBehaviourMapper.h"

SPEC_BEGIN(TSFKeyBehaviourMapperSpec)

describe(@"TSFKeyBehaviourMapper", ^{
    __block NSArray *_sampleDictionaryArray = @[
                                                @{
                                                    @"id": @(arc4random()),
                                                    @"description": [NSString stringWithFormat:@"%d" ,arc4random()],
                                                    @"key_behaviour_rating": @(arc4random_uniform(5))
                                                },
                                                @{
                                                    @"id": @(arc4random()),
                                                    @"description": [NSString stringWithFormat:@"%d" ,arc4random()],
                                                    @"key_behaviour_rating": @(arc4random_uniform(5))
                                                    },
                                                ];
    
    it(@"maps a key behaviour correctly", ^{
        NSDictionary *keyBehaviourDictionary = [_sampleDictionaryArray firstObject];
        TSFKeyBehaviour *keyBehaviour = [TSFKeyBehaviourMapper keyBehaviourWithDictionary:keyBehaviourDictionary];
        
        [[keyBehaviour.keyBehaviourId should] equal:keyBehaviourDictionary[@"id"]];
        [[keyBehaviour.keyBehaviourDescription should] equal:keyBehaviourDictionary[@"description"]];
        [[keyBehaviour.rating should] equal:keyBehaviourDictionary[@"key_behaviour_rating"]];
    });
    
});

SPEC_END