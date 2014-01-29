//
//  TSFQuestionnaire.m
//  Three Sixty Feedback
//
//  Created by Girgis on 29/01/14.
//  Copyright (c) 2014 Defacto. All rights reserved.
//

#import "TSFQuestionnaire.h"

@implementation TSFQuestionnaire

+ (TSFQuestionnaire *)questionnaireWithDictionary:(NSDictionary *)dictionary {
    TSFQuestionnaire *questionnaire = [[TSFQuestionnaire alloc] init];
    
    [questionnaire setValuesForKeysWithDictionary:dictionary];
    [questionnaire initializeQuestions];
    [questionnaire initializeCompetences];
    
    return questionnaire;
}

- (void)initializeQuestions {
    NSMutableArray *questions = [[NSMutableArray alloc] init];
    
    for (NSDictionary *questionDictionary in self.questions) {
        [questions addObject:[TSFQuestion questionWithDictionary:questionDictionary]];
    }
    
    self.questions = questions;
}

- (void)initializeCompetences {
    NSMutableArray *competences = [[NSMutableArray alloc] init];
    
    for (NSDictionary *competenceDictionary in self.competences) {
        [competences addObject:[TSFCompetence competenceWithDictionary:competenceDictionary]];
    }
    
    self.competences = competences;
}

- (NSDictionary *)keyMapping {
    return @{
             @"id": @"questionnaireId",
             @"description": @"questionnaireDescription"
             };
}

@end
