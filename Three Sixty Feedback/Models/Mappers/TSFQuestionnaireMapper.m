//
//  TSFQuestionnaireMapper.m
//  Three Sixty Feedback
//
//  Created by Girgis on 29/01/14.
//  Copyright (c) 2014 Defacto. All rights reserved.
//

#import "TSFQuestionnaireMapper.h"

@implementation TSFQuestionnaireMapper

- (id)init {
	self = [super init];
	if (self) {
		_questionMapper = [[TSFQuestionMapper alloc] init];
		_competenceMapper = [[TSFCompetenceMapper alloc] init];
	}
    
	return self;
}

- (TSFQuestionnaire *)questionnaireWithDictionary:(NSDictionary *)dictionary {
	TSFQuestionnaire *questionnaire = [[TSFQuestionnaire alloc] init];
    
	questionnaire.questionnaireId = dictionary[@"id"];
	questionnaire.title = dictionary[@"title"];
	questionnaire.questionnaireDescription = dictionary[@"description"];
	questionnaire.subject = dictionary[@"subject"];
	questionnaire.questions = [self.questionMapper questionsWithDictionaryArray:dictionary[@"questions"]];
	questionnaire.competences = [self.competenceMapper competencesWithDictionaryArray:dictionary[@"competences"]];
    
	return questionnaire;
}

- (NSArray *)questionnairesWithDictionaryArray:(NSArray *)dictionaryArray {
	NSMutableArray *questionnaires = [[NSMutableArray alloc] init];
    
	for (NSDictionary *questionnaireDictionary in dictionaryArray) {
		TSFQuestionnaire *questionnaire = [self questionnaireWithDictionary:questionnaireDictionary];
		[questionnaires addObject:questionnaire];
	}
    
	return questionnaires;
}

@end
