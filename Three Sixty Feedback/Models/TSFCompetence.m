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
    [competence initializeKeyBehaviours];
    
    return competence;
}

- (void)initializeKeyBehaviours {
    NSMutableArray *keyBehaviours = [[NSMutableArray alloc] init];
    
    for (NSDictionary *keyBehaviourDictionary in self.keyBehaviours) {
        TSFKeyBehaviour *keyBehaviour = [TSFKeyBehaviour keyBehaviourWithDictionary:keyBehaviourDictionary];
        [keyBehaviours addObject:keyBehaviour];
    }
    
    self.keyBehaviours = keyBehaviours;
}

- (NSDictionary *)keyMapping {
    return @{
             @"id": @"competenceId",
             @"key_behaviours": @"keyBehaviours"
             };
}

@end