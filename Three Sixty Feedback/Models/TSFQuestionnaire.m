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
    
    [questionnaire initializeQuestionsWithDictionaries:dictionary[@"questions"]];
    [questionnaire initializeCompetencesWithDictionaries:dictionary[@"competences"]];
    
    NSMutableDictionary *questionnaireDictionary = [[NSMutableDictionary alloc] initWithDictionary:dictionary];
    [questionnaireDictionary removeObjectForKey:@"questions"];
    [questionnaireDictionary removeObjectForKey:@"competences"];
    [questionnaire setValuesForKeysWithDictionary:questionnaireDictionary];
    
    return questionnaire;
}

- (void)initializeQuestionsWithDictionaries:(NSArray *)questionsDictionaries {
    NSMutableArray *questions = [[NSMutableArray alloc] init];
    
    for (NSDictionary *questionDictionary in questionsDictionaries) {
        [questions addObject:[TSFQuestion questionWithDictionary:questionDictionary]];
    }
    
    self.questions = questions;
}

- (void)initializeCompetencesWithDictionaries:(NSArray *)competencesDictionaries {
    NSMutableArray *competences = [[NSMutableArray alloc] init];
    
    for (NSDictionary *competenceDictionary in competencesDictionaries) {
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
