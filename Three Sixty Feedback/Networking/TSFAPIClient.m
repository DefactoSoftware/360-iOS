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
	    _sharedClient =
        [[self alloc] initWithBaseURL:[NSURL URLWithString:TSFAPIBaseURL]];
//        _sharedClient.assessorToken = @"KooSLx35F1ca3Q3F6G8pgw";
        _sharedClient.credentialStore = [[TSFCredentialStore alloc] init];
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

- (AFHTTPRequestOperation *)HTTPRequestOperationWithRequest:(NSURLRequest *)request
                                                    success:(void (^)(AFHTTPRequestOperation *, id))success
                                                    failure:(void (^)(AFHTTPRequestOperation *, NSError *))failure {    
    NSMutableURLRequest *mutableRequest = [request mutableCopy];
    
    if ([self.credentialStore hasStoredCredentials]) {
        [mutableRequest addValue:[self.credentialStore storedEmail]
              forHTTPHeaderField:TSFAPIHeaderFieldFrom];
        [mutableRequest addValue:[self.credentialStore storedToken]
              forHTTPHeaderField:TSFAPIHeaderFieldAuthorization];
    }
    
    return [super HTTPRequestOperationWithRequest:mutableRequest
                                          success:success
                                          failure:failure];
}

@end