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

  questionnaire.questions =
      [TSFQuestionMapper questionsWithDictionaryArray:dictionary[@"questions"]];
  questionnaire.competences = [TSFCompetenceMapper
      competencesWithDictionaryArray:dictionary[@"competences"]];

  NSMutableDictionary *questionnaireDictionary =
      [[NSMutableDictionary alloc] initWithDictionary:dictionary];
  [questionnaireDictionary removeObjectForKey:@"questions"];
  [questionnaireDictionary removeObjectForKey:@"competences"];
  [questionnaire setValuesForKeysWithDictionary:questionnaireDictionary];

  return questionnaire;
}

- (NSDictionary *)keyMapping {
  return @{
    @"id" : @"questionnaireId", @"description" : @"questionnaireDescription"
  };
}

@end
