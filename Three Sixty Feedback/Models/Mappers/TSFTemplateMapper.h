//
//  TSFTemplateMapper.h
//  Three Sixty Feedback
//
//  Created by Girgis Ghattas on 03-03-14.
//  Copyright (c) 2014 Defacto. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "TSFQuestionMapper.h"
#import "TSFCompetenceMapper.h"
#import "TSFTemplate.h"

@interface TSFTemplateMapper : NSObject

@property (nonatomic, strong) TSFQuestionMapper *questionMapper;
@property (nonatomic, strong) TSFCompetenceMapper *competenceMapper;

- (TSFTemplate *)templateWithDictionary:(NSDictionary *)dictionary;
- (NSArray *)templatesWithDictionaryArray:(NSArray *)dictionaryArray;

@end
