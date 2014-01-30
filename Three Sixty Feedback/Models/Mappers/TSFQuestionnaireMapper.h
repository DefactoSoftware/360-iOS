//
//  TSFQuestionnaireMapper.h
//  Three Sixty Feedback
//
//  Created by Girgis on 29/01/14.
//  Copyright (c) 2014 Defacto. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "TSFQuestionnaire.h"
#import "TSFQuestionMapper.h"
#import "TSFCompetenceMapper.h"

@interface TSFQuestionnaireMapper : NSObject

@property (nonatomic, strong) TSFQuestionMapper *questionMapper;
@property (nonatomic, strong) TSFCompetenceMapper *competenceMapper;

- (TSFQuestionnaire *)questionnaireWithDictionary:(NSDictionary *)dictionary;
- (NSArray *)questionnairesWithDictionaryArray:(NSArray *)dictionaryArray;

@end
