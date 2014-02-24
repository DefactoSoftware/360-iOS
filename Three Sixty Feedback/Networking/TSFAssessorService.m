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
        _sharedService.assessorMapper = [[TSFAssessorMapper alloc] init];
	});
    
	return _sharedService;
}

- (void)completeCurrentAssessmentWithSuccess:(TSFNetworkingSuccessBlock)success
                                     failure:(TSFNetworkingErrorBlock)failure {
	__block TSFNetworkingSuccessBlock _successBlock = success;
	NSString *questionnairesURL = [NSString stringWithFormat:@"%@%@?token=%@",
	                               TSFAPIBaseURL,
	                               TSFAPIEndPointCurrentAssessor,
	                               self.apiClient.assessorToken];
	NSDictionary *completedParameters = @{ @"completed": @YES };
    
	[self.apiClient PUT:questionnairesURL parameters:completedParameters success: ^(AFHTTPRequestOperation *operation, id responseObject) {
	    _successBlock(@YES);
	} failure: ^(AFHTTPRequestOperation *operation, NSError *error) {
	    failure(error);
	}];
}

- (void)assessorsForQuestionnaireId:(NSNumber *)questionnaireId
                        withSuccess:(TSFNetworkingSuccessBlock)success
                            failure:(TSFNetworkingErrorBlock)failure {
    NSString *questionnairesURL = [NSString stringWithFormat:@"%@%@%@%@", TSFAPIBaseURL,
                                   TSFAPIEndPointQuestionnaires,
                                   questionnaireId,
                                   TSFAPIEndPointAssessors];
    
    __block TSFNetworkingSuccessBlock _successBlock = success;
    __weak typeof (self) _self = self;
    
    [self.apiClient GET:questionnairesURL parameters:Nil success:^(AFHTTPRequestOperation *operation, id responseObject) {
        NSArray *assessorsDictionaryArrray = (NSArray *)responseObject;
        NSArray *mappedAssessors = [_self.assessorMapper assessorsWithDictionaryArray:assessorsDictionaryArrray];
        _successBlock(mappedAssessors);
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        
    }];
}

@end
