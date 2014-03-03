//
//  TSFQuestionnaireService.h
//  Three Sixty Feedback
//
//  Created by Girgis on 29/01/14.
//  Copyright (c) 2014 Defacto. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "TSFAPIClient.h"
#import "TSFQuestionnaireMapper.h"
#import "TSFNetworkingBlocks.h"

static NSString *const TSFAPIEndPointQuestionnaires = @"questionnaires";
static NSString *const TSFAPIEndPointUserQuestionnaires = @"users/me/questionnaires";

@class TSFAPIClient;

@interface TSFQuestionnaireService : NSObject

@property (nonatomic, strong) TSFAPIClient *apiClient;
@property (nonatomic, strong) TSFQuestionnaireMapper *questionnaireMapper;
@property (nonatomic, strong) NSArray *questionnaires;

+ (TSFQuestionnaireService *)sharedService;
- (void)questionnairesWithSuccess:(TSFNetworkingSuccessBlock)success
                          failure:(TSFNetworkingErrorBlock)failure;
- (void)userQuestionnairesWithSuccess:(TSFNetworkingSuccessBlock)success
                              failure:(TSFNetworkingErrorBlock)failure;
- (void)questionnaireWithId:(NSNumber *)questionnaireId
                    success:(TSFNetworkingSuccessBlock)success
                    failure:(TSFNetworkingErrorBlock)failure;

@end