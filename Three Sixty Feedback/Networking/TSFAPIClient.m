//
//  TSFAPIClient.m
//  Three Sixty Feedback
//
//  Created by Girgis on 28/01/14.
//  Copyright (c) 2014 Defacto. All rights reserved.
//

#import "TSFAPIClient.h"

@implementation TSFAPIClient

+ (instancetype)sharedClient {
	static TSFAPIClient *_sharedClient = nil;
	static dispatch_once_t onceToken;
	dispatch_once(&onceToken, ^{
	    _sharedClient = [[self alloc] initWithBaseURL:[NSURL URLWithString:TSFAPIBaseURL]];
        _sharedClient.assessorToken = @"jqBFK-bUPa0M2yX-XrEO2A";
	});
    
	return _sharedClient;
}

- (void)setAssessorTokenWithURL:(NSURL *)url {
	NSError *regexError = nil;
	NSRegularExpression *regex = [NSRegularExpression regularExpressionWithPattern:@"token=([^&]*)"
	                                                                       options:0
	                                                                         error:&regexError];
	NSString *input = [url description];
	[regex enumerateMatchesInString:input
	                        options:0
	                          range:NSMakeRange(0, [input length])
	                     usingBlock: ^(NSTextCheckingResult *result, NSMatchingFlags flags, BOOL *stop) {
                             if ([result numberOfRanges] > 1) {
                                 NSRange accessTokenRange = [result rangeAtIndex:1];
                                 self.assessorToken = [input substringWithRange:accessTokenRange];
                             }
                         }];
}

@end
