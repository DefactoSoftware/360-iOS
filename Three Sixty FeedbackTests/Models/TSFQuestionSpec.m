//
//  TSFQuestionSpec.m
//  Three Sixty Feedback
//
//  Created by Girgis on 29/01/14.
//  Copyright (c) 2014 Defacto. All rights reserved.
//

#import "Kiwi.h"
#import "TSFQuestion.h"

SPEC_BEGIN(TSFQuestionSpec)

describe(@"TSFQuestion", ^{
    __block TSFQuestion *_question;
    __block NSDictionary *_sampleDictionary = @{
                                                @"id": @146,
                                                @"question": @"Aesthetic ethical Portland cliche?"
                                                };
    
    it(@"creates a new question model with a dictionary", ^{
        _question = [TSFQuestion questionWithDictionary:_sampleDictionary];
        
        [[_question.questionId should] equal:_sampleDictionary[@"id"]];
        [[_question.question should] equal:_sampleDictionary[@"question"]];
    });
});

SPEC_END