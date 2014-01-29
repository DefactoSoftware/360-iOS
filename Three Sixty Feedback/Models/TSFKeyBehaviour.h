//
//  TSFKeyBehaviour.h
//  Three Sixty Feedback
//
//  Created by Girgis on 29/01/14.
//  Copyright (c) 2014 Defacto. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "TSFBaseModel.h"

@interface TSFKeyBehaviour : TSFBaseModel

@property (nonatomic, strong) NSNumber *keyBehaviourId;
@property (nonatomic, strong) NSString *keyBehaviourDescription;
@property (nonatomic, strong) NSNumber *rating;

+ (instancetype) keyBehaviourWithDictionary:(NSDictionary *)dictionary;

@end