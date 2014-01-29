//
//  TSFQuestion.m
//  Three Sixty Feedback
//
//  Created by Girgis on 29/01/14.
//  Copyright (c) 2014 Defacto. All rights reserved.
//

#import "TSFQuestion.h"

@implementation TSFQuestion

+ (instancetype)questionWithDictionary:(NSDictionary *)dictionary {
    TSFQuestion *question = [[TSFQuestion alloc] init];
    
    [question setValuesForKeysWithDictionary:dictionary];
    
    return question;
}

- (NSDictionary *)keyMapping {
    return @{
             @"id": @"questionId"
             };
}

@end
