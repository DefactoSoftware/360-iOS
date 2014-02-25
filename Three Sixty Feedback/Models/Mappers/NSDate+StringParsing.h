//
//  NSDate+StringParsing.h
//  Three Sixty Feedback
//
//  Created by Girgis Ghattas on 25-02-14.
//  Copyright (c) 2014 Defacto. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSDate (StringParsing)

+ (NSDate *)dateWithISO8601String:(NSString *)dateString;
+ (NSDate *)dateFromString:(NSString *)dateString
                withFormat:(NSString *)dateFormat;

+ (NSString *)stringFromDate:(NSDate *)date;

@end
