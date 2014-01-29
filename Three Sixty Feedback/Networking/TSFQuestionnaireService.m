//
//  TSFQuestionnaireService.m
//  Three Sixty Feedback
//
//  Created by Girgis on 29/01/14.
//  Copyright (c) 2014 Defacto. All rights reserved.
//

#import "TSFQuestionnaireService.h"

@implementation TSFQuestionnaireService

+ (instancetype)sharedService {
	static TSFQuestionnaireService *_sharedService = nil;
	static dispatch_once_t onceToken;
	dispatch_once(&onceToken, ^{
	    _sharedService = [[self alloc] init];
	    _sharedService.apiClient = [TSFAPIClient sharedClient];
	});
    
	return _sharedService;
}

- (void)questionnairesWithToken:(NSString *)token
                        success:(TSFQuestionnairesSuccessBlock)success
                        failure:(TSFNetworkingErrorBlock)failure {
	NSString *questionnairesURL = [NSString
	                               stringWithFormat:@"%@%@", TSFAPIBaseURL, TSFAPIEndPointQuestionnaires];
	NSDictionary *parameters = @{ @"token" : token };
    
	[self.apiClient GET:questionnairesURL parameters:parameters success: ^(AFHTTPRequestOperation *operation, id responseObject) {
	    success([TSFQuestionnaireMapper questionnairesWithDictionaryArray:responseObject]);
	}
     
	            failure:
	 ^(AFHTTPRequestOperation *operation, NSError *error) { failure(error); }];
}

@end
