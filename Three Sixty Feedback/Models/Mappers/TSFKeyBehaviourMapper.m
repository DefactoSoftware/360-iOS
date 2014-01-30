//
//  TSFKeyBehaviourMapper.m
//  Three Sixty Feedback
//
//  Created by Girgis on 29/01/14.
//  Copyright (c) 2014 Defacto. All rights reserved.
//

#import "TSFKeyBehaviourMapper.h"

@implementation TSFKeyBehaviourMapper

+ (TSFKeyBehaviour *)keyBehaviourWithDictionary:(NSDictionary *)dictionary {
	TSFKeyBehaviour *keyBehaviour = [[TSFKeyBehaviour alloc] init];
    
	keyBehaviour.keyBehaviourId = dictionary[@"id"];
	keyBehaviour.keyBehaviourDescription = dictionary[@"description"];
	keyBehaviour.rating = dictionary[@"key_behaviour_rating"];
    
	return keyBehaviour;
}

+ (NSArray *)keyBehavioursWithDictionaryArray:(NSArray *)dictionaryArray {
	NSMutableArray *keyBehaviours = [[NSMutableArray alloc] init];
    
	for (NSDictionary *keyBehaviourDictionary in dictionaryArray) {
		TSFKeyBehaviour *keyBehaviour = [TSFKeyBehaviourMapper
		                                 keyBehaviourWithDictionary:keyBehaviourDictionary];
		[keyBehaviours addObject:keyBehaviour];
	}
    
	return keyBehaviours;
}

+ (NSDictionary *)dictionaryWithKeyBehaviour:(TSFKeyBehaviour *)keyBehaviour {
	return @{
             @"id": keyBehaviour.keyBehaviourId,
             @"description": keyBehaviour.keyBehaviourDescription,
             @"key_behaviour_rating": keyBehaviour.rating
             };
}

@end
