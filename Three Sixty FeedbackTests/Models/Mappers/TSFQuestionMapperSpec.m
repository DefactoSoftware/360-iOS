//
//  TSFQuestionMapperSpec.m
//  Three Sixty Feedback
//
//  Created by Girgis on 29/01/14.
//  Copyright (c) 2014 Defacto. All rights reserved.
//

#import "Kiwi.h"
#import "TSFQuestionMapper.h"

SPEC_BEGIN(TSFQuestionMapperSpec)

describe(@"TSFQuestionMapper", ^{
  __block NSArray *_sampleDictionaryArray = @[
    @{
      @"id" : @(arc4random()),
      @"question" : [NSString stringWithFormat:@"%d", arc4random()]
    },
    @{
      @"id" : @(arc4random()),
      @"question" : [NSString stringWithFormat:@"%d", arc4random()]
    },
  ];

  it(@"maps a question correctly", ^{
    NSDictionary *questionDictionary = [_sampleDictionaryArray firstObject];
    TSFQuestion *question =
        [TSFQuestionMapper questionWithDictionary:questionDictionary];

    [[question.questionId should] equal:questionDictionary[@"id"]];
    [[question.question should] equal:questionDictionary[@"question"]];
  });

  it(@"maps an array of questions correctly", ^{
    NSArray *questions =
        [TSFQuestionMapper questionsWithDictionaryArray:_sampleDictionaryArray];

    [[[questions should] have:[_sampleDictionaryArray count]] items];
    [[[questions firstObject] should] beKindOfClass:[TSFQuestion class]];
  });
});

SPEC_END