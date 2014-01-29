//
//  TSFQuestionMapper.h
//  Three Sixty Feedback
//
//  Created by Girgis on 29/01/14.
//  Copyright (c) 2014 Defacto. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "TSFQuestion.h"

@interface TSFQuestionMapper : NSObject

+ (TSFQuestion *)questionWithDictionary:(NSDictionary *)dictionary;
+ (NSArray *)questionsWithDictionaryArray:(NSArray *)dictionaryArray;

@end
