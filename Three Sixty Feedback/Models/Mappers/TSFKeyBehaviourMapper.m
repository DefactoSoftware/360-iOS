//
//  TSFKeyBehaviourMapper.m
//  Three Sixty Feedback
//
//  Created by Girgis on 29/01/14.
//  Copyright (c) 2014 Defacto. All rights reserved.
//

#import "TSFKeyBehaviourMapper.h"

@implementation TSFKeyBehaviourMapper

- (TSFKeyBehaviour *)keyBehaviourWithDictionary:(NSDictionary *)dictionary {
	TSFKeyBehaviour *keyBehaviour = [[TSFKeyBehaviour alloc] init];
    
	keyBehaviour.keyBehaviourId = dictionary[@"id"];
	keyBehaviour.keyBehaviourDescription = dictionary[@"description"];
	keyBehaviour.rating = dictionary[@"key_behaviour_rating"];
    
	return keyBehaviour;
}

- (NSArray *)keyBehavioursWithDictionaryArray:(NSArray *)dictionaryArray {
	NSMutableArray *keyBehaviours = [[NSMutableArray alloc] init];
    
	for (NSDictionary *keyBehaviourDictionary in dictionaryArray) {
		TSFKeyBehaviour *keyBehaviour = [self keyBehaviourWithDictionary:keyBehaviourDictionary];
		[keyBehaviours addObject:keyBehaviour];
	}
    
	return keyBehaviours;
}

- (NSDictionary *)dictionaryWithKeyBehaviour:(TSFKeyBehaviour *)keyBehaviour {
	NSMutableDictionary *dictionary = [[NSMutableDictionary alloc] init];
    
	[dictionary setValue:keyBehaviour.keyBehaviourId forKey:@"id"];
	[dictionary setValue:keyBehaviour.keyBehaviourDescription forKey:@"description"];
	[dictionary setValue:keyBehaviour.rating forKey:@"key_behaviour_rating"];
    
	return dictionary;
}

- (NSArray *)dictionariesWithKeyBehaviourArray:(NSArray *)keyBehaviours {
	NSMutableArray *dictionaries = [[NSMutableArray alloc] init];
    
	for (TSFKeyBehaviour *keyBehaviour in keyBehaviours) {
		NSDictionary *dictionary = [self dictionaryWithKeyBehaviour:keyBehaviour];
		[dictionaries addObject:dictionary];
	}
    
	return dictionaries;
}

@end
