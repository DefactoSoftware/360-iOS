//
//  TSFAssessorMapper.h
//  Three Sixty Feedback
//
//  Created by Girgis Ghattas on 24-02-14.
//  Copyright (c) 2014 Defacto. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "TSFAssessor.h"

@interface TSFAssessorMapper : NSObject

- (TSFAssessor *)assessorWithDictionary:(NSDictionary *)dictionary;
- (NSArray *)assessorsWithDictionaryArray:(NSArray *)dictionaryArray;

@end
