//
//  TSFCompetenceMapper.h
//  Three Sixty Feedback
//
//  Created by Girgis on 29/01/14.
//  Copyright (c) 2014 Defacto. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "TSFCompetence.h"

@interface TSFCompetenceMapper : NSObject

@property (nonatomic, strong) TSFKeyBehaviourMapper *keyBehaviourMapper;

- (TSFCompetence *)competenceWithDictionary:(NSDictionary *)dictionary;
- (NSArray *)competencesWithDictionaryArray:(NSArray *)dictionaryArray;
- (NSDictionary *)dictionaryWithCompetence:(TSFCompetence *)competence;

@end
