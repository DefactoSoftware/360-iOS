//
//  TSFCompetenceMapper.m
//  Three Sixty Feedback
//
//  Created by Girgis on 29/01/14.
//  Copyright (c) 2014 Defacto. All rights reserved.
//

#import "TSFCompetenceMapper.h"

@implementation TSFCompetenceMapper

+ (TSFCompetence *)competenceWithDictionary:(NSDictionary *)dictionary {
  TSFCompetence *competence = [[TSFCompetence alloc] init];

  competence.competenceId = dictionary[@"id"];
  competence.title = dictionary[@"title"];
  competence.comment = dictionary[@"comment"];
  competence.keyBehaviours = [TSFKeyBehaviourMapper
      keyBehavioursWithDictionaryArray:dictionary[@"key_behaviours"]];

  return competence;
}

+ (NSArray *)competencesWithDictionaryArray:(NSArray *)dictionaryArray {
  NSMutableArray *competences = [[NSMutableArray alloc] init];

  for (NSDictionary *competenceDictionary in dictionaryArray) {
    TSFCompetence *competence =
        [TSFCompetenceMapper competenceWithDictionary:competenceDictionary];
    [competences addObject:competence];
  }

  return competences;
}

@end
