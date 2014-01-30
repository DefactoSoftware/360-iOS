//
//  TSFCompetenceMapperSpec.m
//  Three Sixty Feedback
//
//  Created by Girgis on 29/01/14.
//  Copyright (c) 2014 Defacto. All rights reserved.
//

#import "Kiwi.h"
#import "TSFCompetenceMapper.h"

SPEC_BEGIN(TSFCompetenceMapperSpec)

describe(@"TSFCompetenceMapper", ^{
    __block NSArray *_sampleDictionaryArray = @[
                                                @{
                                                    @"id" : @(arc4random()),
                                                    @"title" : [NSString stringWithFormat:@"%d", arc4random()],
                                                    @"comment" : [NSString stringWithFormat:@"%d", arc4random()],
                                                    @"key_behaviours" : @[@{ @"id" : @(arc4random()) }]
                                                    },
                                                @{
                                                    @"id" : @(arc4random()),
                                                    @"title" : [NSString stringWithFormat:@"%d", arc4random()],
                                                    @"comment" : [NSString stringWithFormat:@"%d", arc4random()],
                                                    @"key_behaviours" : @[@{ @"id" : @(arc4random()) }]
                                                    },
                                                ];
    __block TSFCompetenceMapper *_competenceMapper;
    
    beforeEach ( ^{
        _competenceMapper = [[TSFCompetenceMapper alloc] init];
	});
    
    it(@"has a key behaviour mapper instance", ^{
        TSFCompetenceMapper *competenceMapper = [[TSFCompetenceMapper alloc] init];
        [[competenceMapper.keyBehaviourMapper shouldNot] beNil];
        [[competenceMapper.keyBehaviourMapper should] beKindOfClass:[TSFKeyBehaviourMapper class]];
	});
    
    it(@"maps a competence correctly", ^{
        NSDictionary *competenceDictionary = [_sampleDictionaryArray firstObject];
                
        TSFCompetence *competence = [_competenceMapper competenceWithDictionary:competenceDictionary];
        
        [[competence.competenceId should] equal:competenceDictionary[@"id"]];
        [[competence.title should] equal:competenceDictionary[@"title"]];
        [[competence.comment should] equal:competenceDictionary[@"comment"]];
        [[[competence.keyBehaviours should] have:[competenceDictionary[@"key_behaviours"] count]] keyBehaviours];
	});
    
    it(@"maps an array of competences correctly", ^{
        NSArray *competences = [_competenceMapper competencesWithDictionaryArray:_sampleDictionaryArray];
        
        [[[competences should] have:[_sampleDictionaryArray count]] items];
        [[[competences firstObject] should] beKindOfClass:[TSFCompetence class]];
	});
    
    it(@"maps a dictionary correctly from a competence", ^{
        NSDictionary *dictionary = _sampleDictionaryArray[0];
        
        TSFCompetence *competence = [_competenceMapper competenceWithDictionary:dictionary];
        
        NSDictionary *mappedDictionary = [_competenceMapper dictionaryWithCompetence:competence];
        
        [[mappedDictionary[@"id"] should] equal:dictionary[@"id"]];
        [[mappedDictionary[@"title"] should] equal:dictionary[@"title"]];
        [[mappedDictionary[@"comment"] should] equal:dictionary[@"comment"]];
        [[[mappedDictionary[@"key_behaviours"] should] have:1] behaviors];
	});
});

SPEC_END
