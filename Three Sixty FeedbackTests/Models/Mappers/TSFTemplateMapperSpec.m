//
//  TSFTemplateMapperSpec.m
//  Three Sixty Feedback
//
//  Created by Girgis Ghattas on 03-03-14.
//  Copyright (c) 2014 Defacto. All rights reserved.
//

#import "Kiwi.h"
#import "TSFTemplateMapper.h"

SPEC_BEGIN(TSFTemplateMapperSpec)

describe(@"TSFTemplateMapper", ^{
    __block NSArray *_sampleDictionaryArray = @[
                                                @{
                                                    @"id" : @(arc4random()),
                                                    @"title" : [NSString stringWithFormat:@"%d", arc4random()],
                                                    @"description" : [NSString stringWithFormat:@"%d", arc4random()],
                                                    @"questions" : @[@{ @"id" : @(arc4random()) }],
                                                    @"competences" : @[@{ @"id" : @(arc4random()) }]
                                                    },
                                                @{
                                                    @"id" : @(arc4random()),
                                                    @"title" : [NSString stringWithFormat:@"%d", arc4random()],
                                                    @"description" : [NSString stringWithFormat:@"%d", arc4random()],
                                                    @"questions" : @[@{ @"id" : @(arc4random()) }],
                                                    @"competences" : @[@{ @"id" : @(arc4random()) }]
                                                    }
                                                ];
    __block TSFTemplateMapper *_templateMapper;
    __block id _mockQuestionMapper;
    __block id _mockCompetenceMapper;
    
    beforeEach ( ^{
        _templateMapper = [[TSFTemplateMapper alloc] init];
        _mockQuestionMapper = [KWMock mockForClass:[TSFQuestionMapper class]];
        _mockCompetenceMapper = [KWMock mockForClass:[TSFCompetenceMapper class]];
	});
    
    context(@"default initialization", ^{
        __block TSFTemplateMapper *_templateMapper;
        
        beforeEach ( ^{
            _templateMapper = [[TSFTemplateMapper alloc] init];
		});
        
        it(@"has a question mapper instance", ^{
            [[_templateMapper.questionMapper shouldNot] beNil];
            [[_templateMapper.questionMapper should] beKindOfClass:[TSFQuestionMapper class]];
		});
        
        it(@"has a competence mapper instance", ^{
            [[_templateMapper.competenceMapper shouldNot] beNil];
            [[_templateMapper.competenceMapper should] beKindOfClass:[TSFCompetenceMapper class]];
		});
	});
    
    it(@"maps a template correctly", ^{
        NSDictionary *templateDictionary = [_sampleDictionaryArray firstObject];
        
        TSFTemplate *template = [_templateMapper templateWithDictionary:templateDictionary];
        
        [[template.templateId should] equal:templateDictionary[@"id"]];
        [[template.title should] equal:templateDictionary[@"title"]];
        [[template.templateDescription should] equal:templateDictionary[@"description"]];
        
        [[[template.questions should] have:[templateDictionary[@"questions"] count]] questions];
        [[[template.competences should] have:[templateDictionary[@"competences"] count]] competences];
	});
    
    it(@"maps an array of questionnaires correctly", ^{
        NSArray *templates = [_templateMapper templatesWithDictionaryArray:_sampleDictionaryArray];
        
        [[[templates should] have:[_sampleDictionaryArray count]] items];
        [[[templates firstObject] should] beKindOfClass:[TSFTemplate class]];
	});
});

SPEC_END
