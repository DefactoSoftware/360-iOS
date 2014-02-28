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
    
    long originalRed = [self hash] % colorOffset;
    long originalGreen = [self hash] & colorOffset;
    long originalBlue = colorOffset;
    
    long adaptedRed = startColor + originalRed;
    long adaptedGreen = startColor + originalGreen - originalRed;
    long adaptedBlue = startColor + originalBlue - originalGreen;
    
    return [UIColor colorWithRed:(float)adaptedRed/255 green:(float)adaptedGreen/255 blue:(float)adaptedBlue/255 alpha:1];
}


@end
