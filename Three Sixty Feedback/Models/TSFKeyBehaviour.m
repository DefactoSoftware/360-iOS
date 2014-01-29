//
//  TSFKeyBehaviour.m
//  Three Sixty Feedback
//
//  Created by Girgis on 29/01/14.
//  Copyright (c) 2014 Defacto. All rights reserved.
//

#import "TSFKeyBehaviour.h"

@implementation TSFKeyBehaviour

+ (TSFKeyBehaviour *)keyBehaviourWithDictionary:(NSDictionary *)dictionary {
    TSFKeyBehaviour *keyBehaviour = [[TSFKeyBehaviour alloc] init];
    
    [keyBehaviour setValuesForKeysWithDictionary:dictionary];
    
    return keyBehaviour;
}

- (NSDictionary *)keyMapping {
    return @{
             @"id": @"keyBehaviourId",
             @"description": @"keyBehaviourDescription",
             @"key_behaviour_rating": @"rating"
             };
}

@end
