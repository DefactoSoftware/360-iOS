//
//  TSFQuestionMapper.m
//  Three Sixty Feedback
//
//  Created by Girgis on 29/01/14.
//  Copyright (c) 2014 Defacto. All rights reserved.
//

#import "TSFQuestionMapper.h"

@implementation TSFQuestionMapper

+ (TSFQuestion *)questionWithDictionary:(NSDictionary *)dictionary {
    TSFQuestion *question = [[TSFQuestion alloc] init];
    
    question.questionId = dictionary[@"id"];
    question.question = dictionary[@"question"];
    
    return question;
}

+ (NSArray *)questionsWithDictionaryArray:(NSArray *)dictionaryArray {
    NSMutableArray *questions = [[NSMutableArray alloc] init];
    
    for (NSDictionary *questionDictionary in dictionaryArray) {
        TSFQuestion *question = [TSFQuestionMapper questionWithDictionary:questionDictionary];
        [questions addObject:question];
    }
    
    return questions;
}

@end
