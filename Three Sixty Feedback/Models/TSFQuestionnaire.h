//
//  TSFQuestionnaire.h
//  Three Sixty Feedback
//
//  Created by Girgis on 29/01/14.
//  Copyright (c) 2014 Defacto. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "TSFQuestionMapper.h"
#import "TSFCompetenceMapper.h"
#import "TSFAssessor.h"
#import "TSFTemplate.h"

@interface TSFQuestionnaire : TSFTemplate

@property(nonatomic, strong) NSNumber *questionnaireId;
@property(nonatomic, strong) NSString *questionnaireDescription;
@property(nonatomic, strong) NSString *subject;
@property(nonatomic, strong) NSArray *assessors;

- (NSInteger)completedAssessors;
- (BOOL)completed;
- (NSArray *)sortedAssessors;

@end