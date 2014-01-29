//
//  TSFCompetenceSpec.m
//  Three Sixty Feedback
//
//  Created by Girgis on 29/01/14.
//  Copyright (c) 2014 Defacto. All rights reserved.
//

#import "Kiwi.h"
#import "TSFCompetence.h"

SPEC_BEGIN(TSFCompetenceSpec)

describe(@"TSFCompetence", ^{
    __block TSFCompetence *_competence;
    __block NSDictionary *_sampleDictionary = @{
                                                @"id": @(arc4random()),
                                                @"title": [NSString stringWithFormat:@"%d" ,arc4random()],
                                                @"comment": [NSString stringWithFormat:@"%d" ,arc4random()],
                                                @"key_behaviours": @[
                                                                    @{
                                                                      @"id": @(arc4random())
                                                                      }
                                                                    ]
                                                };
    
    beforeEach(^{
        _competence = [TSFCompetence competenceWithDictionary:_sampleDictionary];
    });
    
    it(@"creates a new competence model with a dictionary", ^{
        [[_competence.competenceId should] equal:_sampleDictionary[@"id"]];
        [[_competence.title should] equal:_sampleDictionary[@"title"]];
        [[_competence.comment should] equal:_sampleDictionary[@"comment"]];
        [[_competence.keyBehaviours should] beKindOfClass:[NSArray class]];
    });
    
    it(@"creates new key behaviour models based on their dictionaries", ^{
        TSFKeyBehaviour *keyBehaviour = [_competence.keyBehaviours firstObject];
        
        [[[_competence.keyBehaviours should] have:[_sampleDictionary[@"key_behaviours"] count]] keyBehaviours];
        [[keyBehaviour shouldNot] beNil];
        [[keyBehaviour.keyBehaviourId should] equal:_sampleDictionary[@"key_behaviours"][0][@"id"]];
    });
});

SPEC_END