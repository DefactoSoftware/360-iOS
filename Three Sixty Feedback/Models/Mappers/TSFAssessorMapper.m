//
//  TSFAssessorMapper.m
//  Three Sixty Feedback
//
//  Created by Girgis Ghattas on 24-02-14.
//  Copyright (c) 2014 Defacto. All rights reserved.
//

#import "TSFAssessorMapper.h"

@implementation TSFAssessorMapper

- (TSFAssessor *)assessorWithDictionary:(NSDictionary *)dictionary {
    TSFAssessor *assessor = [[TSFAssessor alloc] init];
    assessor.assessorId = dictionary[@"id"];
    assessor.token = dictionary[@"token"];
    assessor.email = dictionary[@"email"];
    assessor.completed = [dictionary[@"completed"] boolValue];
    
    return assessor;
}

- (NSArray *)assessorsWithDictionaryArray:(NSArray *)dictionaryArray {
	NSMutableArray *assessors = [[NSMutableArray alloc] init];
    
	for (NSDictionary *assessorDictionary in dictionaryArray) {
		TSFAssessor *assessor = [self assessorWithDictionary:assessorDictionary];
		[assessors addObject:assessor];
	}
    
	return assessors;
}

@end
