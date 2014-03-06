//
//  NSDate+StringParsing.m
//  Three Sixty Feedback
//
//  Created by Girgis Ghattas on 25-02-14.
//  Copyright (c) 2014 Defacto. All rights reserved.
//

#import "NSDate+StringParsing.h"

static NSString *const TSFDateTimeFormat = @"dd-MM-yyyy HH:mm";
static NSString *const TSFDateTimeParseFormat = @"yyyy-MM-dd'T'HH:mm:ss.SSSZ";

@implementation NSDate (StringParsing)

+ (NSDate *)dateWithISO8601String:(NSString *)dateString
{
    if (!dateString) return nil;
    if ([dateString hasSuffix:@"Z"]) {
        dateString = [[dateString substringToIndex:(dateString.length-1)] stringByAppendingString:@"-0000"];
    }
    return [self dateFromString:dateString
                     withFormat:TSFDateTimeParseFormat];
}

+ (NSDate *)dateWithISO8601String:(NSString *)dateString
                        formatter:(NSDateFormatter *)dateFormatter {
    if (!dateString) return nil;
    if ([dateString hasSuffix:@"Z"]) {
        dateString = [[dateString substringToIndex:(dateString.length-1)] stringByAppendingString:@"-0000"];
    }
    return [self dateFromString:dateString
                     withFormat:TSFDateTimeParseFormat
                      formatter:dateFormatter];
}

+ (NSDate *)dateFromString:(NSString *)dateString
                withFormat:(NSString *)dateFormat
{
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:dateFormat];
    NSDate *date = [dateFormatter dateFromString:dateString];
    return date;
}

+ (NSDate *)dateFromString:(NSString *)dateString
                withFormat:(NSString *)dateFormat
                 formatter:(NSDateFormatter *)dateFormatter {
    [dateFormatter setDateFormat:dateFormat];
    NSDate *date = [dateFormatter dateFromString:dateString];
    return date;
}

- (NSString *)localizedString {
    NSString *string  =[NSDateFormatter localizedStringFromDate:self
                                                      dateStyle:NSDateFormatterMediumStyle
                                                      timeStyle:NSDateFormatterShortStyle];
    return string;
}

@end
