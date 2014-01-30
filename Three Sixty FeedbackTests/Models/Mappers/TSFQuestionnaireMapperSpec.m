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
                                                    @"questions" : @[@{ @"id" : @(arc4random()) }],
                                                    @"competences" : @[@{ @"id" : @(arc4random()) }]
                                                    },
                                                @{
                                                    @"id" : @(arc4random()),
                                                    @"title" : [NSString stringWithFormat:@"%d", arc4random()],
                                                    @"description" : [NSString stringWithFormat:@"%d", arc4random()],
                                                    @"subject" : [NSString stringWithFormat:@"%d", arc4random()],
                                                    @"questions" : @[@{ @"id" : @(arc4random()) }],
                                                    @"competences" : @[@{ @"id" : @(arc4random()) }]
                                                    }
                                                ];
    __block TSFQuestionnaireMapper *_questionnaireMapper;
    __block id _mockQuestionMapper;
    __block id _mockCompetenceMapper;
    
    beforeEach ( ^{
        _questionnaireMapper = [[TSFQuestionnaireMapper alloc] init];
        _mockQuestionMapper = [KWMock mockForClass:[TSFQuestionMapper class]];
        _mockCompetenceMapper = [KWMock mockForClass:[TSFCompetenceMapper class]];
	});
    
    context(@"default initialization", ^{
        __block TSFQuestionnaireMapper *_questionnaireMapper;
        
        beforeEach ( ^{
            _questionnaireMapper = [[TSFQuestionnaireMapper alloc] init];
		});
        
        it(@"has a question mapper instance", ^{
            [[_questionnaireMapper.questionMapper shouldNot] beNil];
            [[_questionnaireMapper.questionMapper should] beKindOfClass:[TSFQuestionMapper class]];
		});
        
        it(@"has a competence mapper instance", ^{
            [[_questionnaireMapper.competenceMapper shouldNot] beNil];
            [[_questionnaireMapper.competenceMapper should] beKindOfClass:[TSFCompetenceMapper class]];
		});
	});
    
    it(@"maps a questionnaire correctly", ^{
        NSDictionary *questionnaireDictionary = [_sampleDictionaryArray firstObject];
        
        TSFQuestionnaire *questionnaire = [_questionnaireMapper questionnaireWithDictionary:questionnaireDictionary];
        
        [[questionnaire.questionnaireId should] equal:questionnaireDictionary[@"id"]];
        [[questionnaire.title should] equal:questionnaireDictionary[@"title"]];
        [[questionnaire.questionnaireDescription should] equal:questionnaireDictionary[@"description"]];
        [[questionnaire.subject should] equal:questionnaireDictionary[@"subject"]];
        
        [[[questionnaire.questions should] have:[questionnaireDictionary[@"questions"] count]] questions];
        [[[questionnaire.competences should] have:[questionnaireDictionary[@"competences"] count]] competences];
	});
    
    it(@"maps an array of questionnaires correctly", ^{
        NSArray *questionnaires = [_questionnaireMapper questionnairesWithDictionaryArray:_sampleDictionaryArray];
        
        [[[questionnaires should] have:[_sampleDictionaryArray count]] items];
        [[[questionnaires firstObject] should] beKindOfClass:[TSFQuestionnaire class]];
	});
});

SPEC_END
