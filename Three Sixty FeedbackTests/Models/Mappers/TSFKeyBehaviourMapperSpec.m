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
                                                    @"id" : @(arc4random()),
                                                    @"description" : [NSString stringWithFormat:@"%d", arc4random()],
                                                    @"key_behaviour_rating" : @(arc4random_uniform(5))
                                                    },
                                                @{
                                                    @"id" : @(arc4random()),
                                                    @"description" : [NSString stringWithFormat:@"%d", arc4random()],
                                                    @"key_behaviour_rating" : @(arc4random_uniform(5))
                                                    },
                                                ];
    __block TSFKeyBehaviourMapper *_keyBehaviourMapper;
    
    beforeEach ( ^{
        _keyBehaviourMapper = [[TSFKeyBehaviourMapper alloc] init];
	});
    
    it(@"maps a key behaviour correctly", ^{
        NSDictionary *keyBehaviourDictionary = [_sampleDictionaryArray firstObject];
        TSFKeyBehaviour *keyBehaviour = [_keyBehaviourMapper keyBehaviourWithDictionary:keyBehaviourDictionary];
        
        [[keyBehaviour.keyBehaviourId should] equal:keyBehaviourDictionary[@"id"]];
        [[keyBehaviour.keyBehaviourDescription should] equal:keyBehaviourDictionary[@"description"]];
        [[keyBehaviour.rating should] equal:keyBehaviourDictionary[@"key_behaviour_rating"]];
	});
    
    it(@"maps an array of key behaviours correctly", ^{
        NSArray *keyBehaviours = [_keyBehaviourMapper keyBehavioursWithDictionaryArray:_sampleDictionaryArray];
        
        [[[keyBehaviours should] have:[_sampleDictionaryArray count]] behaviors];
        [[[keyBehaviours firstObject] should] beKindOfClass:[TSFKeyBehaviour class]];
	});
    
    it(@"maps a dictionary correctly with a key behaviour", ^{
        NSDictionary *dictionary = _sampleDictionaryArray[0];
        
        TSFKeyBehaviour *keyBehaviour = [_keyBehaviourMapper keyBehaviourWithDictionary:dictionary];
        
        NSDictionary *mappedDictionary = [_keyBehaviourMapper dictionaryWithKeyBehaviour:keyBehaviour];
        
        [[mappedDictionary[@"id"] should] equal:dictionary[@"id"]];
        [[mappedDictionary[@"description"] should] equal:dictionary[@"description"]];
        [[mappedDictionary[@"key_behaviour_rating"] should] equal:dictionary[@"key_behaviour_rating"]];
	});
    
    it(@"maps an array of dictionaries correctly with key behaviours", ^{
        NSArray *keyBehaviours = [_keyBehaviourMapper keyBehavioursWithDictionaryArray:_sampleDictionaryArray];
        TSFKeyBehaviourMapper *keyBehaviourMapper = [[TSFKeyBehaviourMapper alloc] init];
        NSArray *dictionaries = [keyBehaviourMapper dictionariesWithKeyBehaviourArray:keyBehaviours];
        
        [[[dictionaries should] have:[_sampleDictionaryArray count]] items];
        [[[dictionaries firstObject] should] beKindOfClass:[NSDictionary class]];
	});
});

SPEC_END
