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
                                                @"id": @154,
                                                @"title": @"McSweeney's",
                                                @"comment": @"",
                                                @"key_behaviours": @[
                                                                    @{
                                                                      @"id": @609
                                                                      }
                                                                    ]
                                                };
    
    it(@"creates a new competence model with a dictionary", ^{
        _competence = [TSFCompetence competenceWithDictionary:_sampleDictionary];
        
        [[_competence.competenceId should] equal:_sampleDictionary[@"id"]];
        [[_competence.title should] equal:_sampleDictionary[@"title"]];
        [[_competence.comment should] equal:_sampleDictionary[@"comment"]];
        [[_competence.keyBehaviours should] beKindOfClass:[NSArray class]];
    });
});

SPEC_END