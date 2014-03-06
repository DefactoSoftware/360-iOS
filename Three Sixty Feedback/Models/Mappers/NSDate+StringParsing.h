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
+ (NSDate *)dateWithISO8601String:(NSString *)dateString
                        formatter:(NSDateFormatter *)dateFormatter;
+ (NSDate *)dateFromString:(NSString *)dateString
                withFormat:(NSString *)dateFormat;
+ (NSDate *)dateFromString:(NSString *)dateString
                withFormat:(NSString *)dateFormat
                 formatter:(NSDateFormatter *)dateFormatter;
- (NSString *)localizedString;

@end
