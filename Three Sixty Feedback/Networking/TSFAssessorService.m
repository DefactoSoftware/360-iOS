//
//  TSFAssessorService.m
//  Three Sixty Feedback
//
//  Created by Girgis on 29/01/14.
//  Copyright (c) 2014 Defacto. All rights reserved.
//

#import "TSFAssessorService.h"

@implementation TSFAssessorService

+ (instancetype)sharedService {
	static TSFAssessorService *_sharedService = nil;
	static dispatch_once_t onceToken;
	dispatch_once(&onceToken, ^{
	    _sharedService = [[self alloc] init];
	    _sharedService.apiClient = [TSFAPIClient sharedClient];
	});
    
	return _sharedService;
}

- (void)completeCurrentAssessmentWithToken:(NSString *)token
                                   success:(TSFNetworkingSuccessBlock)success
                                   failure:(TSFNetworkingErrorBlock)failure {
	__block TSFNetworkingSuccessBlock _successBlock = success;
	NSString *questionnairesURL = [NSString stringWithFormat:@"%@%@?token=%@", TSFAPIBaseURL, TSFAPIEndPointCurrentAssessor, token];
	NSDictionary *completedParameters = @{ @"completed": @YES };
    
	[self.apiClient PUT:questionnairesURL parameters:completedParameters success: ^(AFHTTPRequestOperation *operation, id responseObject) {
	    _successBlock(@YES);
	} failure: ^(AFHTTPRequestOperation *operation, NSError *error) {
	    failure(error);
	}];
}

@end
