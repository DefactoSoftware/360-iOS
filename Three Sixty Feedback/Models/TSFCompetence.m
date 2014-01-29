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
    
    competence.keyBehaviours = [TSFKeyBehaviourMapper keyBehavioursWithDictionaryArray:dictionary[@"key_behaviours"]];
    
    NSMutableDictionary *competenceDictionary = [[NSMutableDictionary alloc] initWithDictionary:dictionary];
    [competenceDictionary removeObjectForKey:@"key_behaviours"];
    [competence setValuesForKeysWithDictionary:competenceDictionary];
    
    return competence;
}

- (NSDictionary *)keyMapping {
    return @{
             @"id": @"competenceId"
             };
}

@end