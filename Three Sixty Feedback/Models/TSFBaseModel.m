//
//  TSFBaseModel.m
//  Three Sixty Feedback
//
//  Created by Girgis on 29/01/14.
//  Copyright (c) 2014 Defacto. All rights reserved.
//

#import "TSFBaseModel.h"

@implementation TSFBaseModel

- (NSDictionary *)keyMapping {
    return @{};
}

- (void)setValue:(id)value forKey:(NSString *)key {
    NSString *mappedKey = [self keyMapping][key];
    if (mappedKey) {
        [super setValue:value forKey:mappedKey];
    } else {
        [super setValue:value forKey:key];
    }
}

@end
