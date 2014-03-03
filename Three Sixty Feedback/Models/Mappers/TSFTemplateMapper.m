//
//  TSFTemplateMapper.m
//  Three Sixty Feedback
//
//  Created by Girgis Ghattas on 03-03-14.
//  Copyright (c) 2014 Defacto. All rights reserved.
//

#import "TSFTemplateMapper.h"

@implementation TSFTemplateMapper

- (id)init {
    self = [super init];
    if (self) {
        _questionMapper = [[TSFQuestionMapper alloc] init];
        _competenceMapper = [[TSFCompetenceMapper alloc] init];
    }
    return self;
}

- (TSFTemplate *)templateWithDictionary:(NSDictionary *)dictionary {
	TSFTemplate *template = [[TSFTemplate alloc] init];
    
	template.templateId = dictionary[@"id"];
	template.title = dictionary[@"title"];
	template.templateDescription = dictionary[@"description"];
    template.questions = [self.questionMapper questionsWithDictionaryArray:dictionary[@"questions"]];
	template.competences = [self.competenceMapper competencesWithDictionaryArray:dictionary[@"competences"]];
    
	return template;
}

- (NSArray *)templatesWithDictionaryArray:(NSArray *)dictionaryArray {
    NSMutableArray *templates = [[NSMutableArray alloc] init];
    
	for (NSDictionary *questionnaireDictionary in dictionaryArray) {
		TSFTemplate *template = [self templateWithDictionary:questionnaireDictionary];
		[templates addObject:template];
	}
    
	return templates;
}

@end
