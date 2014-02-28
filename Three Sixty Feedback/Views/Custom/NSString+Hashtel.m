//
//  NSString+Hashtel.m
//  Three Sixty Feedback
//
//  Created by Girgis Ghattas on 28-02-14.
//  Copyright (c) 2014 Defacto. All rights reserved.
//

#import "NSString+Hashtel.h"

@implementation NSString (Hashtel)

- (UIColor *)hashtel {
    NSInteger startColor = 100;
    NSInteger colorOffset = 164;
    
    long originalRed = [self hashCode] % colorOffset;
    long originalGreen = [self hashCode] & colorOffset;
    long originalBlue = colorOffset;
    
    long adaptedRed = startColor + originalRed;
    long adaptedGreen = startColor + originalGreen - originalRed;
    long adaptedBlue = startColor + originalBlue - originalGreen;
    
    return [UIColor colorWithRed:(float)adaptedRed/255 green:(float)adaptedGreen/255 blue:(float)adaptedBlue/255 alpha:1];
}

- (NSInteger)hashCode {
    NSMutableArray *stringBuffer = [NSMutableArray arrayWithCapacity:[self length]];
    for (NSInteger i = 0; i < [self length]; i++) {
        [stringBuffer addObject:[NSString stringWithFormat:@"%C", [self characterAtIndex:i]]];
    }
    
    __block NSInteger memo = [stringBuffer[0] characterAtIndex:0];
    
	for (NSInteger i = 1; i < [stringBuffer count]; i++) {
        NSString *obj = stringBuffer[i];
        NSUInteger objHashCode = [obj characterAtIndex:0];
        
        NSUInteger hash = ((memo << 5) - memo) + objHashCode;
        memo = labs(hash & hash);
	}
    
    return memo;
}

@end