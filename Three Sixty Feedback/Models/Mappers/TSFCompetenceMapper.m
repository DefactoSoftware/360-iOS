//
//  TSFCompetenceMapper.m
//  Three Sixty Feedback
//
//  Created by Girgis on 29/01/14.
//  Copyright (c) 2014 Defacto. All rights reserved.
//

#import "TSFCompetenceMapper.h"

@implementation TSFCompetenceMapper

- (id)init {
	self = [super init];
	if (self) {
		_keyBehaviourMapper = [[TSFKeyBehaviourMapper alloc] init];
	}
    
	return self;
}

- (TSFCompetence *)competenceWithDictionary:(NSDictionary *)dictionary {
	TSFCompetence *competence = [[TSFCompetence alloc] init];
    
	competence.competenceId = dictionary[@"id"];
	competence.title = dictionary[@"title"];
	competence.comment = dictionary[@"comment"];
	competence.keyBehaviours = [self.keyBehaviourMapper keyBehavioursWithDictionaryArray:dictionary[@"key_behaviours"]];
    
	return competence;
}

- (NSArray *)competencesWithDictionaryArray:(NSArray *)dictionaryArray {
	NSMutableArray *competences = [[NSMutableArray alloc] init];
    
	for (NSDictionary *competenceDictionary in dictionaryArray) {
		TSFCompetence *competence =
        [self competenceWithDictionary:competenceDictionary];
		[competences addObject:competence];
	}
    
	return competences;
}

- (NSDictionary *)dictionaryWithCompetence:(TSFCompetence *)competence {
	NSMutableDictionary *dictionary = [[NSMutableDictionary alloc] init];
    
	NSArray *keyBehaviourDictionaries = [self.keyBehaviourMapper dictionariesWithKeyBehaviourArray:competence.keyBehaviours];
    
	[dictionary setValue:competence.competenceId forKey:@"id"];
	[dictionary setValue:competence.title forKey:@"title"];
	[dictionary setValue:competence.comment forKey:@"comment"];
	[dictionary setValue:keyBehaviourDictionaries forKey:@"key_behaviours"];
    
	return dictionary;
}

@end
