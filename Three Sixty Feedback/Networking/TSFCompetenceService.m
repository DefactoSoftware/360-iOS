//
//  TSFCompetenceService.m
//  Three Sixty Feedback
//
//  Created by Girgis on 30/01/14.
//  Copyright (c) 2014 Defacto. All rights reserved.
//

#import "TSFCompetenceService.h"

@implementation TSFCompetenceService

+ (instancetype)sharedService {
	static TSFCompetenceService *_sharedService = nil;
	static dispatch_once_t onceToken;
	dispatch_once(&onceToken, ^{
	    _sharedService = [[self alloc] init];
	    _sharedService.apiClient = [TSFAPIClient sharedClient];
	    _sharedService.competenceMapper = [[TSFCompetenceMapper alloc] init];
	});
    
	return _sharedService;
}

- (void)updateCompetence:(TSFCompetence *)competence
        forQuestionnaire:(TSFQuestionnaire *)questionnaire
             withSuccess:(TSFNetworkingSuccessBlock)success
                 failure:(TSFNetworkingErrorBlock)failure {
	__block TSFNetworkingSuccessBlock _successBlock = success;
	__block TSFNetworkingErrorBlock _failureBlock = failure;
    
	NSString *requestUrl = [NSString stringWithFormat:@"%@%@/%@/%@/%@?token=%@",
	                        TSFAPIBaseURL,
	                        TSFAPIEndPointQuestionnaires,
	                        questionnaire.questionnaireId,
	                        TSFAPIEndPointCompetences,
	                        competence.competenceId,
	                        self.apiClient.assessorToken];
	NSDictionary *competenceDictionary = [self.competenceMapper dictionaryWithCompetence:competence];
    
	[self.apiClient PUT:requestUrl
	         parameters:competenceDictionary
	            success: ^(AFHTTPRequestOperation *operation, id responseObject) {
                    TSFCompetence *updatedCompetence = [self.competenceMapper competenceWithDictionary:(NSDictionary *)responseObject];
                    _successBlock(updatedCompetence);
                } failure: ^(AFHTTPRequestOperation *operation, NSError *error) {
                    _failureBlock(error);
                }];
}

@end
