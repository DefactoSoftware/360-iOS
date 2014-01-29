//
//  TSFQuestionnaireMapper.m
//  Three Sixty Feedback
//
//  Created by Girgis on 29/01/14.
//  Copyright (c) 2014 Defacto. All rights reserved.
//

#import "Kiwi.h"
#import "TSFQuestionnaireMapper.h"

SPEC_BEGIN(TSFQuestionnaireMapperSpec)

describe(@"TSFQuestionnaireMapper", ^{
  __block NSArray *_sampleDictionaryArray = @[
    @{
      @"id" : @(arc4random()),
      @"title" : [NSString stringWithFormat:@"%d", arc4random()],
      @"description" : [NSString stringWithFormat:@"%d", arc4random()],
      @"subject" : [NSString stringWithFormat:@"%d", arc4random()],
      @"questions" : @[ @{ @"id" : @(arc4random()) } ],
      @"competences" : @[ @{ @"id" : @(arc4random()) } ]
    },
    @{
      @"id" : @(arc4random()),
      @"title" : [NSString stringWithFormat:@"%d", arc4random()],
      @"description" : [NSString stringWithFormat:@"%d", arc4random()],
      @"subject" : [NSString stringWithFormat:@"%d", arc4random()],
      @"questions" : @[ @{ @"id" : @(arc4random()) } ],
      @"competences" : @[ @{ @"id" : @(arc4random()) } ]
    }
  ];

  it(@"maps a questionnaire correctly", ^{
    NSDictionary *questionnaireDictionary =
        [_sampleDictionaryArray firstObject];

    TSFQuestionnaire *questionnaire = [TSFQuestionnaireMapper
        questionnaireWithDictionary:questionnaireDictionary];

    [[questionnaire.questionnaireId should]
        equal:questionnaireDictionary[@"id"]];
    [[questionnaire.title should] equal:questionnaireDictionary[@"title"]];
    [[questionnaire.questionnaireDescription should]
        equal:questionnaireDictionary[@"description"]];
    [[questionnaire.subject should] equal:questionnaireDictionary[@"subject"]];

    [[[questionnaire.questions should]
         have:[questionnaireDictionary[@"questions"] count]] questions];
    [[[questionnaire.competences should]
         have:[questionnaireDictionary[@"competences"] count]] competences];
  });

  it(@"maps an array of questionnaires correctly", ^{
    NSArray *questionnaires = [TSFQuestionnaireMapper
        questionnairesWithDictionaryArray:_sampleDictionaryArray];

    [[[questionnaires should] have:[_sampleDictionaryArray count]] items];
    [[[questionnaires firstObject] should]
        beKindOfClass:[TSFQuestionnaire class]];
  });
});

SPEC_END