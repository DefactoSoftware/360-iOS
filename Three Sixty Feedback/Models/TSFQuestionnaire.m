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
    
    return questionnaire;
}

- (NSDictionary *)keyMapping {
    return @{
             @"id": @"questionnaireId",
             @"description": @"questionnaireDescription"
             };
}

@end
