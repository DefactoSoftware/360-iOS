//
//  TSFQuestionnaire.h
//  Three Sixty Feedback
//
//  Created by Girgis on 29/01/14.
//  Copyright (c) 2014 Defacto. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "TSFBaseModel.h"

@interface TSFQuestionnaire : TSFBaseModel

@property (nonatomic, strong) NSNumber *questionnaireId;
@property (nonatomic, strong) NSString *title;
@property (nonatomic, strong) NSString *questionnaireDescription;
@property (nonatomic, strong) NSString *subject;
@property (nonatomic, strong) NSArray *questions;
@property (nonatomic, strong) NSArray *competences;

+ (instancetype) questionnaireWithDictionary:(NSDictionary *)dictionary;

@end