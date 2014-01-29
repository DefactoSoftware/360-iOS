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
      @"key_behaviours" : @[ @{ @"id" : @(arc4random()) } ]
    },
    @{
      @"id" : @(arc4random()),
      @"title" : [NSString stringWithFormat:@"%d", arc4random()],
      @"comment" : [NSString stringWithFormat:@"%d", arc4random()],
      @"key_behaviours" : @[ @{ @"id" : @(arc4random()) } ]
    },
  ];

  it(@"maps a competence correctly", ^{
    NSDictionary *competenceDictionary = [_sampleDictionaryArray firstObject];

    TSFCompetence *competence =
        [TSFCompetenceMapper competenceWithDictionary:competenceDictionary];

    [[competence.competenceId should] equal:competenceDictionary[@"id"]];
    [[competence.title should] equal:competenceDictionary[@"title"]];
    [[competence.comment should] equal:competenceDictionary[@"comment"]];
    [[[competence.keyBehaviours should]
         have:[competenceDictionary[@"key_behaviours"] count]] keyBehaviours];
  });

  it(@"maps an array of competences correctly", ^{
    NSArray *competences = [TSFCompetenceMapper
        competencesWithDictionaryArray:_sampleDictionaryArray];

    [[[competences should] have:[_sampleDictionaryArray count]] items];
    [[[competences firstObject] should] beKindOfClass:[TSFCompetence class]];
  });
});

SPEC_END