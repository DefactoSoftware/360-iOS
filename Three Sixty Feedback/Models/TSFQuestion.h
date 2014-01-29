//
//  TSFQuestion.h
//  Three Sixty Feedback
//
//  Created by Girgis on 29/01/14.
//  Copyright (c) 2014 Defacto. All rights reserved.
//

#import "TSFBaseModel.h"

@interface TSFQuestion : TSFBaseModel

@property (nonatomic, strong) NSNumber *questionId;
@property (nonatomic, strong) NSString *question;

+ (instancetype) questionWithDictionary:(NSDictionary *)dictionary;

@end
