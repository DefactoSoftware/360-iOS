//
//  TSFKeyBehaviourMapper.h
//  Three Sixty Feedback
//
//  Created by Girgis on 29/01/14.
//  Copyright (c) 2014 Defacto. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "TSFKeyBehaviour.h"

@interface TSFKeyBehaviourMapper : NSObject

+ (TSFKeyBehaviour *)keyBehaviourWithDictionary:(NSDictionary *)dictionary;
+ (NSArray *)keyBehavioursWithDictionaryArray:(NSArray *)dictionaryArray;
+ (NSDictionary *)dictionaryWithKeyBehaviour:(TSFKeyBehaviour *)keyBehaviour;
+ (NSArray *)dictionariesWithKeyBehaviourArray:(NSArray *)keyBehaviours;

@end
