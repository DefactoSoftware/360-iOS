//
//  TSFQuestionnaireSpec.m
//  Three Sixty Feedback
//
//  Created by Girgis on 29/01/14.
//  Copyright (c) 2014 Defacto. All rights reserved.
//

#import "Kiwi.h"
#import "TSFQuestionnaire.h"

SPEC_BEGIN(TSFQuestionnaireSpec)

describe(@"TSFQuestionnaire", ^{
    __block TSFQuestionnaire *_questionnaire;
    __block NSDictionary *_sampleDictionary = @{
                                               @"id": @(arc4random()),
                                               @"title": [NSString stringWithFormat:@"%d" ,arc4random()],
                                               @"description": [NSString stringWithFormat:@"%d" ,arc4random()],
                                               @"subject": [NSString stringWithFormat:@"%d" ,arc4random()],
                                               @"questions": @[
                                                             @{
                                                                 @"id": @(arc4random())
                                                             }
                                                             ],
                                               @"competences": @[
                                                               @{
                                                                   @"id": @(arc4random())
                                                               }
                                                               ]
                                               };
    
    it(@"creates a new questionnaire model based on a dictionary", ^{
        _questionnaire = [TSFQuestionnaire questionnaireWithDictionary:_sampleDictionary];
        
        [[_questionnaire.questionnaireId should] equal:_sampleDictionary[@"id"]];
        [[_questionnaire.title should] equal:_sampleDictionary[@"title"]];
        [[_questionnaire.questionnaireDescription should] equal:_sampleDictionary[@"description"]];
        [[_questionnaire.subject should] equal:_sampleDictionary[@"subject"]];
        [[_questionnaire.questions should] beKindOfClass:[NSArray class]];
        [[_questionnaire.competences should] beKindOfClass:[NSArray class]];
    });
    
    it(@"creates new question models based on their dictionaries", ^{
        TSFQuestion *question = [_questionnaire.questions firstObject];
        
        [[[_questionnaire.questions should] have:[_sampleDictionary[@"questions"] count]] questions];
        [[question shouldNot] beNil];
        [[question.questionId should] equal:_sampleDictionary[@"questions"][0][@"id"]];
    });
    
    it(@"creates new competence models based on their dictionaries", ^{
        TSFCompetence *competence = [_questionnaire.competences firstObject];
        
        [[[_questionnaire.competences should] have:[_sampleDictionary[@"competences"] count]] competences];
        [[competence shouldNot] beNil];
        [[competence.competenceId should] equal:_sampleDictionary[@"competences"][0][@"id"]];
    });
});

SPEC_END