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
                                               @"id": @387,
                                               @"title": @"The old Questionnaire title",
                                               @"description": @"This is a great questionnaire",
                                               @"subject": @"Jamal Bergstrom",
                                               @"questions": @[
                                                             @{
                                                                 @"id": @150
                                                             }
                                                             ],
                                               @"competences": @[
                                                               @{
                                                                   @"id": @154
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
});

SPEC_END