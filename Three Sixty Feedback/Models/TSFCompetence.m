//
//  TSFCompetence.m
//  Three Sixty Feedback
//
//  Created by Girgis on 29/01/14.
//  Copyright (c) 2014 Defacto. All rights reserved.
//

#import "TSFCompetence.h"

@implementation TSFCompetence

+ (instancetype)competenceWithDictionary:(NSDictionary *)dictionary {
    TSFCompetence *competence = [[TSFCompetence alloc] init];
    
    [competence setValuesForKeysWithDictionary:dictionary];
    
    return competence;
}

- (NSDictionary *)keyMapping {
    return @{
             @"id": @"competenceId",
             @"key_behaviours": @"keyBehaviours"
             };
}

@end