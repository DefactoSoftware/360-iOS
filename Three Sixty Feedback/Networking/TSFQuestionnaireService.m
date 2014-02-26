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
	    _sharedService.questionnaireMapper = [[TSFQuestionnaireMapper alloc] init];
	});
    
	return _sharedService;
}

- (void)questionnairesWithSuccess:(TSFNetworkingSuccessBlock)success
                          failure:(TSFNetworkingErrorBlock)failure {
	NSString *questionnairesURL = [NSString
	                               stringWithFormat:@"%@%@", TSFAPIBaseURL, TSFAPIEndPointQuestionnaires];
	NSDictionary *parameters = @{ @"token" : self.apiClient.assessorToken };
    
	[self.apiClient GET:questionnairesURL parameters:parameters success: ^(AFHTTPRequestOperation *operation, id responseObject) {
        NSArray *questionnaires = [self.questionnaireMapper questionnairesWithDictionaryArray:responseObject];
        self.questionnaires = questionnaires;
        success(questionnaires);
	}
     
	            failure:
	 ^(AFHTTPRequestOperation *operation, NSError *error) { failure(error); }];
}

- (void)userQuestionnairesWithSuccess:(TSFNetworkingSuccessBlock)success
                              failure:(TSFNetworkingErrorBlock)failure {
    __block TSFNetworkingSuccessBlock _success = success;
    __block TSFNetworkingErrorBlock _failure = failure;
    __block typeof (self) _self = self;
    
    [self.apiClient GET:TSFAPIEndPointUserQuestionnaires parameters:nil success:^(AFHTTPRequestOperation *operation, id responseObject) {
        NSArray *questionnaires = [_self.questionnaireMapper questionnairesWithDictionaryArray:(NSArray *)responseObject];
        _success(questionnaires);
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        _failure(error);
    }];
}

- (void)questionnaireWithId:(NSNumber *)questionnaireId
                    success:(TSFNetworkingSuccessBlock)success
                    failure:(TSFNetworkingErrorBlock)failure {
    NSString *url = [NSString stringWithFormat:@"%@/%@", TSFAPIEndPointQuestionnaires, questionnaireId];
    
    __block TSFNetworkingSuccessBlock _success = success;
    __block TSFNetworkingErrorBlock _failure = failure;
    __weak typeof (self) _self = self;
    
    [self.apiClient GET:url parameters:nil success:^(AFHTTPRequestOperation *operation, id responseObject) {
        TSFQuestionnaire *questionnaire = [_self.questionnaireMapper questionnaireWithDictionary:responseObject];
        _success(questionnaire);
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        _failure(error);
    }];
}

@end